test
testSetupFrom
	| sp list |
	sp := self newBlockDef.
	self assert: sp privBlockSpecs isEmpty.
	self assert: sp privBlockColors isEmpty.
	sp addCategory: 'operators' color: Color blue.
	list := #(
			'sensing'
			('return value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assertCollection: (sp privBlockSpecs at: #returnValue) equals: #('return value' r #returnValue).
	self assertCollection: (sp privBlockSpecs at: #+) equals: #('%n + %n' r #+ #- #-).
	self assertCollection: (sp privBlockSpecs at: #-) equals: #('%n - %n' r #- #- #-).
	self assert: (sp privBlockColors at: #returnValue) equals: sp unknownCategoryColor.
	self assert: (sp privBlockColors at: #+) equals: Color blue.
	self assert: (sp privBlockColors at: #-) equals: Color blue