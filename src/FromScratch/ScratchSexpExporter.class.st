Class {
	#name : 'ScratchSexpExporter',
	#superclass : 'ScratchExporter',
	#instVars : [
		'appName'
	],
	#category : 'FromScratch-Converter',
	#package : 'FromScratch',
	#tag : 'Converter'
}

{ #category : 'instance creation' }
ScratchSexpExporter class >> appName: aString [
	^ self basicNew
		initialize;
		appName: aString;
		yourself
]

{ #category : 'instance creation' }
ScratchSexpExporter class >> new [
	self shouldNotImplement
]

{ #category : 'accessing' }
ScratchSexpExporter >> appName [
	^ appName
]

{ #category : 'accessing' }
ScratchSexpExporter >> appName: anObject [
	appName := anObject
]

{ #category : 'private' }
ScratchSexpExporter >> writeFooter: aProject [
	stream nextPutAll: '))'.
]

{ #category : 'private' }
ScratchSexpExporter >> writeHeader: aProject [
	stream
		nextPut: $(;
		nextPutAll: appName;
		nextPut: Character space.
	self writeScriptNames: aProject.
	stream
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: $(
]

{ #category : 'private' }
ScratchSexpExporter >> writeIndent [
	stream
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: Character space;
		nextPut: Character space
]

{ #category : 'private' }
ScratchSexpExporter >> writeScript: aScript [

	| code |
	stream
		nextPutAll: '(for ';
		nextPutAll: aScript objName;
		nextPut: Character space;
		nextPut: $(.
	self writeVarNames: aScript.
	stream nextPut: $).
	self writeIndent.
	stream nextPut: $(.
	aScript allHatBlocks
		do: [ :each | 
			code := ScratchSexpGenerator new parseBlock: each initialIndent: 3.
			stream nextPutAll: code ]
		separatedBy: [ self writeIndent ].
	stream nextPutAll: '))'
]

{ #category : 'private' }
ScratchSexpExporter >> writeScriptNames: aProject [
	stream nextPut: $(.
	aProject scripts
		do: [ :each | stream nextPutAll: each objName ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: $)
]

{ #category : 'private' }
ScratchSexpExporter >> writeScriptSeparator [
	stream
		nextPut: Character lf;
		nextPut: Character space;
		nextPut: Character space
]

{ #category : 'private' }
ScratchSexpExporter >> writeVarNames: aScript [
	aScript varNames
		do: [ :each | 
			stream
				nextPutAll: '(var ';
				nextPutAll: (SexpLexer quotedString: each);
				nextPutAll: ')' ]
		separatedBy: [ stream nextPut: Character space ].
	stream nextPut: Character space.
	aScript listVarNames
		do: [ :each | 
			stream
				nextPutAll: '(list ';
				nextPutAll: (SexpLexer quotedString: each);
				nextPutAll: ')' ]
		separatedBy: [ stream nextPut: Character space ]
]
