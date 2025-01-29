Class {
	#name : 'SubHatMorph',
	#superclass : 'HatBlockMorph',
	#instVars : [
		'subName'
	],
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'converting' }
SubHatMorph >> asBlockTuple [

	^ Array with: selector with: subName
]

{ #category : 'code generation' }
SubHatMorph >> emitCode: aGenerator indent: indent [

	aGenerator emitSubHatBlock: self indent: indent
]

{ #category : 'initialization' }
SubHatMorph >> initialize [

	super initialize.
	subName := ''
]

{ #category : 'testing' }
SubHatMorph >> isSubHatMorph [

	^ true
]

{ #category : 'processes' }
SubHatMorph >> startProcess [

	| proc |
	self receiver ifNil: [ ^ self ].
	proc := self applicationDo: [ :app | app startProcessFor: self ].
	self changed.
	^ proc
]

{ #category : 'accessing' }
SubHatMorph >> subName [

	^ subName
]

{ #category : 'accessing' }
SubHatMorph >> subName: aString [

	subName := aString.
	scriptNameMorph contents: 'Sub ' , aString.
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]
]

{ #category : 'accessing' }
SubHatMorph >> varNames [

	^ self receiver varNames
]
