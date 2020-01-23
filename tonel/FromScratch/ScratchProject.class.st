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

{ #category : #accessing }
ScratchProject class >> appVersion [
	self subclassResponsibility
]

{ #category : #accessing }
ScratchProject class >> appVersionTag [
	self subclassResponsibility
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
ScratchProject >> appVersion [
	^ self class appVersion
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

{ #category : #private }
ScratchProject >> deleteScript: aScript [
	scripts := scripts copyWithoutIndex: (scripts indexOf: aScript)
]

{ #category : #'file read/write' }
ScratchProject >> extractInfoFrom: aByteArray [
	| s version |
	s := ReadStream on: aByteArray.
	version := ObjStream fileVersion: self class from: s.
	version = 1
		ifFalse: [ ^ self error: 'Invalid version' ].
	s skip: 4.
	info := self newObjStream readObjFrom: s showProgress: false
]

{ #category : #'file read/write' }
ScratchProject >> extractProjectFrom: aByteArray [
	| s version proj |
	s := ReadStream on: aByteArray.
	version := ObjStream fileVersion: self class from: s.
	version = 1
		ifFalse: [ ^ self error: 'Invalid version' ].
	s skip: s uint32.
	proj := self newObjStream readObjFrom: s showProgress: true.
	proj isProject
		ifFalse: [ ^ self error: 'Invalid project format :' , proj class asString ].
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
ScratchProject >> findObjName: aString [
	^ self scripts detect: [ :each | each objName = aString ]
]

{ #category : #accessing }
ScratchProject >> getScratchInfoFrom: aFileReference [
	| result f version buf |
	result := Dictionary new.
	SpScratchApp
		try: [ f := aFileReference binaryReadStream.
			version := ObjStream fileVersion: self class from: f.
			version = 1
				ifFalse: [ self error: 'invalid version' ].
			buf := f next: f uint32.
			result := ObjStream new readObjFrom: (ReadStream on: buf).
			f close ]
		onFailure: [ ^ nil ].
	^ result
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

{ #category : #private }
ScratchProject >> newObjStream [
	self subclassResponsibility
]

{ #category : #private }
ScratchProject >> newProgram [
	self subclassResponsibility
]

{ #category : #accessing }
ScratchProject >> programOf: aDictionary [
	| program |
	program := self newProgram.
	self scripts
		do: [ :each | each setupProgram: program events: aDictionary ].
	^ program
]

{ #category : #'file read/write' }
ScratchProject >> readProjectFrom: aFileReference [
	| f projData newProj |
	f := aFileReference binaryReadStream.
	f
		ifNil: [ UIManager default
				alert: aFileReference pathString
				title: 'Could not read' localized.
			^ nil ].
	SpScratchApp
		try: [ projData := f contents.
			newProj := self extractProjectFrom: projData.
			newProj extractInfoFrom: projData ]
		onFailure: [ :err :rcvr | 
			UIManager default
				alert: err
				title: 'Could not read project; file may be damaged'.
			^ nil ].
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

{ #category : #accessing }
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
	self scripts
		do: [ :m | 
			m blocksBin
				allMorphsDo: [ :b | 
					b isBlockMorph
						ifTrue: [ b stop ] ].
			m convertStacksToTuples ].
	saveError := nil.
	tmpFile := (self
		unusedNameStartingWith: 'tmp'
		in: aFileReference parent) asFileReference.
	SpScratchApp
		try: [ out := tmpFile binaryWriteStream.
			out
				ifNil: [ saveError := 'Folder may be locked or read-only' ]
				ifNotNil: [ out nextPutAll: self appVersion asByteArray.
					self storeProjectInfoOn: out.
					self newObjStream storeObj: self on: out.
					out close ] ]
		onFailure: [ :err :rcvr | 
			out
				ifNotNil: [ [ out close.
					tmpFile delete ] ifError: [  ] ].
			saveError := err ].
	self scripts do: [ :m | m convertTuplesToStacks ].
	saveError
		ifNotNil: [ UIManager default alert: saveError title: 'Save failed'.
			^ false ].
	aFileReference deleteIfAbsent: [  ].
	[ tmpFile renameTo: aFileReference basename ]
		ifError: [ UIManager default
				alert: 'Is the folder read-only?' localized
				title: 'Save failed'.
			^ false ].
	^ true
]
