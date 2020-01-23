private
symbols
	| list |
	list := self allMethods.
	list := list select: [ :each | each category endsWith: 'ops' ].
	list := list collect: #selector.
	^ list sort