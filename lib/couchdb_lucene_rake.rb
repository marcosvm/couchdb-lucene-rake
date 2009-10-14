require 'rubygems'
require 'couchrest'
require 'json'

module CouchDBLuceneRake
  module Tasks
    def self.push(database_url, design_doc)
      
      puts database_url
      puts design_doc
      
      db = CouchRest.database(database_url)
      doc = db.get("_design/#{design_doc}") rescue nil
      
      indexes = {}

      Dir.glob(File.join("fulltext","*.js")).each do |index|
        basename = File.basename(index,"\.js")
        js_function = IO.read(index)
        indexes[basename] = { :index => js_function}
      end

      if (doc.nil?)
        doc = {
          "_id" => "_design/#{design_doc}", 
          'language' => 'javascript',
          'fulltext' => indexes
        }
      else
        doc['fulltext'].merge!(indexes)
      end

      db.save_doc(doc)
    end
    
  end
end