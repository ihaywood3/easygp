#!/usr/bin/ruby1.9.1
require 'net/imap'
require 'mail'

Dir.chdir("/var/lib/easygp/incoming")
imap = Net::IMAP.new('imap.gmail.com',993,true)
imap.login('XXXXX','XXX')
imap.select('faxes')
imap.search(["NOT", "DELETED"]).each do |message_id|
    msg = imap.fetch(message_id,"RFC822")
    unless msg.nil?
        email = Mail.read_from_string(msg[0].attr["RFC822"])
        email.attachments.each do |att|
        if att.content_type.start_with? "application/pdf"
            filename = att.filename
            filename_encrypted = filename+'.encrypted'
            File.open(filename_encrypted, "w+b") {|f| f.write att.body.decoded}
            system "pdftk "+filename_encrypted+" input_pw XXX output "+filename
            File.unlink(filename_encrypted)
         end
      end
      imap.copy(message_id, "scanned")
      imap.store(message_id, "+FLAGS", [:Deleted])
    end
end
imap.expunge
