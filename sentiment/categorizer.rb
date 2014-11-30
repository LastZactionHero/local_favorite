require 'csv'

def parse_response(r)
  {
    "p" => :positive,
    "m" => :neutral,
    "n" => :negative,
    "s" => :spam
  }[r.strip]
end

def write_response(response)
  file = File.open("responses.txt", "a")
  file << response
  file << "\n"
  file.close
end

def written_count
  return 0 unless File.exists?("responses.txt")
  File.open("responses.txt", "r").readlines.count
end

puts "Read: #{written_count}"
idx = 1

tweets = CSV.read("./tweets.csv")
tweets.each do |tweet|  
  puts "******** #{idx} of 10000 **********"
  idx += 1

  next if (idx-1) <= written_count

  puts tweet

  puts "\nPositive (p), Neutral (m), Negative(n), Spam (s)"
  write_response(parse_response(gets))
end