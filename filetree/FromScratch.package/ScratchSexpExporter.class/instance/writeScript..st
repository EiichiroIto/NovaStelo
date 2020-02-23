private
writeScript: aScript
	| code |
	stream
		nextPutAll: '(for ';
		nextPutAll: aScript objName;
		nextPut: Character space;
		nextPut: $(.
	self writetVarNames: aScript.
	stream nextPut: $).
	self writeIndent.
	stream nextPut: $(.
	aScript subBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each initialIndent: 3.
			stream nextPutAll: code ]
		separatedBy: [ self writeIndent ].
	self writeIndent.
	aScript eventBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each initialIndent: 3.
			stream nextPutAll: code ]
		separatedBy: [ self writeIndent ].
	stream nextPutAll: '))'