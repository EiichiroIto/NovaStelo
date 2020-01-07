Class {
	#name : #SpFileInfo,
	#superclass : #SpPresenter,
	#instVars : [
		'thumbnail',
		'textAuthor',
		'textComment',
		'labelAuthor',
		'labelComment',
		'extension',
		'project'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #specs }
SpFileInfo class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #thumbnail
			withConstraints: [ :c | c width: SpScratchApp thumbnailExtent x ];
		add: #labelAuthor withConstraints: [ :c | c expand: false ];
		add: #textAuthor withConstraints: [ :c | c expand: false ];
		add: #labelComment withConstraints: [ :c | c expand: false ];
		add: #textComment;
		yourself
]

{ #category : #accessing }
SpFileInfo >> author [
	^ textAuthor pendingText asString trimBoth
]

{ #category : #accessing }
SpFileInfo >> author: aString [
	textAuthor text: aString
]

{ #category : #accessing }
SpFileInfo >> comment [
	^ textComment pendingText
]

{ #category : #accessing }
SpFileInfo >> comment: aString [
	textComment text: aString
]

{ #category : #initialization }
SpFileInfo >> connectPresenters [
	"thumbnail whenMorphChangedDo: [ Transcript show: 'thumbnail changed'; cr ]"
]

{ #category : #accessing }
SpFileInfo >> extension [
	^ extension
]

{ #category : #accessing }
SpFileInfo >> extension: aString [
	extension := aString
]

{ #category : #accessing }
SpFileInfo >> file: aFileReference [
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
]

{ #category : #private }
SpFileInfo >> getFileInfo: aFileReference [
	(aFileReference isNil or: [ aFileReference isFile not ])
		ifTrue: [ ^ nil ].
	aFileReference extension = extension
		ifFalse: [ ^ nil ].
	^ project getScratchInfoFrom: aFileReference
]

{ #category : #initialization }
SpFileInfo >> initialize [
	super initialize.
	extension := '*'
]

{ #category : #initialization }
SpFileInfo >> initializePresenters [
	thumbnail := self newImage.
	textAuthor := self newTextInput acceptOnCR: true.
	textComment := self newText.
	labelAuthor := self newLabel label: 'Project author:' localized.
	labelComment := self newLabel label: 'About this project:' localized
]

{ #category : #accessing }
SpFileInfo >> project [
	^ project
]

{ #category : #accessing }
SpFileInfo >> project: aProject [
	project := aProject
]

{ #category : #accessing }
SpFileInfo >> readOnly: aBoolean [
	textAuthor enabled: aBoolean not.
	textComment enabled: aBoolean not
]

{ #category : #accessing }
SpFileInfo >> thumbnailForm: aForm [
	thumbnail image: aForm
]
