instance creation
listNames: listNames plots: plots
	| dialog |
	dialog := self new
		listNames: listNames;
		plots: plots;
		yourself.
	(dialog openModalWithSpec: #listToPlotSpec) isCancelled
		ifTrue: [ ^ nil ].
	^ {dialog listName.
	dialog plot}