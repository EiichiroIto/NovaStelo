accessing
selectedFile
	| list |
	list := listEntries selectedItems.
	list isEmpty ifTrue: [ ^ nil ].
	^ list first