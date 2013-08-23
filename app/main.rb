require_relative 'models/legislator.rb'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

def find_state_legislator(title, state)
  Legislator.where(title: "#{title}" , state: "#{state}").order("lastname")
end

puts "\nSenators"
puts "________"
find_state_legislator("Sen", "GA").each do |sen|
  puts "#{sen.firstname} #{sen.lastname} (#{sen.party})"
end
puts "\n:/"
puts "\nRepresentatives"
puts "_______________"
find_state_legislator("Rep", "GA").each do |person|
  puts "#{person.firstname} #{person.lastname} (#{person.party})"
end

# Given a gender, print out what number and percentage of the senators are of 
# that gender as well as what number and percentage of the representatives, 
# being sure to include only those congresspeople who are actively in office, e.g.:

# Male Senators: 83 (83%)
# Male Representatives: 362 (83%)

def gender_percentage(title, gender)
  gender_count = Legislator.where(gender: "#{gender}", title: "#{title}").count
  total_count = Legislator.where(title: "#{title}").count

  p gender_count
  p gender_count.percent_of(total_count).round(2)
end

print "Male Senators:\n"
gender_percentage("Sen", "M")

print "Male Representatives:\n"
gender_percentage("Rep", "M")

print "Female Senators:\n"
gender_percentage("Sen", "F")

print "Female Representatives:\n"
gender_percentage("Rep", "F")

# Print out the list of states along with how many active senators and 
# representatives are in each, in descending order (i.e., print out states with 
#   the most congresspeople first).

# CA: 2 Senators, 53 Representative(s)
# TX: 2 Senators, 32 Representative(s)
# NY: 2 Senators, 29 Representative(s)
# (... etc., etc., ...)
# WY: 2 Senators, 1 Representative(s)

Legislator.select("state, count(id) as title_count").where(title: "Rep", in_office: "1").group("state").order("title_count DESC").each do |location|
  puts "#{location.state}: 2 Senators, #{location.title_count} Representative(s)"
end

# For Senators and Representatives, count the total number of each (regardless 
#   of whether or not they are actively in office).

# Senators: 137
# Representatives: 603



# Now use ActiveRecord to delete from your database any congresspeople who are 
# not actively in office, then re-run your count to make sure that those 
# rows were deleted.

# Senators: 100
# Representatives: 435
