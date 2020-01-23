private
windowsDocuments
	| drive path fr |
	drive := Smalltalk os environment at: 'HOMEDRIVE' ifAbsent: [ ^ nil ].
	path := Smalltalk os environment at: 'HOMEPATH' ifAbsent: [ ^ nil ].
	fr := (drive , path) asFileReference.
	fr isDirectory
		ifFalse: [ ^ nil ].
	(fr / 'Documents') isDirectory
		ifFalse: [ ^ fr ].
	^ fr / 'Documents'