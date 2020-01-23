accessing
setArray: aCollection
	className ~= aCollection class name
		ifTrue: [ self error ].
	array := aCollection copy.