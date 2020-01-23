accessing
sworldMode: aSymbol
	menuChangeWorld
		name:
			(aSymbol = #SMicroWorld
				ifTrue: [ 'Change to Pluginworld' ]
				ifFalse: [ 'Change to Microworld' ])