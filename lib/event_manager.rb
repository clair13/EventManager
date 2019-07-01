
require "csv"
puts "EventManager Initialized!"

content = CSV.open "event_attendees.csv", headers: true
content.each do | row |
  name = row[2]
  puts name
end