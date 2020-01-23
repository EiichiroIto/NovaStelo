accessing
file: aFileReference
	| dict |
	dict := self getFileInfo: aFileReference.
	self
		author:
			((dict notNil and: [ dict includesKey: 'author' ])
				ifTrue: [ dict at: 'author' ]
				ifFalse: [ '' ]).
	self
		comment:
			((dict notNil and: [ dict includesKey: 'comment' ])
				ifTrue: [ dict at: 'comment' ]
				ifFalse: [ '' ]).
	self
		thumbnailForm:
			((dict notNil and: [ dict includesKey: 'thumbnail' ])
				ifTrue: [ dict at: 'thumbnail' ]
				ifFalse: [ (Form extent: 1 @ 1 depth: 1) fillWhite ])