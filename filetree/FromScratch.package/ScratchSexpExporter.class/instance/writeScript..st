private
writeScript: aScript
	| code |
	stream
		nextPutAll: '(for ';
		nextPutAll: aScript objName;
		nextPut: Character space;
		nextPut: $(.
	aScript varNames
		do: [ :each | stream nextPutAll: (SexpLexer quotedString: each) ]
		separatedBy: [ stream nextPut: Character space ].
	stream
		nextPut: $);
		nextPut: Character lf;
		nextPut: $(.
	aScript subBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each target: aScript.
			stream nextPutAll: code ].
	aScript eventBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each target: aScript.
			stream nextPutAll: code ].
	stream
		nextPutAll: '))';
		nextPut: Character lf