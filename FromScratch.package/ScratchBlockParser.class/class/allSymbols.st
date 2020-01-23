accessing
allSymbols
	"self allSymbols inspect."
	| list |
	list := ScratchScript allBlockSpecs.
	list := list select: [ :each | each isArray ].
	list := list collect: [ :each | each third ].
	list := list collect: [ :each | self operatorAt: each ifAbsent: [ each ] ].
	list := list asSet.
	list := list asSortedCollection.
	^ list asArray