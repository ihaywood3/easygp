#!/usr/bin/ruby

require 'rexml/document'

def load_xml()
    return REXML::Document.new(File.new("201107-xml.xml"))
end

def run(doc) 
    doc.each_element("MBS_XML/Data") do |data|
        descriptor = item = group = fee = nil
        data.each_element("Description") { |e| descriptor = e.text }
        data.each_element("ItemNum") { |e| item = e.text }
        data.each_element("Group") { |e| group = e.text }
        data.each_element("ScheduleFee") { |e| fee = e.text }
        puts "insert into clerical.schedule (descriptor, mbs_item, \"group\") values ($$#{descriptor}$$,'#{item}','#{group}');"
        puts "insert into clerical.prices (fk_schedule, price, fk_lu_billing_type) values (currval('clerical.schedule_pk_seq'),'#{fee}',3);"
    end
end

def both()
    doc = load_xml()
    run(doc)
end