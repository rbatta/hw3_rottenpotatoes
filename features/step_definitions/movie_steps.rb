# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie) # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
  #flunk "Unimplemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  x = find("tr", :text => e1)
  y = find("tr", :text => e2)
  assert x.path.match(/\d/)[0] < y.path.match(/\d/)[0]
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  #debugger
  if page.all('tbody/tr').count == 0
    flunk
  end
  if !uncheck
    rating_list.split(', ').each { |x| step("I check \"ratings_#{x}\"") }
  #elsif rating_list.split(', ') == []
  #  assert false
  else
    rating_list.split(', ').each { |x| uncheck("ratings_#{x}") }
  end
 
end

Then /I should( not)? see movies with ratings: (.*)/ do |shnot, rating_list|

  if !shnot
    x = rating_list.split(', ')
    all('tr/td[2]').each { |td| x.should include td.text }
  else
    x = rating_list.split(', ') 
    all('#movies tr/td[2]').each { |td| x.should_not include td.text }
  end
  # incl/exc the values of ratings from the list that i want
  # must be array because include searches the text of a string and not each element

end

Then /^I should see all movies/ do
  assert page.all('#movies tbody/tr').count.should eql(Movie.all.count)
end
#page.find(:xpath, '//tr', :text => e1)
#x = find("tr", :text => e1)
#y = find("tr", :text => e2)
#assert x.path.match(/\d/)[0] < y.path....
#element1 = page.find(:xpath, '//tr', :text => e1).path.gsub(/\D/,'').to_i
#movies = all("table#movies tbody tr")
#movies.index(e1)
#idx = movies.index(e1)
# movies[idx+1].should eql(e2)

#page.all('#movies tbody/tr').count.should == Movie.count #eql(Movie.all.count) works?
