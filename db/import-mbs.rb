#!/usr/bin/ruby

require 'rexml/document'
require 'rexml/formatters/pretty'
require 'csv'

def load_xml()
	return REXML::Document.new(File.new("/home/ian/201201-xml.xml"))
end

def run(doc)
	pp = REXML::Formatters::Pretty.new
	doc.each_element("MBS_XML/Data") do |data|
		derived = descriptor = item = group = fee = nil
		data.each_element("Description") { |e| descriptor = e.text }
		data.each_element("ItemNum") { |e| item = e.text }
        	data.each_element("Group") { |e| group = e.text }
        	data.each_element("ScheduleFee") { |e| fee = e.text }
		puts "insert into clerical.schedule (descriptor, mbs_item, \"group\") values ($$#{descriptor}$$,'#{item}','#{group}');"
		if fee.nil? or fee == ''
			data.each_element("DerivedFee") {|e| derived = e.text }
			puts "update clerical.schedule set derived_fee = $$#{derived}$$ where pk = currval('clerical.schedule_pk_seq');"
		else
			puts "insert into clerical.prices (fk_schedule, price, fk_lu_billing_type) values (currval('clerical.schedule_pk_seq'),'#{fee}',3);"
		end
    	end
end

def both()
	doc = load_xml()
	run(doc)
end

def load_ama()
	f = File.open('/home/ian/Downloads/AMANov2011.csv', 'rb').read
	f.gsub!("\x92","'")
	CSV::Reader.parse(f) do |row|
  		if row[7] == "" or row[7].nil?
			puts "insert into clerical.schedule (descriptor, ama_item) values ($$#{row[1]}$$, '#{row[0]}');"
			puts "insert into clerical.prices (fk_schedule, price, fk_lu_billing_type) values (currval('clerical.schedule_pk_seq'),'#{row[2]}',4);"
		else
			puts "update clerical.schedule set ama_item = '#{row[0]}' where mbs_item = '#{row[7]}';"
			puts "insert into clerical.prices (fk_schedule, price, fk_lu_billing_type) values ((select pk from clerical.schedule where mbs_item = '#{row[7]}'), '#{row[2]}', 4);"
			unless row[9] == "" or row[9].nil?
				puts "update clerical.schedule set ama_item = '#{row[0]}' where mbs_item = '#{row[9]}';"
				puts "insert into clerical.prices (fk_schedule, price, fk_lu_billing_type) values ((select pk from clerical.schedule where mbs_item = '#{row[9]}'), '#{row[2]}', 4);"
			end
		end
	end
end

	
