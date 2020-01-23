private
addSpec: anObject category: aString
	| list |
	list := blocks at: aString ifAbsentPut: [ OrderedCollection new ].
	list add: anObject copy