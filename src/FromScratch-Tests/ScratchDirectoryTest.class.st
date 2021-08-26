"
A ScratchDirectoryTest is a test class for testing the behavior of ScratchDirectory
"
Class {
	#name : #ScratchDirectoryTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchDirectoryTest >> newDirectory [
	^ ScratchDirectory new
]

{ #category : #test }
ScratchDirectoryTest >> testAppName [
	| d |
	d := self newDirectory.
	self assert: d appName isNil.
	d appName: 'abc'.
	self assert: d appName equals: 'abc'
]

{ #category : #test }
ScratchDirectoryTest >> testComputer [
	| d |
	d := self newDirectory.
	self assert: (d computer isKindOf: FileReference).
	self assert: d computer isDirectory
]

{ #category : #test }
ScratchDirectoryTest >> testDesktop [
	| d |
	d := self newDirectory.
	self assert: (d desktop isKindOf: FileReference).
	self assert: d desktop isDirectory
]

{ #category : #test }
ScratchDirectoryTest >> testDocuments [
	| d |
	d := self newDirectory.
	self assert: (d documents isKindOf: FileReference)
]

{ #category : #test }
ScratchDirectoryTest >> testExamples [
	| d |
	d := self newDirectory.
	self assert: (d examples isKindOf: FileReference).
	self assert: d examples isDirectory
]

{ #category : #test }
ScratchDirectoryTest >> testGetDefaultFolderForType [
	| d |
	d := self newDirectory.
	self assert: (d getDefaultFolderForType: #project) equals: d project.
	self assert: (d getDefaultFolderForType: #export) equals: d project.
	self assert: (d getDefaultFolderForType: #test) equals: d user
]

{ #category : #test }
ScratchDirectoryTest >> testGetLastFolderForType [
	| d x |
	d := self newDirectory.
	self assert: (d getLastFolderForType: #projects) equals: d user.
	self assert: (d getLastFolderForType: #user) equals: d user.
	x := FileSystem workingDirectory.
	d setLastFolderTo: x forType: #projects.
	self assert: (d getLastFolderForType: #projects) equals: x.
	self assert: (d getLastFolderForType: #user) equals: d user.
]

{ #category : #test }
ScratchDirectoryTest >> testInitialize [
	| d |
	d := self newDirectory.
	self assert: d appName isNil.
	self assert: d privLastDirectories isDictionary.
	self assert: d privLastDirectories isEmpty.
	self assert: d privHomeDirectory isNil
]

{ #category : #test }
ScratchDirectoryTest >> testLastFolderIsSampleProjectsFolder [
	| d |
	d := self newDirectory.
	d
		setLastFolderTo: FileLocator documents asFileReference
		forType: #project.
	self deny: d lastFolderIsSampleProjectsFolder.
	d setLastFolderTo: d examples forType: #project.
	self assert: d lastFolderIsSampleProjectsFolder
]

{ #category : #test }
ScratchDirectoryTest >> testPrivHomeDirectory [
	| d x |
	d := self newDirectory.
	self assert: d privHomeDirectory isNil.
	x := FileSystem workingDirectory.
	d privHomeDirectory: x.
	self assert: d privHomeDirectory equals: x
]

{ #category : #test }
ScratchDirectoryTest >> testPrivLastDirectories [
	| d |
	d := self newDirectory.
	self assert: d privLastDirectories isDictionary.
	self assert: d privLastDirectories isEmpty
]

{ #category : #test }
ScratchDirectoryTest >> testProject [
	| d x y |
	d := self newDirectory.
	x := FileSystem workingDirectory.
	self assert: d project equals: x.
	x := FileLocator documents asFileReference.
	(x / '_xx_') isDirectory
		ifTrue: [ (x / '_xx_') delete ].
	d appName: '_xx_'.
	y := d project.
	self assert: y pathString equals: (x / '_xx_') pathString.
	self assert: (x / '_xx_') isDirectory.
	(x / '_xx_') delete
]

{ #category : #test }
ScratchDirectoryTest >> testProjectFor [
	| d x y |
	d := self newDirectory.
	x := FileSystem workingDirectory.
	self assert: (d projectFor: nil) equals: x.
	x := FileLocator documents asFileReference.
	(x / '_xx_') isDirectory
		ifTrue: [ (x / '_xx_') delete ].
	y := d projectFor: '_xx_'.
	self assert: y pathString equals: (x / '_xx_') pathString.
	self assert: (x / '_xx_') isDirectory.
	(x / '_xx_') delete
]

{ #category : #test }
ScratchDirectoryTest >> testSetHomeDir [
	self testUser
]

{ #category : #test }
ScratchDirectoryTest >> testSetLastFolderToForType [
	self testGetLastFolderForType
]

{ #category : #test }
ScratchDirectoryTest >> testUser [
	| d u x |
	d := self newDirectory.
	u := d user.
	self assert: (u isKindOf: FileReference).
	x := FileSystem workingDirectory.
	d setHomeDir: x.
	self assert: d user equals: x
]

{ #category : #test }
ScratchDirectoryTest >> testWindowsDocuments [
	| d dir |
	d := self newDirectory.
	dir := d windowsDocuments.
	Smalltalk os isWindows
		ifTrue: [ self assert: dir isDirectory ]
		ifFalse: [ self assert: dir isNil ]
]
