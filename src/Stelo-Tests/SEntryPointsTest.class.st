"
A SEventCodesTest is a test class for testing the behavior of SEventCodes
"
Class {
	#name : #SEntryPointsTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #test }
SEntryPointsTest >> testAddEntryPointForBreedNo [
	| p |
	p := SEntryPoints new.
	p addEntryPoint: 5 forBreedNo: 1.
	p addEntryPoint: 6 forBreedNo: 2.
	p addEntryPoint: 7 forBreedNo: 3.
	p addEntryPoint: 8 forBreedNo: 1.
	p addEntryPoint: 9 forBreedNo: 3.
	self assertCollection: p breedNoList equals: #(1 2 3).
	self assertCollection: (p forBreedNo: 1) asArray equals: #(5 8).
	self assertCollection: (p forBreedNo: 2) asArray equals: #(6).
	self assertCollection: (p forBreedNo: 3) asArray equals: #(7 9).
]

{ #category : #test }
SEntryPointsTest >> testBreedNoList [
	| e |
	e := SEntryPoints new.
	self assert: e breedNoList isEmpty.
	e addEntryPoint: 1 forBreedNo: 7.
	e addEntryPoint: 2 forBreedNo: 2.
	e addEntryPoint: 1 forBreedNo: 7.
	self assertCollection: e breedNoList sort equals: #(2 7).
]

{ #category : #test }
SEntryPointsTest >> testEntryPointList [
	| e ret |
	e := SEntryPoints new.
	self assert: e breedNoList isEmpty.
	e addEntryPoint: 5 forBreedNo: 7.
	e addEntryPoint: 2 forBreedNo: 2.
	e addEntryPoint: 1 forBreedNo: 7.
	ret := e entryPointList.
	self assert: ret isArray.
	self assert: ret size equals: 3.
	self assertCollection: ret first equals: #(2 2).
	self assertCollection: ret second equals: #(7 5).
	self assertCollection: ret third equals: #(7 1).
]

{ #category : #'tests-accessing' }
SEntryPointsTest >> testForBreedNo [
	| c l |
	c := SEntryPoints new.
	c addEntryPoint: 1 forBreedNo: 1.
	c addEntryPoint: 4 forBreedNo: 2.
	c addEntryPoint: 7 forBreedNo: 3.
	c addEntryPoint: 10 forBreedNo: 2.
	l := c forBreedNo: 1.
	self assert: l isCollection.
	self assert: l size equals: 1.
	self assertCollection: l asArray equals: #(1).
	l := c forBreedNo: 2.
	self assert: l isCollection.
	self assert: l size equals: 2.
	self assertCollection: l asArray equals: #(4 10).
	l := c forBreedNo: 3.
	self assert: l isCollection.
	self assert: l size equals: 1.
	self assertCollection: l asArray equals: #(7).
]

{ #category : #'tests-initialization' }
SEntryPointsTest >> testInitialize [
	self testPrivBreeds.
]

{ #category : #'tests-testing' }
SEntryPointsTest >> testIsEmpty [
	| c |
	c := SEntryPoints new.
	self assert: c isEmpty.
	c addEntryPoint: 2 forBreedNo: 1.
	self deny: c isEmpty.
]

{ #category : #test }
SEntryPointsTest >> testPrintOn [
	| p w |
	p := SEntryPoints new.
	p addEntryPoint: 5 forBreedNo: 1.
	p addEntryPoint: 6 forBreedNo: 2.
	p addEntryPoint: 7 forBreedNo: 3.
	p addEntryPoint: 8 forBreedNo: 1.
	p addEntryPoint: 9 forBreedNo: 3.
	w := WriteStream on: String new.
	p printOn: w.
	self assert: w contents equals: '(1->(5 8) 2->(6) 3->(7 9))'
]

{ #category : #'tests-private' }
SEntryPointsTest >> testPrivBreeds [
	| c |
	c := SEntryPoints new.
	self assert: c privBreeds isDictionary.
	self assert: c privBreeds isEmpty.
]
