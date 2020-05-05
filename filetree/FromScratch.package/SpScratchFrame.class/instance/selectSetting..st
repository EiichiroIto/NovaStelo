private
selectSetting: aSymbol
	| list choice appClass |
	appClass := self application class.
	list := appClass optionsFor: aSymbol.
	list isEmpty
		ifTrue: [ ^ self ].
	choice := UIManager default
		chooseFrom: list
		title: 'Select options for ' , aSymbol.
	choice = 0
		ifTrue: [ ^ self ].
	appClass perform: (aSymbol , ':') asSymbol with: (list at: choice).
	aSymbol = #dontClose
		ifTrue: [ self updateDontCloseSetting ]