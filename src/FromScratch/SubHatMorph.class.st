Class {
	#name : #SubHatMorph,
	#superclass : #HatBlockMorph,
	#instVars : [
		'subName'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #converting }
SubHatMorph >> asBlockTuple [
	^ Array with: self class name with: self subName
]

{ #category : #'code generation' }
SubHatMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitSubHatBlock: self indent: indent.
]

{ #category : #'object i/o' }
SubHatMorph >> fieldsVersion [
	^ 1
]

{ #category : #private }
SubHatMorph >> forceLayout [
	self fixBlockLayout.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph)
		ifNotNil: [ :morph | morph fixLayout ]
]

{ #category : #'object i/o' }
SubHatMorph >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		subName
	) from: anObjStream
]

{ #category : #initialization }
SubHatMorph >> initialize [
	super initialize.
	subName := ''.
]

{ #category : #'object i/o' }
SubHatMorph >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		subName
	) on: anObjStream
]

{ #category : #accessing }
SubHatMorph >> subName [
	^ subName
]

{ #category : #accessing }
SubHatMorph >> subName: aString [
	subName := aString.
	scriptNameMorph contents: ('Sub ', aString).
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]
]
