require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'



def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(homephone)
  if homephone.to_s.length < 10
    "bad number"
  elsif homephone.to_s.length == 10
    homephone  
  elsif (homephone.to_s.length == 11) && (homephone.to_s[0] = "1")
    homephone = homephone.to_s.slice(1,10)
    homephone.to_i
  elsif (homephone.to_s.length == 11) && (homephone.to_s[0] != "1")
    "bad number"
  else
    "bad number"
  end
end


def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    legislators = civic_info.representative_info_by_address(
                              address: zipcode,
                              levels: 'country',
                              roles: ['legislatorUpperBody', 'legislatorLowerBody']
                              ).officials
  rescue
    "You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials"
  end
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts "EventManager initialized."

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter


contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])

  phonenumber = clean_phone_number(row[:homephone])

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letters(id,form_letter)

  puts "#{phonenumber}"
end