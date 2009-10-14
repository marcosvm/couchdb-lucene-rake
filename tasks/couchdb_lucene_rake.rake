require 'lib/couchdb_lucene_rake'
include CouchDBLuceneRake

namespace :couchdb do
  namespace :lucene do
    desc "Push lucene indexes views to couchdb"
    task :push, :database, :design_doc do |t, args|
      CouchDBLuceneRake::Tasks.push(args.database,args.design_doc)
    end
  
    desc "Pull lucene indexes views from couchdb"
    task :pull, :database, :design_doc do |t, args|
      CouchDBLuceneRake::Tasks.pull(args.database,args.design_doc)
    end
  end
end
