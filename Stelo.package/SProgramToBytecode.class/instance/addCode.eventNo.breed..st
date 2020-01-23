private
addCode: anArray eventNo: eno breed: bno
	| code |
	code := anArray
		collect: [ :each | 
			each isSymbol
				ifTrue: [ SteloNativeThread indexOfSymbol: each ]
				ifFalse: [ each ] ].
	stream
		nextPut:
			{eno.
			bno.
			code asByteArray}