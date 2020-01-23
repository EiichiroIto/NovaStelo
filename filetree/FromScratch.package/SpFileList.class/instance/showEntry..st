private
showEntry: aFileReference
	| base |
	base := aFileReference basename.
	^ aFileReference isDirectory
		ifTrue: [ '<' , base , '>' ]
		ifFalse: [ base ]