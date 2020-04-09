private
writeScriptNames: aProject
	stream nextPut: $(.
	aProject scripts
		do: [ :each | stream nextPutAll: each objName ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: $)