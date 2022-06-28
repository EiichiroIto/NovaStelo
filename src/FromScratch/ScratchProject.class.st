Class {
	#name : #ScratchProject,
	#superclass : #Object,
	#instVars : [
		'scripts',
		'application',
		'info',
		'modified'
	],
	#category : #'FromScratch-Project'
}

{ #category : #constants }
ScratchProject class >> fileVersion [
	self subclassResponsibility
]

{ #category : #accessing }
ScratchProject class >> fileVersionString [
	^ self fileVersionTag , self fileVersion asTwoCharacterString
]

{ #category : #constants }
ScratchProject class >> fileVersionTag [
	self subclassResponsibility
]

{ #category : #accessing }
ScratchProject class >> formFromStream: aStream [
	| version info |
	version := self objStreamClass fileVersion: self from: aStream.
	version = self fileVersion
		ifFalse: [ ^ nil ].
	aStream skip: 4.
	info := self objStreamClass new
		readObjFrom: aStream
		showProgress: false.
	^ info at: 'thumbnail'
]

{ #category : #constants }
ScratchProject class >> objStreamClass [
	self subclassResponsibility
]

{ #category : #'ston-core' }
ScratchProject class >> stonAllInstVarNames [
	^ #(scripts info)
]

{ #category : #private }
ScratchProject >> addScript: aScript [
	scripts := scripts copyWith: aScript
]

{ #category : #accessing }
ScratchProject >> allEventNames [
	"Answer a list of all events that have been defined in this project."

	| result |
	result := Set new: 100.
	self scripts do: [ :m | m addEventNamesTo: result ].
	result remove: '' ifAbsent: [  ].
	^ result asArray sort
]

{ #category : #accessing }
ScratchProject >> allSubNames [
	| result |
	result := Set new.
	self scripts do: [ :each | result addAll: each subNames ].
	^ result asArray sort
]

{ #category : #accessing }
ScratchProject >> application [
	^ application
]

{ #category : #accessing }
ScratchProject >> application: anApplication [
	application := anApplication
]

{ #category : #accessing }
ScratchProject >> assureExistsBreed: aString [
	self subclassResponsibility
]

{ #category : #accessing }
ScratchProject >> author [
	^ info at: #author ifAbsent: [ '' ]
]

{ #category : #accessing }
ScratchProject >> author: aString [
	^ info at: #author put: aString
]

{ #category : #accessing }
ScratchProject >> comment [
	^ info at: 'comment' ifAbsent: [ '' ]
]

{ #category : #accessing }
ScratchProject >> comment: aString [
	info at: 'comment' put: aString asString
]

{ #category : #accessing }
ScratchProject >> defaultEventName [
	| evtNames |
	evtNames := self allEventNames.
	^ evtNames isEmpty
		ifTrue: [ '' ]
		ifFalse: [ evtNames first ]
]

{ #category : #accessing }
ScratchProject >> defaultSubName [
	| list |
	list := self allSubNames.
	^ list isEmpty
		ifTrue: [ '' ]
		ifFalse: [ list first ]
]

{ #category : #private }
ScratchProject >> deleteScript: aScript [
	scripts := scripts copyWithoutIndex: (scripts indexOf: aScript)
]

{ #category : #'file read/write' }
ScratchProject >> extractInfoFrom: aByteArray [
	| s version obj |
	obj := self newObjStream.
	s := ReadStream on: aByteArray.
	version := obj class fileVersion: self class from: s.
	version = self class fileVersion
		ifFalse: [ ^ self inform: 'Invalid file version!' localized ].
	s skip: 4.
	info := obj readObjFrom: s showProgress: false
]

{ #category : #'file read/write' }
ScratchProject >> extractProjectFrom: aByteArray [
	| s version proj obj |
	obj := self newObjStream.
	s := ReadStream on: aByteArray.
	version := obj class fileVersion: self class from: s.
	version = self class fileVersion
		ifFalse: [ ^ self inform: 'Invalid file version!' localized ].
	s skip: s uint32.
	proj := obj readObjFrom: s showProgress: true.
	self handOverTo: proj.
	proj isProject
		ifFalse: [ ^ self error: 'Invalid project format:' localized , proj class asString ].
	proj scripts
		do: [ :m | 
			m
				setupBlockDef;
				convertStacksToTuples;
				convertTuplesToStacks;
				project: proj ].
	^ proj
]

{ #category : #'object i/o' }
ScratchProject >> fieldsVersion [
	^ 1
]

{ #category : #accessing }
ScratchProject >> fileVersion [
	^ self class fileVersion
]

{ #category : #accessing }
ScratchProject >> findObjName: aString [
	^ self scripts detect: [ :each | each objName = aString ] ifNone: [ nil ]
]

{ #category : #accessing }
ScratchProject >> fixUnsavedFields [
	scripts do: #fixUnsavedFields
]

{ #category : #'file read/write' }
ScratchProject >> getScratchInfoFrom: aFileReference [
	| result f version buf obj |
	obj := self newObjStream.
	result := Dictionary new.
	SpScratchApp
		try: [ f := aFileReference binaryReadStream.
			version := obj class fileVersion: self class from: f.
			version = self class fileVersion
				ifFalse: [ self inform: 'Invalid file version!' localized.
					^ nil ].
			buf := f next: f uint32.
			result := obj readObjFrom: (ReadStream on: buf).
			f close ]
		onFailure: [ ^ nil ].
	^ result
]

{ #category : #accessing }
ScratchProject >> handOverTo: aProject [

	"self subclassResponsibility"
]

{ #category : #accessing }
ScratchProject >> info [
	^ info
]

{ #category : #'object i/o' }
ScratchProject >> initFieldsFrom: anObjStream version: classVersion [
	self
		initFieldsNamed: #(scripts info)
		from: anObjStream
]

{ #category : #initialization }
ScratchProject >> initialize [
	info := Dictionary new.
	scripts := Array new.
	modified := true
]

{ #category : #testing }
ScratchProject >> isEmpty [
	^ true
]

{ #category : #testing }
ScratchProject >> isProject [
	^ true
]

{ #category : #accessing }
ScratchProject >> modified [
	^ modified
]

{ #category : #accessing }
ScratchProject >> modified: aBoolean [
	modified := aBoolean
]

{ #category : #accessing }
ScratchProject >> newCode [
	^ application newCode
]

{ #category : #private }
ScratchProject >> newObjStream [
	^ self class objStreamClass new
]

{ #category : #'file read/write' }
ScratchProject >> readProjectFrom: aFileReference [

	| f projData newProj |
	f := aFileReference binaryReadStream.
	f ifNil: [ 
		SpScratchApp alert:
			'Could not read file: ' localized , aFileReference pathString.
		^ nil ].
	SpScratchApp
		try: [ 
			projData := f contents.
			newProj := self extractProjectFrom: projData.
			newProj extractInfoFrom: projData ]
		onFailure: [ :err :rcvr | 
			SpScratchApp alert: err.
			^ nil ].
	self modified: false.
	^ newProj
]

{ #category : #accessing }
ScratchProject >> scripts [
	^ scripts
]

{ #category : #accessing }
ScratchProject >> scriptsForMenu [
	^ self scripts
]

{ #category : #'object i/o' }
ScratchProject >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(scripts info) on: anObjStream.
]

{ #category : #'file read/write' }
ScratchProject >> storeProjectInfoOn: aBinaryStream [
	| s |
	s := WriteStream on: (ByteArray new: 100000).
	self newObjStream storeObj: info on: s.
	aBinaryStream uint32: s size.
	aBinaryStream nextPutAll: s contents
]

{ #category : #'file read/write' }
ScratchProject >> thumbnailForm: aForm [
	info at: 'thumbnail' put: aForm
]

{ #category : #'file read/write' }
ScratchProject >> unusedNameStartingWith: prefix in: aFileReference [
	| usedNames i result |
	usedNames := (aFileReference entries
		collect: [ :each | each basename ]) asSet.
	i := 0.
	result := prefix , '0'.
	[ usedNames includes: result ]
		whileTrue: [ result := prefix , (i := i + 1) printString ].
	^ aFileReference / result
]

{ #category : #'file read/write' }
ScratchProject >> writeProjectAs: aFileReference [

	| saveError out tmpFile |
	"self scripts setupBlockDef."
	self scripts do: [ :m | 
		m blocksBin allMorphsDo: [ :b | 
			b isBlockMorph ifTrue: [ b stopProcess ] ].
		m convertStacksToTuples ].
	saveError := nil.
	tmpFile := (self
		            unusedNameStartingWith: 'tmp'
		            in: aFileReference parent) asFileReference.
	SpScratchApp
		try: [ 
			out := tmpFile binaryWriteStream.
			out
				ifNil: [ 
				saveError := 'Folder may be locked or read-only' localized ]
				ifNotNil: [ 
					out nextPutAll: self class fileVersionString asByteArray.
					self storeProjectInfoOn: out.
					self newObjStream storeObj: self on: out.
					out close ] ]
		onFailure: [ :err :rcvr | 
			out ifNotNil: [ 
				[ 
				out close.
				tmpFile delete ]
					on: Error
					do: [  ] ].
			saveError := err ].
	self scripts do: [ :m | m convertTuplesToStacks ].
	saveError ifNotNil: [ 
		SpScratchApp alert: saveError title: 'Save failed' localized.
		^ false ].
	aFileReference deleteIfAbsent: [  ].
	[ tmpFile renameTo: aFileReference basename ]
		on: Error
		do: [ 
			SpScratchApp alert:
				'Save failed. The folder may be read-only.' localized.
			^ false ].
	self modified: false.
	^ true
]
