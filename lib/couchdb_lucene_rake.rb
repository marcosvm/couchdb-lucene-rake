require 'rubygems'
require 'couchrest'
require 'json'

module CouchDBLuceneRake

  module Tasks

    def self.pull(database_url, doc, save_to_path = ".")

      database = CouchRest.database(database_url)
      
      design_doc = database.get("_design/#{doc}")
      
      views = design_doc[:fulltext]
     
      save_dir = File.join(save_to_path,"fulltext")
      Dir.mkdir(save_dir) unless File.exists?(save_dir)
      views.each_pair do |key, value|
        basename = File.join(save_to_path,"fulltext","#{key}.js")
        File.open(basename, "w")  do |f| 
          f.write(value["index"])
          f.close
        end
      end
    end
    
    def self.push(database_url, design_doc)
          
      db = CouchRest.database(database_url)
      doc = db.get("_design/#{design_doc}") rescue nil
      
      indexes = {}

      Dir.glob(File.join("fulltext","*.js")).each do |index|
        basename = File.basename(index,"\.js")
        js_function = IO.read(index)
        indexes[basename] = { :index => js_function }
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