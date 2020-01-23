private
confirmFileOverwriteIfExisting: aFileReference orCancel: aBlock
	| file response |
	file := aFileReference withExtension: self extension.
	file isFile
		ifFalse: [ ^ file ].
	response := UIManager default
		confirm: 'The file name already exists. Overwrite existing file?' localized
		orCancel: aBlock.
	^ response
		ifTrue: [ file ]
		ifFalse: [ nil ]