Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
	  Movie.create!(movie)
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
    step %Q{I should see "#{title}"}
    step %Q{I should see "#{director}"}
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
	rating_list.split(", ").each do |rating|
		step %Q{I {uncheck}check "ratings_#{rating}"}
	end
end

# Then /the director of "(.*)" should be "(.*)"/ do |movie, director|
#   step %Q{I should see "#{movie}"} 
#   step %Q{I should see "#{director}"} 
# end


# Then /I should( not)? see the following movies: (.*)/ do |notsee, movies|
# 	movies.split(", ").each do |movie|
# 		if(notsee)
# 			step %Q{I should not see "#{movie}"}
# 		else
# 			step %Q{I should see "#{movie}"}
# 		end
# 	end
#   end
# end

# Then /I should see all the movies/ do
#   # Make sure that all the movies in the app are visible in the table
#   Movie.all.each.do |movie|
# 	steps %Q{I should see #{movie.title}}
#   end
# end
