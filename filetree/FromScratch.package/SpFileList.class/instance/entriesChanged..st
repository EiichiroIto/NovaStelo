private
entriesChanged: aSelectionMode
	| dir |
	dir := aSelectionMode selectedItem.
	dir isDirectory
		ifFalse: [ ^ self ].
	self directory: dir asFileReference