accessing
getScratchInfoFrom: aFileReference
	| result f version buf |
	result := Dictionary new.
	SpScratchApp
		try: [ f := aFileReference binaryReadStream.
			version := ObjStream fileVersion: self class from: f.
			version = 1
				ifFalse: [ self error: 'invalid version' ].
			buf := f next: f uint32.
			result := ObjStream new readObjFrom: (ReadStream on: buf).
			f close ]
		onFailure: [ ^ nil ].
	^ result