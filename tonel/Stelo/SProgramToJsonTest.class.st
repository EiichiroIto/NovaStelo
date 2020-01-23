Class {
	#name : #SProgramToJsonTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #test }
SProgramToJsonTest >> testAddListEventNoBreedNo [
	| j d |
	j := SProgramToJson new.
	j addList: #(1 2 3) eventNo: 2 breedNo: 5.
	j addList: #(4 5 6) eventNo: 2 breedNo: 3.
	j addList: #(1) eventNo: 1 breedNo: 5.
	j addList: #(5 6) eventNo: 3 breedNo: 3.
	d := j breeds.
	self assert: d size equals: 2.
	self assert: (d at: 3) class equals: Dictionary.
	self assertCollection: ((d at: 3) at: 2) equals: #(4 5 6).
	self assertCollection: ((d at: 3) at: 3) equals: #(5 6).
	self assert: (d at: 5) class equals: Dictionary.
	self assertCollection: ((d at: 5) at: 2) equals: #(1 2 3).
	self assertCollection: ((d at: 5) at: 1) equals: #(1).
	self should: [ j addCode: #(7 8) eventNo: 2 breedNo: 3 ] raise: Error.
]

{ #category : #test }
SProgramToJsonTest >> testBreeds [
	| j |
	j := SProgramToJson new.
	self assert: j breeds class equals: Dictionary.
]

{ #category : #test }
SProgramToJsonTest >> testConvert [
	| pr j list |
	pr := SProgram new.
	pr addEntryPoint: 5 eventNo: EventId loopEventNo breedNo: 3.
	pr addEntryPoint: 10 eventNo: EventId loopEventNo breedNo: 1.
	j := SProgramToJson new.
	j convert: pr.
	self assert: j breeds size equals: 2.
	self assert: (j breeds at: 3) class equals: Dictionary.
	list := (j breeds at: 3) at: EventId loopEventNo.
	self assertCollection: list asArray equals: #(5).
	self assert: (j breeds at: 1) class equals: Dictionary.
	list := (j breeds at: 1) at: EventId loopEventNo.
	self assertCollection: list asArray equals: #(10).
]

{ #category : #test }
SProgramToJsonTest >> testConvertEventNo [
	| e j d |
	e := SEntryPoints new.
	e addEntryPoint: 1 forBreedNo: 5.
	e addEntryPoint: 2 forBreedNo: 5.
	e addEntryPoint: 9 forBreedNo: 3.
	j := SProgramToJson new.
	j convert: e eventNo: 2.
	d := j breeds.
	self assert: d size equals: 2.
	self assert: (d at: 3) class equals: Dictionary.
	self assertCollection: ((d at: 3) at: 2) asArray equals: #(9).
	self assert: (d at: 5) class equals: Dictionary.
	self assertCollection: ((d at: 5) at: 2) asArray equals: #(1 2).
]

{ #category : #test }
SProgramToJsonTest >> testFromProgram [
	| p j ret |
	p := SProgram new.
	p addCode: #(1 2 3 4 5 6 7 8 9).
	p addEntryPoint: 10 eventNo: 1 breedNo: 1.
	p addEntryPoint: 12 eventNo: 1 breedNo: 2.
	p addEntryPoint: 14 eventNo: 1 breedNo: 2.
	p addEntryPoint: 16 eventNo: 2 breedNo: 1.
	j := SProgramToJson new.
	ret := j fromProgram: p.
	self assert: ret equals: '{"breeds":[{"breed":1,"entries":[{"event":1,"address":10},{"event":2,"address":16}]},{"breed":2,"entries":[{"event":1,"address":12},{"event":1,"address":14}]}],"codes":[1,2,3,4,5,6,7,8,9]}'
]

{ #category : #test }
SProgramToJsonTest >> testGenerateBreeds [
	| d d1 d2 j |
	d := Dictionary new.
	d1 := Dictionary new.
	d1 at: 5 put: #(2).
	d2 := Dictionary new.	
	d2 at: 1 put: #(4 5).
	d at: 3 put: d1.
	d at: 2 put: d2.
	j := SProgramToJson new.
	j generateBreeds: d.
	self assert: j stream contents equals: '"breeds":[{"breed":2,"entries":[{"event":1,"address":4},{"event":1,"address":5}]},{"breed":3,"entries":[{"event":5,"address":2}]}]'
]

{ #category : #test }
SProgramToJsonTest >> testGenerateCodes [
	| j |
	j := SProgramToJson new.
	j generateCodes: #().
	self assert: j stream contents equals: '"codes":[]'.
	j := SProgramToJson new.
	j generateCodes: #(1).
	self assert: j stream contents equals: '"codes":[1]'.
	j := SProgramToJson new.
	j generateCodes: #(1 2).
	self assert: j stream contents equals: '"codes":[1,2]'.
	j := SProgramToJson new.
	j generateCodes: #(1 2 3 4).
	self assert: j stream contents equals: '"codes":[1,2,3,4]'.
]

{ #category : #test }
SProgramToJsonTest >> testGenerateEntries [
	| d j |
	d := Dictionary new.
	d at: 5 put: #(1).
	d at: 1 put: #(2 3).
	j := SProgramToJson new.
	j generateEntries: d.
	self assert: j stream contents equals: ',"entries":[{"event":1,"address":2},{"event":1,"address":3},{"event":5,"address":1}]'.
]

{ #category : #test }
SProgramToJsonTest >> testGenerateEntryEventNo [
	| j |
	j := SProgramToJson new.
	j generateEntry: #() eventNo: 5.
	self assert: j stream contents equals: ''.
	j := SProgramToJson new.
	j generateEntry: #(1) eventNo: 5.
	self assert: j stream contents equals: '{"event":5,"address":1}'.
	j := SProgramToJson new.
	j generateEntry: #(3 4) eventNo: 1.
	self
		assert: j stream contents
		equals: '{"event":1,"address":3},{"event":1,"address":4}'.
	j := SProgramToJson new.
	j generateEntry: #(5 6 7) eventNo: 3.
	self
		assert: j stream contents
		equals:
			'{"event":3,"address":5},{"event":3,"address":6},{"event":3,"address":7}'
]

{ #category : #test }
SProgramToJsonTest >> testInitialize [
	self testBreeds.
	self testStream.
]

{ #category : #test }
SProgramToJsonTest >> testStream [
	| j |
	j := SProgramToJson new.
	self assert: j stream class equals: WriteStream.
]
