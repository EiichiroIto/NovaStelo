private
import: anImporter extension: aString
	| code |
	code := self importFileWithExtension: aString.
	code ifNil: [ ^ self ].
	anImporter import: code first to: self.
	self restoreProject.
	presenter updateDisplay