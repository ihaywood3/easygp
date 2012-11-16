#!/usr/bin/ruby

require 'rexml/document'
require 'rexml/formatters/pretty'
require 'csv'
require 'pg'

def load_xml()
	return REXML::Document.new(File.new("/home/ian/Downloads/2012-11-XML.xml"))
end

def create_mbs_item(fh,item)
  fh.write("insert into billing.fee_schedule (descriptor, mbs_item, \"group\") values ($$#{item['descriptor']}$$,'#{item['item']}','#{item['group']}');\n")
  if item['fee'].nil? or item['fee'] == ''
      fh.write("update billing.fee_schedule set derived_fee = $$#{item['derived']}$$ where pk = currval('billing.fee_schedule_pk_seq');\n")
    else
      fh.write("insert into billing.prices (fk_fee_schedule, price, fk_lu_billing_type) values (currval('billing.fee_schedule_pk_seq'),'#{item['fee']}',8);\n")
    end
end

def run(doc)
  conn = PGconn.open(:dbname => "easygp")
  pp = REXML::Formatters::Pretty.new
  update_script = File.open("mbs_update.sql","w")
  create_script = File.open("mbs_create.sql","w")
  doc.each_element("MBS_XML/Data") do |data|
    item = {}
    data.each_element("Description") { |e| item['descriptor'] = e.text }
    data.each_element("ItemNum") { |e| item['item'] = e.text }
    data.each_element("Group") { |e| item['group'] = e.text }
    data.each_element("ScheduleFee") { |e| item['fee'] = e.text }
    data.each_element("DerivedFee") {|e| item['derived'] = e.text }
    create_mbs_item(create_script,item)
    res = conn.exec("select * from billing.fee_schedule where mbs_item='#{item['item']}'")
    if res.ntuples() == 0
      create_mbs_item(update_script,item)
    else
      if res[0]['descriptor'] != item['descriptor'] 
        update_script.write("update billing.fee_schedule set descriptor=$$#{item['descriptor']}$$ where mbs_item='#{item['item']}';\n")
      end
      if item['fee'].nil? or item['fee'] == ''
        if res[0]['derived_fee'] != item['derived']
          update_script.write("update billing.fee_schedule set derived_fee=$$#{item['derived']}$$ where mbs_item='#{item['item']}';\n")
        end
      else
        update_script.write("update billing.prices set price='#{item['fee']}' from billing.fee_schedule where mbs_item='#{item['item']}' and fee_schedule.pk = prices.fk_fee_schedule and fk_lu_billing_type=8;\n")
      end
    end  
  end
  update_script.close
  create_script.close
end

def both()
  doc = load_xml()
  run(doc)
end

def create_ama(item,descriptor,price,fh)
  fh.write("insert into billing.fee_schedule (descriptor, ama_item) values ($$#{descriptor}$$, '#{item}');\n")
  fh.write("insert into billing.prices (fk_fee_schedule, price, fk_lu_billing_type) values (currval('billing.fee_schedule_pk_seq'),'#{price}',1);\n") unless price.nil? or price == ''
end

def mbs_with_ama(ama_item,price,mbs_item,fh)
  fh.write("update billing.fee_schedule set ama_item = '#{ama_item}' where mbs_item = '#{mbs_item}';\n")
  fh.write("insert into billing.prices (fk_fee_schedule, price, fk_lu_billing_type) values ((select pk from billing.fee_schedule where mbs_item = '#{mbs_item}' limit 1), '#{price}', 1);\n") unless price.nil? or price==''
end

def mbs_with_ama_update(ama_item,price,mbs_item,conn,update_script)
  res = conn.exec("select * from billing.fee_schedule where ama_item='#{ama_item}' and mbs_item='#{mbs_item}';\n")
  if res.ntuples() > 0
    return if price.nil? or price==''
    res = conn.exec("select * from billing.prices, billing.fee_schedule where fee_schedule.pk = prices.fk_fee_schedule and mbs_item='#{mbs_item}' and ama_item='#{ama_item}' and fk_lu_billing_type=1")
    if res.ntuples() > 0
      update_script.write("update billing.prices set price='#{price}' from billing.fee_schedule where ama_item='#{ama_item}' and mbs_item='#{mbs_item}' and fee_schedule.pk = prices.fk_fee_schedule and fk_lu_billing_type=1;\n")
    else
      update_script.write("insert into billing.prices (fk_fee_schedule, price, fk_lu_billing_type) values ((select pk from billing.fee_schedule where mbs_item = '#{mbs_item}' limit 1), '#{price}', 1);\n")
    end
  else
    mbs_with_ama(ama_item,price,mbs_item,update_script)
  end
end


def load_ama()
  f = File.open('/home/ian/Downloads/amanov2012.csv', 'rb').read
  f.gsub!("\x92","'")
  conn = PGconn.open(:dbname => "easygp")
  update_script = File.open("ama_update.sql","w")
  create_script = File.open("ama_create.sql","w")
  conn = 
  CSV::Reader.parse(f) do |row|
    if row[7] == "" or row[7].nil?
      # there's no matching MBS item
      create_ama(row[0],row[1],row[2],create_script)
      res = conn.exec("select * from billing.fee_schedule where ama_item='#{row[0]}'")
      if res.ntuples() > 0 
        # existing row
        if res[0]['descriptor'] != row[1]
          update_script.write("update billing.fee_schedule set descriptor=$$#{row[1]}$$ where ama_item='#{row[0]}';\n")
        end
        update_script.write("update billing.prices set price='#{row[2]}' from billing.fee_schedule where ama_item='#{row[0]}' and fk_lu_billing_type=1 and fee_schedule.pk = fk_fee_schedule;\n") unless row[2].nil? or row[2]==''
      else
        # no existing row
        create_ama(row[0],row[1],row[2],update_script)
      end
    else
      # there is a matching MBS item
      mbs_with_ama(row[0],row[2],row[7],create_script)
      mbs_with_ama_update(row[0],row[2],row[7],conn,update_script)
      unless row[9] == "" or row[9].nil?
        mbs_with_ama(row[0],row[2],row[9],create_script)
        mbs_with_ama_update(row[0],row[2],row[9],conn,update_script)
      end
    end
  end
end

load_ama


