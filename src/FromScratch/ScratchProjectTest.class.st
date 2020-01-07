"
A ScratchProjectTest is a test class for testing the behavior of ScratchProject
"
Class {
	#name : #ScratchProjectTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchProjectTest >> newApp [
	^ SpScratchApp basicNew
]

{ #category : #private }
ScratchProjectTest >> newProject [
	^ ScratchProject new
]

{ #category : #private }
ScratchProjectTest >> newScript [
	^ ScratchScript new
]

{ #category : #test }
ScratchProjectTest >> testAddScript [
	| p s |
	p := self newProject.
	self assert: p scripts isEmpty.
	s := self newScript.
	p addScript: s.
	self assert: p scripts size equals: 1.
	self assert: p scripts first equals: s.
	s := self newScript.
	p addScript: s.
	self assert: p scripts size equals: 2.
	self assert: p scripts second equals: s
]

{ #category : #test }
ScratchProjectTest >> testApplication [
	| p app |
	p := self newProject.
	self assert: p application isNil.
	app := self newApp.
	p application: app.
	self assert: p application equals: app
]

{ #category : #test }
ScratchProjectTest >> testAuthor [
	| p |
	p := self newProject.
	self assert: p author isEmpty.
	p author: 'abc'.
	self assert: p author equals: 'abc'
]

{ #category : #test }
ScratchProjectTest >> testComment [
	| p |
	p := self newProject.
	self assert: p comment isEmpty.
	p comment: 'abc'.
	self assert: p comment equals: 'abc'
]

{ #category : #test }
ScratchProjectTest >> testDeleteScript [
	| p s1 s2 s3 |
	p := self newProject.
	self assert: p scripts isEmpty.
	s1 := self newScript.
	p addScript: s1.
	s2 := self newScript.
	p addScript: s2.
	s3 := self newScript.
	p addScript: s3.
	self assert: p scripts size equals: 3.
	p deleteScript: s2.
	self assert: p scripts size equals: 2.
	self assert: p scripts first equals: s1.
	self assert: p scripts second equals: s3
]

{ #category : #test }
ScratchProjectTest >> testInfo [
	| p |
	p := self newProject.
	self assert: p info isDictionary
]

{ #category : #test }
ScratchProjectTest >> testInitialize [
	| p |
	p := self newProject.
	self assert: p info isDictionary.
	self assert: p scripts isArray.
	self assert: p modified
]

{ #category : #test }
ScratchProjectTest >> testIsEmpty [
	| p |
	p := self newProject.
	self assert: p isEmpty
]

{ #category : #test }
ScratchProjectTest >> testIsProject [
	| p |
	p := self newProject.
	self assert: p isProject
]

{ #category : #test }
ScratchProjectTest >> testModified [
	| p |
	p := self newProject.
	self assert: p modified.
	p modified: true.
	self assert: p modified.
	p modified: false.
	self deny: p modified
]

{ #category : #test }
ScratchProjectTest >> testScripts [
	| p |
	p := self newProject.
	self assert: p scripts isArray
]
