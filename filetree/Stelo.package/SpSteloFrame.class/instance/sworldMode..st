accessing
sworldMode: aSymbol
	menuChangeWorld
		name:
			(aSymbol = #SMicroWorld
				ifTrue: [ 'Change to Pluginworld' localized ]
				ifFalse: [ 'Change to Microworld' localized ])