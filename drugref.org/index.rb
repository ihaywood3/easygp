require 'bluecloth'
require 'sinatra'
require 'pg'
$conn = PG.connect({:dbname=>'drugs'})

helpers do
  def sql_option(table,main_field,val="nil")
    @options = $conn.exec("select * from drugs.#{table}")
    templ = <<-eos
%select{:name=>"#{main_field}"}
  - @options.each do |o|
    %option{:value=>o["pk"],:selected=>o["pk"]==#{val}}= o["#{main_field}"]
eos
    haml templ, :layout=>false
  end

  def autocomplete(name,query,value="")
    templ = <<-eos
%input{:type=>"text",:name=>"#{name}",:autocomplete=>"off",:value=>"#{value}",:size=>60}
%div.shadow##{name}_shadow
  %div.output##{name}_output
:javascript
  init("#{name}","#{query}");
eos
    haml templ, :layout=>false
  end

  def markdown(text)
    bc  = BlueCloth::new(text)
    return bc.to_html
  end
end


get '/search_atc' do
  if request["q"]
    @atcs = $conn.exec("select * from drugs.atc where atcname ilike $$#{request['q']}%$$")
  else
    @atcs = []
  end
  if request["xhr"] == "1"
    @atcs.map { |n| "#{n['atcname']} (#{n['atccode']})"}.join("\n")
  else
    haml :atcs
  end
end

get '/ajax/:table/:field' do |tbl,field|
	$conn.exec("select #{field} from #{tbl} where #{field} ilike $$#{request['q']}%$$").map {|n| n[field]}.join("\n")
end


get '/search_sources' do 
  l = $conn.exec("select * from drugs.sources where source ilike $$%#{request['q']}%$$ limit 20").map do |r|
    s = "##{r['pk']}: #{markdown(r['source'])}"
    s.tr("\n\r\t","   ")
  end
  l.join("\n")
end

get 'list_sources' do
  @notice = nil
  @sources = $conn.exec("select * from drugs.sources")
  haml :sources
end

get 'new_source' do
  haml :new_source
end

get 'edit_source/:pk' do |pk|
  @source = $conn.exec("select * from drugs.sources = #{pk}")
  haml :edit_source
end

post 'create_source' do
  s = request['source']
  s.gsub!("$s$","naughty-naughty")
  return 500 unless request['source_category'] =~ /^[paimos]$/ # security check
  sql = <<-eos
  insert into drugs.sources values (source,source_category) values
  ($s$#{s}$x$,'#{request['source_category']}')
eos
  $conn.exec('begin')
  $conn.exec(sql)
  $conn.exec('commit')
  @notice = "new source created"
  @sources = $conn.exec("select * from drugs.sources")
  haml :sources
end

post 'update_source' do
  s = request['source']
  s.gsub!("$s$","naughty-naughty")
  $conn.exec("update drugs.sources set source=$s$#{s}$s$ where pk=#{request['pk']}")
  @notice = "source updated"
  @sources = $conn.exec("select * from drugs.sources")
  haml :sources
end


get '/show/:atc' do |atc|
  @topics = $conn.exec("select * from drugs.topic where target='h' order by pk")
  sql = <<-eos
select * from drugs.vwinfo where atccode = '#{atc}'
eos
  @info = {}
  @atc = $conn.exec("select * from drugs.atc where atccode = '#{atc}' limit 1")[0]
  $conn.exec(sql).each do |n|
    sql2 = <<-eos
select a.atcname, a.atccode from 
drugs.atc a,drugs.link_atc_info l 
where a.atccode = l.atccode and #{n['pk']} = l.fk_info and l.atccode <> '#{n['actual_atccode']}'
eos
    n['other_atcs'] = $conn.exec(sql2)
    n['sources'] = $conn.exec("select s.* from drugs.sources s, drugs.link_info_source lis where lis.fk_info = #{n['pk']} and lis.fk_source = s.pk")
    @info[n['fk_topic']] = [] unless @info[n['fk_topic']]
    @info[n['fk_topic']] << n
  end
  haml :show_atc
end

get '/new_info' do
  @status = nil
  @link = '/create_info'
  @info = {"comment"=>"","fk_topic"=>request["fk_topic"],"fk_severity"=>-1,"fk_pharmacologic_mechanism"=>1,"fk_evidence_level"=>1,"fk_patient_category"=>1,"pk"=>-1}
  @topic_name = $conn.exec("select title from drugs.topic where pk = #{request['fk_topic']}")[0]["title"]
  @atcs = [{"atccode"=>request["atc"]}]
  @atcs[0]["atcname"] = $conn.exec("select atcname from drugs.atc where atccode = '#{request['atc']}'")[0]["atcname"]
  @sources = []
  haml :edit_info
end

get '/edit_info/:pk' do |pk|
  @status = nil
  @link = '/update_info'
  @info = $conn.exec("select * from drugs.vwinfo where pk = #{pk}")[0]
  @topic_name = $conn.exec("select title from drugs.topic where pk = #{@info['fk_topic']}")[0]["title"]
  @atcs = $conn.exec("select a.* from drugs.atc a, drugs.link_atc_info l where l.atccode = a.atccode and l.fk_info = #{pk}") 
  @sources = []
  haml :edit_info
end

post '/delete_info' do 
  $conn.exec("delete from drugs.link_atc_info where fk_info=#{request['fk_info']}")
  $conn.exec("delete from drugs.info where pk=#{request['fk_info']}")
  redirect "/show/#{request['original_atc']}"
end

def do_atcs(pk)
  $conn.exec("delete from drugs.link_atc_info where fk_info = #{pk}")
  i = 1
  while not request["atc#{i}"].nil?
    p request["atc#{i}"]
    /\(([A-Z][0-9A-Z]+)\)/ =~ request["atc#{i}"]
    $conn.exec("insert into drugs.link_atc_info (fk_info,atccode) values (#{pk},'#{$1}')") if $1
    i += 1
  end
end

post '/update_info' do
  comment = request['comment']
  comment.gsub!("$comment$","naughty-naughty")
  $conn.exec("begin")
  sql = <<eos
update drugs.info set
  comment=$comment$#{comment}$comment$,
  fk_topic=#{request['fk_topic']},
  fk_severity=#{request['severity']},
  fk_pharmacologic_mechanism=#{request['mechanism']},
  fk_patient_category=#{request['category']},
  fk_evidence_level=#{request['evidence_level']}
where pk=#{request["pk"]}
eos
  p sql
  $conn.exec(sql)
  #do_sources(request["pk"])
  $conn.exec("commit")
  atcs = $exec.conn("select atccode from drugs.link_atc_info where fk_info=#{request["pk"]}")
  redirect "/show/#{atcs[0]['atccode']}"
end

post '/create_info' do
  comment = request['comment']
  comment.sub!("$comment$","naughty-naughty")
  $conn.exec("begin")
  ret = $conn.exec <<eos
insert into drugs.info(comment,fk_topic,fk_severity,fk_pharmacologic_mechanism,fk_patient_category,fk_evidence_level) 
values ($comment$#{comment}$comment$,#{request['fk_topic']},#{request['severity']},#{request['mechanism']},
#{request['category']},#{request['evidence_level']}) returning (pk)
eos
  do_atcs(ret[0]["pk"])
  #do_sources(ret[0]["pk"])
  $conn.exec("commit")
  /\(([A-Z][0-9A-Z]+)\)/ =~ request['atc1']
  redirect "/show/#{$1}"
end

get '/' do
  haml :welcome
end

__END__

@@ layout
%html
  %head
    %title DrugRef
    %script{:type=>"text/javascript",:src=>"/autocomplete.js"}
    %link{:rel=>"stylesheet",:type=>"text/css",:href=>"/style.css"}
  %body
    = yield

@@ atcs
%form{:method=>'get',:action=>'/search_atc'}
  %p
    Search:
    %input{:type=>'text',:name=>'q'}
%table
  - @atcs.each do |a|
    %tr
      %td= a['atccode']
      %td
        %a{:href=>'/show/'+a['atccode']}= a['atcname']
