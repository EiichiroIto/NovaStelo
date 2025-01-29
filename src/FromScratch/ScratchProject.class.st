Class {
	#name : 'ScratchProject',
	#superclass : 'Object',
	#instVars : [
		'scripts',
		'application',
		'info',
		'modified'
	],
	#category : 'FromScratch-Project',
	#package : 'FromScratch',
	#tag : 'Project'
}

{ #category : 'constants' }
ScratchProject class >> fileVersion [
	self subclassResponsibility
]

{ #category : 'constants' }
ScratchProject class >> fileVersionTag [
	self subclassResponsibility
]

{ #category : 'accessing' }
ScratchProject class >> formFromStream: aStream [

	| reader form |
	reader := self new newProjectReadWriter.
	form := SpScratchApp
		        try: [ reader extractFormOn: aStream ]
		        onFailure: [ nil ].
	^ form
]

{ #category : 'constants' }
ScratchProject class >> objStreamClass [
	self subclassResponsibility
]

{ #category : 'ston-core' }
ScratchProject class >> stonAllInstVarNames [
	^ #(scripts info)
]

{ #category : 'private' }
ScratchProject >> addScript: aScript [
	scripts := scripts copyWith: aScript
]

{ #category : 'accessing' }
ScratchProject >> allEventNames [

	"Answer a list of all events that have been defined in this project."

	| result |
	result := Set new: 100.
	scripts do: [ :m | m addEventNamesTo: result ].
	result remove: '' ifAbsent: [  ].
	^ result asArray sort
]

{ #category : 'accessing' }
ScratchProject >> allSubNames [

	| result |
	result := Set new.
	scripts do: [ :each | result addAll: each subNames ].
	^ result asArray sort
]

{ #category : 'accessing' }
ScratchProject >> application [
	^ application
]

{ #category : 'accessing' }
ScratchProject >> application: anApplication [
	application := anApplication
]

{ #category : 'api' }
ScratchProject >> assureExistsScriptNamed: aString [
	self subclassResponsibility
]

{ #category : 'accessing' }
ScratchProject >> author [
	^ info at: #author ifAbsent: [ '' ]
]

{ #category : 'accessing' }
ScratchProject >> author: aString [
	^ info at: #author put: aString
]

{ #category : 'accessing' }
ScratchProject >> comment [
	^ info at: 'comment' ifAbsent: [ '' ]
]

{ #category : 'accessing' }
ScratchProject >> comment: aString [
	info at: 'comment' put: aString asString
]

{ #category : 'accessing' }
ScratchProject >> defaultEventName [
	| evtNames |
	evtNames := self allEventNames.
	^ evtNames isEmpty
		ifTrue: [ '' ]
		ifFalse: [ evtNames first ]
]

{ #category : 'accessing' }
ScratchProject >> defaultSubName [
	| list |
	list := self allSubNames.
	^ list isEmpty
		ifTrue: [ '' ]
		ifFalse: [ list first ]
]

{ #category : 'private' }
ScratchProject >> deleteScript: aScript [
	scripts := scripts copyWithoutIndex: (scripts indexOf: aScript)
]

{ #category : 'object i/o' }
ScratchProject >> fieldsVersion [
	^ 1
]

{ #category : 'api' }
ScratchProject >> fixUnsavedFields [
	scripts do: #fixUnsavedFields
]

{ #category : 'accessing' }
ScratchProject >> info [
	^ info
]

{ #category : 'accessing' }
ScratchProject >> info: aDictionary [

	info := aDictionary
]

{ #category : 'object i/o' }
ScratchProject >> initFieldsFrom: anObjStream version: classVersion [
	self
		initFieldsNamed: #(scripts info)
		from: anObjStream
]

{ #category : 'initialization' }
ScratchProject >> initialize [
	info := Dictionary new.
	scripts := Array new.
	modified := true
]

{ #category : 'testing' }
ScratchProject >> isEmpty [
	^ true
]

{ #category : 'testing' }
ScratchProject >> isProject [
	^ true
]

{ #category : 'accessing' }
ScratchProject >> modified [
	^ modified
]

{ #category : 'accessing' }
ScratchProject >> modified: aBoolean [

	modified = aBoolean ifTrue: [ ^ self ].
	modified := aBoolean.
	application ifNotNil: [ application projectModified ]
]

{ #category : 'instance creation' }
ScratchProject >> newCode [
	^ application newCode
]

{ #category : 'instance creation' }
ScratchProject >> newObjStream [
	^ self class objStreamClass new
]

{ #category : 'instance creation' }
ScratchProject >> newProjectReadWriter [

	^ ScratchProjectReadWriter new
		  objStream: self newObjStream;
		  fileVersion: self class fileVersion;
		  fileVersionTag: self class fileVersionTag;
		  yourself
]

{ #category : 'accessing' }
ScratchProject >> scriptNamed: aString [

	^ scripts detect: [ :each | each objName = aString ] ifNone: [ nil ]
]

{ #category : 'accessing' }
ScratchProject >> scriptNames [

	^ scripts collect: #objName
]

{ #category : 'accessing' }
ScratchProject >> scripts [
	^ scripts
]

{ #category : 'accessing' }
ScratchProject >> scriptsForMenu [
	^ self scripts
]

{ #category : 'api' }
ScratchProject >> setupBlockSpecs [

	scripts do: #setupBlockSpecs
]

{ #category : 'api' }
ScratchProject >> setupScripts [

	self subclassResponsibility
]

{ #category : 'object i/o' }
ScratchProject >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(scripts info) on: anObjStream.
]

{ #category : 'api' }
ScratchProject >> thumbnailForm: aForm [
	info at: 'thumbnail' put: aForm
]
