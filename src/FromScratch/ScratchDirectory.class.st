Class {
	#name : #ScratchDirectory,
	#superclass : #Object,
	#instVars : [
		'appName',
		'homeDirectory',
		'lastDirectories'
	],
	#classVars : [
		'Current'
	],
	#category : #'FromScratch-Core'
}

{ #category : #accessing }
ScratchDirectory class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
ScratchDirectory class >> reset [
	Current := nil
]

{ #category : #accessing }
ScratchDirectory >> appName [
	^ appName
]

{ #category : #accessing }
ScratchDirectory >> appName: aString [
	appName := aString
]

{ #category : #private }
ScratchDirectory >> computer [
	^ FileLocator root asFileReference
]

{ #category : #private }
ScratchDirectory >> desktop [
	| fr |
	fr := self documents parent.
	(fr / 'Desktop') isDirectory
		ifFalse: [ ^ fr ].
	^ fr / 'Desktop'
]

{ #category : #private }
ScratchDirectory >> documents [
	Smalltalk os isWindows
		ifTrue: [ self windowsDocuments ifNotNil: [ :dir | ^ dir ] ].
	^ FileLocator documents asFileReference
]

{ #category : #private }
ScratchDirectory >> examples [
	| dir |
	dir := FileSystem workingDirectory / 'Examples'.
	dir isDirectory
		ifFalse: [ dir := FileSystem workingDirectory ].
	^ dir
]

{ #category : #accessing }
ScratchDirectory >> getDefaultFolderForType: aSymbol [
	(#(project export) includes: aSymbol)
		ifTrue: [ ^ self project ].
	^ self user
]

{ #category : #accessing }
ScratchDirectory >> getLastFolderForType: aSymbol [
	| dir |
	dir := lastDirectories at: aSymbol ifAbsent: [ nil ].
	(dir notNil and: [ dir isDirectory ])
		ifTrue: [ ^ dir ].
	^ self getDefaultFolderForType: aSymbol
]

{ #category : #initialization }
ScratchDirectory >> initialize [
	appName := nil.
	lastDirectories := Dictionary new.
	homeDirectory := nil
]

{ #category : #accessing }
ScratchDirectory >> lastFolderIsSampleProjectsFolder [
	| lastDirPath sampleProjectDirPath |
	lastDirPath := (self getLastFolderForType: #project) pathString.
	sampleProjectDirPath := self examples pathString.
	^ lastDirPath beginsWith: sampleProjectDirPath
]

{ #category : #private }
ScratchDirectory >> privHomeDirectory [
	^ homeDirectory
]

{ #category : #private }
ScratchDirectory >> privHomeDirectory: aFileReference [
	homeDirectory := aFileReference
]

{ #category : #private }
ScratchDirectory >> privLastDirectories [
	^ lastDirectories
]

{ #category : #private }
ScratchDirectory >> project [
	^ self projectFor: self appName
]

{ #category : #private }
ScratchDirectory >> projectFor: aString [
	| dir |
	aString ifNil: [ ^ FileSystem workingDirectory ].
	dir := self documents / aString.
	dir exists
		ifFalse: [ dir createDirectory ].
	dir isDirectory
		ifFalse: [ dir := FileSystem workingDirectory ].
	^ dir
]

{ #category : #accessing }
ScratchDirectory >> setHomeDir: aFileReference [
	homeDirectory := aFileReference asFileReference
]

{ #category : #accessing }
ScratchDirectory >> setLastFolderTo: aFileReference forType: aSymbol [
	lastDirectories at: aSymbol put: aFileReference
]

{ #category : #private }
ScratchDirectory >> user [
	^ homeDirectory ifNil: [ self documents ]
]

{ #category : #private }
ScratchDirectory >> windowsDocuments [
	| drive path fr |
	drive := Smalltalk os environment at: 'HOMEDRIVE' ifAbsent: [ ^ nil ].
	path := Smalltalk os environment at: 'HOMEPATH' ifAbsent: [ ^ nil ].
	fr := (drive , path) asFileReference.
	fr isDirectory
		ifFalse: [ ^ nil ].
	(fr / 'Documents') isDirectory
		ifFalse: [ ^ fr ].
	^ fr / 'Documents'
]
