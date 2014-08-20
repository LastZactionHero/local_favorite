require 'csv'

def url_to_domain(url)
  domain = url
  domain.gsub!("http://", "")
  domain.gsub!("www.", "")
  domain
end

def full_name_to_prefix(name)
  prefix = name.downcase
  prefix.gsub!(" ", ".")
  prefix
end

def first_name_to_prefix(name)
  prefix = name.downcase
  prefix.split(" ")[0]
end

emails = []

CSV.foreach("crunchbase_2.csv") do |row|
  next unless row[3]

  domain = url_to_domain(row[3])
  full_prefix = full_name_to_prefix(row[0])
  full_email = "#{full_prefix}@#{domain}"


  first_prefix = first_name_to_prefix(row[0])
  first_email = "#{first_prefix}@#{domain}"

  emails << [full_email, first_email, row[0], row[1], row[2], row[3]]
end

CSV.open("crunchbase_emails_2.csv", "wb") do |csv|
  emails.each do |email|
    csv << email
  end
end
