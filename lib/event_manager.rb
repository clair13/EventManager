
require "csv"
puts "EventManager Initialized!"

content = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
content.each do | row |
  name = row[:first_name]
  zipcode = row[:zipcode]
  puts "#{name} #{zipcode}"
end