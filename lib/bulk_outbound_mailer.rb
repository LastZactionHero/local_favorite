class BulkOutboundMailer

  def self.sent_to_list(list, template = 'Outbound - Product Company')
    list.each do |person|
      email = person[:email]
      first_name = person[:first_name]

      om = OutboundMail.new(template, email, first_name)
      om.send!
    end
  end

end
