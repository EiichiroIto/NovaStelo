private
assignUniqueObjNameTo: aScript
	| name |
	aScript objName ifNotNil: [ ^ self ].
	name := aScript defaultObjName.
	[ (scripts noneSatisfy: [ :each | each objName = name ])
		ifTrue: [ ^ aScript objName: name ].
	name := name , 'x' ] repeat