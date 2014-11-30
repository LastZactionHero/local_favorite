require 'classifier'
require 'csv'
require 'pry'

tweets = CSV.read("tweets.csv")
responses = File.open("responses.txt", "r").readlines

responses.each do |r|
  puts r
end

# b = Classifier::Bayes.new 'English', 'French'


# translations.each do |translation|
#   if translation[0] && translation[0].length > 3 && translation[1] && translation[1].length > 3
#     b.train_english translation[0]
#     b.train_french translation[1]
#   end
# end


# binding.pry
