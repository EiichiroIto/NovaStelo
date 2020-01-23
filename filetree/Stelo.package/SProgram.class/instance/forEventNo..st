accessing
forEventNo: anInteger
	^ entryPoints at: anInteger ifAbsentPut: [ SEntryPoints new ]