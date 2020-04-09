private
importFileWithExtension: aString isBinary: aBoolean
	| response fr f code |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ nil ].
	self stopAllProcesses.
	response := self
		chooseExistingFileType: #export
		title: 'Import ...'
		extension: aString.
	response ifNil: [ ^ nil ].
	fr := response asFileReference.
	fr isFile
		ifFalse: [ ^ nil ].
	f := aBoolean
		ifTrue: [ fr binaryReadStream ]
		ifFalse: [ fr readStream ].
	^ self class
		try: [ code := f contents.
			f close.
			{code.
			fr} ]
		onFailure: [ f ifNotNil: [ f close ].
			UIManager default
				alert: 'Could not read file' localized
				title: 'Import failed' localized.
			nil ]