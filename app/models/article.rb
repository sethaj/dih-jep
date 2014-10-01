class Article < ActiveFedora::Base
  has_metadata 'descMetadata', type: ArticleMetadata

  has_attributes :title, datastream: 'descMetadata', multiple: false
  has_attributes :author, datastream: 'descMetadata', multiple: true
  
  has_file_datastream "bodyContent"
end