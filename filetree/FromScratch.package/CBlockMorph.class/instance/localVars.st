accessing
localVars
	| list |
	list := self submorphs
		select: [ :each | each isKindOf: LocalVarArgMorph ].
	^ list collect: [ :each | each varName ]