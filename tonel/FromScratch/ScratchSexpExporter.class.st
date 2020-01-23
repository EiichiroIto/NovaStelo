Class {
	#name : #ScratchSexpExporter,
	#superclass : #ScratchExporter,
	#instVars : [
		'appName'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #'instance creation' }
ScratchSexpExporter class >> appName: aString [
	^ self basicNew
		initialize;
		appName: aString;
		yourself
]

{ #category : #'instance creation' }
ScratchSexpExporter class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
ScratchSexpExporter >> appName [
	^ appName
]

{ #category : #accessing }
ScratchSexpExporter >> appName: anObject [
	appName := anObject
]

{ #category : #private }
ScratchSexpExporter >> writeFooter: aProject [
	stream nextPutAll: '))'.
]

{ #category : #private }
ScratchSexpExporter >> writeHeader: aProject [
	stream
		nextPut: $(;
		nextPutAll: appName;
		nextPutAll: ' ('.
	aProject scripts
		do: [ :each | stream nextPutAll: each objName ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: $).
	stream nextPut: Character lf.
	stream nextPut: $(
]

{ #category : #private }
ScratchSexpExporter >> writeScript: aScript [
	| code |
	stream
		nextPutAll: '(for ';
		nextPutAll: aScript objName;
		nextPut: Character space;
		nextPut: $(.
	aScript varNames
		do: [ :each | stream nextPutAll: (SexpLexer quotedString: each) ]
		separatedBy: [ stream nextPut: Character space ].
	stream
		nextPut: $);
		nextPut: Character lf;
		nextPut: $(.
	aScript subBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each target: aScript.
			stream nextPutAll: code ].
	aScript eventBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parse: each target: aScript.
			stream nextPutAll: code ].
	stream
		nextPutAll: '))';
		nextPut: Character lf
]
