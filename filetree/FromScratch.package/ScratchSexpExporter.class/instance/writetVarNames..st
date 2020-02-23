private
writetVarNames: aScript
	aScript varNames
		do: [ :each | 
			stream
				nextPutAll: '(var ';
				nextPutAll: (SexpLexer quotedString: each);
				nextPutAll: ')' ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: Character space.
	aScript listVarNames
		do: [ :each | 
			stream
				nextPutAll: '(list ';
				nextPutAll: (SexpLexer quotedString: each);
				nextPutAll: ')' ]
		separatedBy: [ stream nextPut: Character space ]