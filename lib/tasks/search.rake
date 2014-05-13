namespace :search do

  desc "Search for SearchTerms"
  task :search => :environment do
    SearchTerm.all.each do |term|
      term.search!
    end
  end

end
