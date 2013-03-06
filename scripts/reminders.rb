#!/usr/bin/ruby1.9.1
require 'net/smtp'
require 'pg'

conn = PG.connect(:dbname=>'easygp',:host=>'haywood.id.au',:user=>'ian',:password=>'XXX',:sslmode=>'require')
cmd = <<-eos
select c.value, to_char(b.begin,'HH:00pm') from clerical.bookings b,
contacts.data_communications c,
contacts.links_persons_comms l,
clerical.data_patients p
 where date_trunc('day',b.begin) = date_trunc('day', now()+'1 day'::interval) and fk_patient is not null and
   c.fk_type = 4 and
   l.fk_comm = c.pk and c.fk_type = 4 and 
   l.fk_person = p.fk_person and
   p.pk = b.fk_patient and not b.deleted order by b.begin
eos
smtp = Net::SMTP.new 'smtp.gmail.com', 587
smtp.enable_starttls
smtp.start('gmail.com', 'ihaywood3', 'XXX', :login) do
  conn.exec(cmd).each do |row|
    appt_time = row["to_char"]
    if row["value"] =~ /(04[0-9]+)/
      mobile = $1
      msg = "Subject: SMS\nTo: %s@ozesms.com\n\nAppointment with XXX at %s tomorrow, call 59867709 to cancel" % [mobile,appt_time]
      smtp.send_message(msg, 'ihaywood3@gmail.com', mobile+'@ozesms.com')
      print msg+"\n"
    end
  end
  #smtp.send_message("Subject: SMS\nTo: 0407424766@ozesms.com\n\ntest message to ian","ihaywood3@gmail.com", "0407424766@ozesms.com")
end
