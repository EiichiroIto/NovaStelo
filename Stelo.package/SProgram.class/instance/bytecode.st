accessing
bytecode
	^ codes
		collect: [ :each | 
			each isSymbol
				ifTrue: [ SteloNativeThread indexOfSymbol: each ]
				ifFalse: [ each ] ]