file read/write
getScratchInfoFrom: aFileReference
	| result f version buf obj |
	obj := self newObjStream.
	result := Dictionary new.
	SpScratchApp
		try: [ f := aFileReference binaryReadStream.
			version := obj class fileVersion: self class from: f.
			version = self class appVersion
				ifFalse: [ self inform: 'invalid app version'. ^ nil ].
			buf := f next: f uint32.
			result := obj readObjFrom: (ReadStream on: buf).
			f close ]
		onFailure: [ ^ nil ].
	^ result