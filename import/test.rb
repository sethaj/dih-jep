require 'nokogiri'

file = File.open('3336451.0017.306.xml');
doc = Nokogiri.XML(file);
puts file
puts doc.xpath('//DLPSTEXTCLASS/HEADER/FILEDESC/TITLESTMT/TITLE').text.strip
authors = []
doc.xpath('//DLPSTEXTCLASS/HEADER/FILEDESC/AUTHOR').each do |a|

end
