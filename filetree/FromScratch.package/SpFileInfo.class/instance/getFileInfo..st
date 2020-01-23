private
getFileInfo: aFileReference
	(aFileReference isNil or: [ aFileReference isFile not ])
		ifTrue: [ ^ nil ].
	aFileReference extension = extension
		ifFalse: [ ^ nil ].
	^ project getScratchInfoFrom: aFileReference