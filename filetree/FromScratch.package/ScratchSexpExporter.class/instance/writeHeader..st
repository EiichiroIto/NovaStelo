private
writeHeader: aProject
	stream
		nextPut: $(;
		nextPutAll: appName;
		nextPutAll: ' ('.
	aProject scripts
		do: [ :each | stream nextPutAll: each objName ]
		separatedBy: [ stream nextPut: Character space ].
	stream
		nextPut: $);
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: $(