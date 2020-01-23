accessing
listNames
	| list |
	list := classNames keys
		select: [ :each | (classNames at: each) notNil ].
	list := list select: [ :each | (classNames at: each) = #Array ].
	^ list collect: [ :each | varNames at: each ]