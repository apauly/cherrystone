## Cherrystone 0.1.1

* Moved engine from core gem to this gem
* Added `Cherrystone::DslCaller` to optionally enhance exceptions with the DSL caller that caused the exceptionn during rendering
* Added `subtitle` and `paragraph` methods to base node class
* Safe `node.inspect`