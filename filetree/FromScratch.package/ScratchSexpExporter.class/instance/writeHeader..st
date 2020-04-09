private
writeHeader: aProject
	stream
		nextPut: $(;
		nextPutAll: appName;
		nextPut: Character space.
	self writeScriptNames: aProject.
	stream
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: $(