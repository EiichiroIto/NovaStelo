accessing
blocksFor: aCategory script: aScript
	| list result b color |
	list := blocks at: aCategory ifAbsent: [ ^ Array new ].
	color := self blockColorFor: aCategory.
	result := WriteStream on: Array new.
	list
		do: [ :each | 
			(self isSpacer: each)
				ifTrue: [ result nextPut: each ]
				ifFalse: [ (b := aScript blockFromSpec: each color: color)
						ifNotNil: [ result nextPut: b ] ] ].
	^ result contents