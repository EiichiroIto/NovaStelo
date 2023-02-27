Class {
	#name : #ScratchProjectReadWriter,
	#superclass : #Object,
	#instVars : [
		'objStream',
		'fileVersion',
		'fileVersionTag'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #private }
ScratchProjectReadWriter >> extractFileVersionOn: aStream [

	"Answer the Scratch file version number from the given string. If the string is of the form: 'ScratchVxx', were xx is a two-digit integer, answer the value of xx. Otherwise, answer 0."

	| str |
	str := (aStream next: self fileVersionString size) asString.
	(str beginsWith: fileVersionTag) ifFalse: [ ^ 0 ].
	^ (str copyFrom: fileVersionTag size + 1 to: str size)
		  asNumberNoError
]

{ #category : #api }
ScratchProjectReadWriter >> extractFormOn: aStream [

	| version info |
	version := self extractFileVersionOn: aStream.
	version = fileVersion ifFalse: [ ^ nil ].
	aStream skip: 4.
	info := objStream readObjFrom: aStream showProgress: false.
	^ info at: 'thumbnail'
]

{ #category : #api }
ScratchProjectReadWriter >> extractInfoFrom: aByteArray [

	| s version ret |
	s := ReadStream on: aByteArray.
	version := self extractFileVersionOn: s.
	version = fileVersion ifFalse: [ 
		^ self error: 'Invalid file version!' localized ].
	s skip: 4.
	ret := objStream readObjFrom: s showProgress: false.
	s close.
	^ ret
]

{ #category : #api }
ScratchProjectReadWriter >> extractProjectFrom: aByteArray [

	| s version project |
	s := ReadStream on: aByteArray.
	version := self extractFileVersionOn: s.
	version = fileVersion ifFalse: [ 
		^ self error: 'Invalid file version!' localized ].
	s skip: s uint32.
	project := objStream readObjFrom: s showProgress: true.
	s close.
	project isProject ifFalse: [ 
		^ self error:
			  'Invalid project format:' localized , project class asString ].
	project scripts do: [ :m | 
		m
			setupBlockSpecs;
			convertStacksToTuples;
			convertTuplesToStacks;
			project: project ].
	^ project
]

{ #category : #accessing }
ScratchProjectReadWriter >> fileVersion [

	^ fileVersion
]

{ #category : #accessing }
ScratchProjectReadWriter >> fileVersion: anObject [

	fileVersion := anObject
]

{ #category : #api }
ScratchProjectReadWriter >> fileVersionString [

	^ fileVersionTag , fileVersion asTwoCharacterString
]

{ #category : #accessing }
ScratchProjectReadWriter >> fileVersionTag [

	^ fileVersionTag
]

{ #category : #accessing }
ScratchProjectReadWriter >> fileVersionTag: anObject [

	fileVersionTag := anObject
]

{ #category : #accessing }
ScratchProjectReadWriter >> objStream [

	^ objStream
]

{ #category : #accessing }
ScratchProjectReadWriter >> objStream: anObject [

	objStream := anObject
]

{ #category : #private }
ScratchProjectReadWriter >> storeProjectInfo: aDictionary on: aBinaryStream [

	| s |
	s := WriteStream on: (ByteArray new: 100000).
	objStream storeObj: aDictionary on: s.
	aBinaryStream uint32: s size.
	aBinaryStream nextPutAll: s contents
]

{ #category : #api }
ScratchProjectReadWriter >> writeProject: aProject to: aStream [

	aProject scripts do: [ :script | 
		script fixScriptBeforeWriting.
		script convertStacksToTuples ].
	[ 
	aStream nextPutAll: self fileVersionString asByteArray.
	self storeProjectInfo: aProject info on: aStream.
	objStream storeObj: aProject on: aStream ] ensure: [ 
		aProject scripts do: [ :m | m convertTuplesToStacks ] ]
]
