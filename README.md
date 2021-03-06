# Couchdb-lucene-rake

A task to push couchdb-lucene indexes via rake.

This tool has the goal of keeping couchdb-lucene scripts easily maintainable by using a directory layout convention and javascript with .js extension to make it suitable to edit inside your favorite text editor or IDE.

Those take could be easily written using the [CouchRest](http://github.com/jchris/couchrest) RESTful client for CouchDB and were inspired by the [CouchRestRails plugin](http://github.com/hpoydar/couchrest-rails)

The tasks are:

* push - push the indexes views from your file system to couchdb.
* pull - pull the indexes view from couchdb to your file system

## Dependencies

* [CouchRest gem](http://github.com/jchris/couchrest)
* [JSON gem](http://json.rubyforge.com)

### Usage
    rake -f tasks/couchdb_lucene_rake.rake couchdb:lucene:push[<database-url>,<design-document>]

Will push the lucene views from disk to the database-url on the design-document.

    rake -f tasks/couchdb_lucene_rake.rake couchdb:lucene:pull[<database-url>,<design-document>]

Will pull the lucene views from the database-url on the design-document and save them on disk.
    
### Example

A directory layout like this:

    <root>  
	    |-- fulltext  
	              |-- all.js  
	
*Note that the "fulltext" name is mandatory for the directory under <root>.*
		
where all.js contains:

    function(doc) {
		var ret = new Document();
		ret.add(doc.subject);
		return ret;
    }

will produce a design document like:
    
    {

	   "_id": "_design/bag",
	   "fulltext": {
	       "all": {
             "index": "function(doc) {\n    var ret = new Document();\n    ret.add(doc.subject); \n return ret;\n}\n"
	       }
	   }
    }

### TODO
* Create .couchdb-lucene-rake with database and design-documents configuration.
* Write tests

