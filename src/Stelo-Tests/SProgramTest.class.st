"
A SProgramTest is a test class for testing the behavior of SProgram
"
Class {
	#name : #SProgramTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #test }
SProgramTest >> testAddCode [
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p addCode: #(1 2 3 4).
	self assertCollection: p codes equals: #(1 2 3 4).
	p addCode: #(5 6 7).
	self assertCollection: p codes equals: #(1 2 3 4 5 6 7).
]

{ #category : #test }
SProgramTest >> testAddEntryPointEventNoBreedNo [
	| p |
	p := SProgram new.
	self assert: p eventNoList isEmpty.
	p addEntryPoint: 5 eventNo: 1 breedNo: 2.
	p addEntryPoint: 6 eventNo: 2 breedNo: 2.
	p addEntryPoint: 7 eventNo: 3 breedNo: 2.
	p addEntryPoint: 8 eventNo: 1 breedNo: 1.
	p addEntryPoint: 9 eventNo: 3 breedNo: 1.
	p addEntryPoint: 10 eventNo: 2 breedNo: 3.
	p addEntryPoint: 11 eventNo: 3 breedNo: 3.
	self assertCollection: p eventNoList equals: #(1 2 3).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 1) asArray equals: #(8).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 2) asArray equals: #(5).
	self assertCollection: ((p forEventNo: 1) forBreedNo: 3) asArray equals: #().
	self assertCollection: ((p forEventNo: 2) forBreedNo: 1) asArray equals: #().
	self assertCollection: ((p forEventNo: 2) forBreedNo: 2) asArray equals: #(6).
	self assertCollection: ((p forEventNo: 2) forBreedNo: 3) asArray equals: #(10).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 1) asArray equals: #(9).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 2) asArray equals: #(7).
	self assertCollection: ((p forEventNo: 3) forBreedNo: 3) asArray equals: #(11).
]

{ #category : #test }
SProgramTest >> testBytecode [
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p privCodes: #(1 2 3).
	self assertCollection: p bytecode equals: #(1 2 3).
	p privCodes: #(1 2 div mod 3).
	self assertCollection: p bytecode equals: #(1 2 27 56 3).
]

{ #category : #test }
SProgramTest >> testCodes [
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p privCodes: #(1 2 3).
	self assertCollection: p codes equals: #(1 2 3).
	p privCodes: #(4 5 6).
	self assertCollection: p codes equals: #(4 5 6).
]

{ #category : #test }
SProgramTest >> testEntryPointList [
	| p ret |
	p := SProgram new.
	self assert: p entryPointList isEmpty.
	p addEntryPoint: 5 eventNo: 1 breedNo: 2.
	p addEntryPoint: 6 eventNo: 2 breedNo: 2.
	p addEntryPoint: 7 eventNo: 3 breedNo: 2.
	p addEntryPoint: 8 eventNo: 1 breedNo: 1.
	p addEntryPoint: 9 eventNo: 3 breedNo: 1.
	p addEntryPoint: 10 eventNo: 2 breedNo: 3.
	p addEntryPoint: 11 eventNo: 3 breedNo: 3.
	ret := p entryPointList.
	self assert: ret isArray.
	self assert: ret size equals: 7.
	self assertCollection: ret first equals: #(1 1 8).
	self assertCollection: ret second equals: #(1 2 5).
	self assertCollection: ret third equals: #(2 2 6).
	self assertCollection: ret fourth equals: #(2 3 10).
	self assertCollection: ret fifth equals: #(3 1 9).
	self assertCollection: ret sixth equals: #(3 2 7).
	self assertCollection: ret seventh equals: #(3 3 11)
]

{ #category : #test }
SProgramTest >> testEventNoList [
	| p |
	p := SProgram new.
	self assert: p eventNoList isEmpty.
	p forEventNo: 1.
	p forEventNo: 3.
	self assertCollection: p eventNoList sort equals: #(1 3).
]

{ #category : #'tests-accessing' }
SProgramTest >> testForEventNo [
	| p c1 c2 |
	p := SProgram new.
	self assert: p privEntryPoints isEmpty.
	c1 := p forEventNo: 1.
	self assert: (c1 isKindOf: SEntryPoints).
	self assert: p privEntryPoints size equals: 1.
	self assert: (p privEntryPoints at: 1) equals: c1.
	c2 := p forEventNo: 2.
	self assert: (c2 isKindOf: SEntryPoints).
	self assert: p privEntryPoints size equals: 2.
	self assert: (p privEntryPoints at: 2) equals: c2.
	self assert: c1 ~= c2.
]

{ #category : #'tests-initialization' }
SProgramTest >> testInitialize [
	self testPrivEntryPoints.
]

{ #category : #test }
SProgramTest >> testNextAddress [
	| p |
	p := SProgram new.
	self assert: p nextAddress equals: 1.
	p addCode: #(1 2 3 4).
	self assert: p nextAddress equals: 5.
	p addCode: #(5 6 7).
	self assert: p nextAddress equals: 8.
]

{ #category : #test }
SProgramTest >> testPrivCodes [
	self testCodes.
]

{ #category : #'tests-private' }
SProgramTest >> testPrivEntryPoints [
	| p |
	p := SProgram new.
	self assert: p privEntryPoints isDictionary.
	self assert: p privEntryPoints isEmpty.
]
