accessing
allVarNames
	| list |
	list := classNames keys
		select: [ :each | (classNames at: each) notNil ].
	^ list collect: [ :each | varNames at: each ]