# Couchdb-lucene-rake

A tasks to push couchdb-lucene indexes via rake.

This tool has the goal of keeping couchdb-lucene scripts easily maintainable by using a directory layout convention and javascript with .js extension to make it suitable to edit inside your favorite text editor or IDE.

Those take could be easily written using the [CouchRest](http://github.com/jchris/couchrest) RESTful client for CouchDB and were inspired by the [CouchRestRails plugin](http://github.com/hpoydar/couchrest-rails)

The task are:

* push - push the indexes views from your file system to couchdb.

## Dependencies

* [CouchRest gem](http://github.com/jchris/couchrest)
* [JSON gem](http://json.rubyforge.com)

### Usage
    rake -f tasks/couchdb_lucene_rake.rake couchdb:lucene:push[<database-url>,<design-document>]

Will push the lucene views to the database-rul on the design-document.
    
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
* Create "pull" task.
* Create .couchdb-lucene-rake with database and design-documents configuration.

