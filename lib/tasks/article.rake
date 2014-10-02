
namespace :article do 
  desc "import textclass lvl 4 simple articles in /import into hydra"
  task :import => :environment do
    Dir.glob("#{Rails.root}/import/*.xml") do |file|
      f = File.open(file) 
      # get the title, author and "body" of the article
      doc = Nokogiri::XML(f)
      title = doc.xpath('//DLPSTEXTCLASS/HEADER/FILEDESC/TITLESTMT/TITLE[not(@*)]').text.strip
      puts title
      authors = []
      doc.xpath('//DLPSTEXTCLASS/HEADER/FILEDESC/TITLESTMT/AUTHOR').each do |a|
        authors << a.text.strip
      end
      body = doc.xpath('//DLPSTEXTCLASS/BODY').text.strip

      # make into hydra objects, index
      a = Article.create(title: title, author: authors)
      #a.save!
      a.to_solr
      a.update_index
      a.bodyContent.content = file
      a.save!
    end
  end

  desc "remove objects from solr and fedora"
  task :destroy => :environment do
    Article.all.each do |a|
      a.destroy
    end
  end

end
