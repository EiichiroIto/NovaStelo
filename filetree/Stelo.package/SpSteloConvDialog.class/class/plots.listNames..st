instance creation
plots: plots listNames: listNames
	| dialog |
	dialog := self new
		listNames: listNames;
		plots: plots;
		yourself.
	(dialog openModalWithSpec: #plotToListSpec) isCancelled
		ifTrue: [ ^ nil ].
	^ {dialog plot.
	dialog listName}