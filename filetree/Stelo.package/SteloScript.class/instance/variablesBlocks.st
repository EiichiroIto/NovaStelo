block specs
variablesBlocks
	^ #(
		'list'
			('clear %L'											-	clearList: 'list')
			('add %n to %L'									-	append:toList: 10 'list')
			('delete %n of %L'								-	deleteLine:ofList: 1 'list')
			('replace item %n of %L with %n'		-	setLine:ofList:to: 1 'list' 10)
			-
			('item %n of %L'									r	getLine:ofList: 1 'list')
			('length of %L'									r	lineCountOfList: 'list')
			('%L contains %n'								b	list:contains: 'list' 10)
	)