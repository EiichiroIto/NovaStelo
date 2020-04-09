accessing
optionsFor: aSymbol
	aSymbol = #stickyWindow
		ifTrue: [ ^ #(true false) ].
	aSymbol = #useErrorCatcher
		ifTrue: [ ^ #(true false) ].
	^ #()