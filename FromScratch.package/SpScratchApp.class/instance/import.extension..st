private
import: anImporter extension: aString
	| response fr f code |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	response := self
		chooseExistingFileType: #export
		title: 'Import ...'
		extension: aString.
	response ifNil: [ ^ self ].
	fr := response asFileReference.
	fr isFile
		ifFalse: [ ^ self ].
	[ f := fr readStream.
	code := f contents.
	f close ]
		ifError: [ f ifNotNil: [ f close ].
			^ UIManager default
				alert: 'Could not read file' localized
				title: 'Import failed' localized ].
	anImporter import: code to: self.
	self restoreProject.
	presenter updateDisplay