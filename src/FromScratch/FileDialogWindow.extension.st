Extension { #name : #FileDialogWindow }

{ #category : #'*FromScratch' }
FileDialogWindow >> newPreviewMorph [
	"Answer a new preview morph."

	self previewType == #image
		ifTrue: [ ^ self newImagePreviewMorph ].
	self previewType == #text
		ifTrue: [ ^ self newTextPreviewMorph ].
	self previewType isClass
		ifTrue: [ ^ self newImagePreviewMorph ].
	^ nil
]

{ #category : #'*FromScratch' }
FileDialogWindow >> openSelectedFileAsBinary [
	"Open a stream on the selected file if available and return it."

	|d f fileRef |
	d := self selectedFileDirectory ifNil: [^nil].
	f := self selectedFileName ifNil: [^nil].
	self selectedFileEntry isDirectory ifTrue: [^nil].
	fileRef := d/f.
	^ fileRef exists ifTrue: [ fileRef binaryReadStream ] ifFalse: nil  
]

{ #category : #'*FromScratch' }
FileDialogWindow >> updateImagePreview [
	"Update the image preview."

	| str form |
	self selectedFileEntry ifNil: [ ^ self ].
	(self isImageFile: self selectedFileName)
		ifFalse: [ ^ self previewMorph image: nil size: self previewSize ].
	str := self openSelectedFileAsBinary.
	str ifNil: [ ^ self ].
	[ [ form := ImageReadWriter formFromStream: str ]
		on: Error
		do: [  ] ]
		ensure: [ str close ].
	self previewMorph image: form size: self previewSize
]

{ #category : #'*FromScratch' }
FileDialogWindow >> updatePreview [
	"Update the preview."

	self previewType == #image
		ifTrue: [ self updateImagePreview ].
	self previewType == #text
		ifTrue: [ self updateTextPreview ].
	self previewType isClass
		ifTrue: [ self updatePreviewClass: self previewType ]
]

{ #category : #'*FromScratch' }
FileDialogWindow >> updatePreviewClass: aClass [
	"Update the image preview."

	| str form |
	self selectedFileEntry ifNil: [ ^ self ].
	str := self openSelectedFileAsBinary.
	str ifNil: [ ^ self previewMorph image: nil size: self previewSize ].
	[ [ form := aClass formFromStream: str ]
		on: Error
		do: [  ] ]
		ensure: [ str close ].
	self previewMorph image: form size: self previewSize
]
