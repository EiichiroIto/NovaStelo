private
setDirectory: aFileReference
	list ifNil: [ ^ self ].
	aFileReference ifNil: [ ^ self ].
	list directory: aFileReference