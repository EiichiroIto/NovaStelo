test
testBlockColorAt
	| sp list |
	sp := self newBlockDef.
	sp addCategory: 'operators' color: Color blue.
	list := #(
			'sensing'
			('returned value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assert: (sp blockColorAt: #returnValue) equals: sp unknownCategoryColor.
	self assert: (sp blockColorAt: #+) equals: Color blue.
	self assert: (sp blockColorAt: #-) equals: Color blue