"
I am a hat block for stacks triggered by Scratch events.

"
Class {
	#name : #EventHatMorph,
	#superclass : #HatBlockMorph,
	#category : #'FromScratch-Blocks'
}

{ #category : #other }
EventHatMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its event name."

	^ Array with: self class name with: self eventName

]

{ #category : #'code generation' }
EventHatMorph >> emitCode: aGenerator indent: indent [
	aGenerator emitEventHatBlock: self indent: indent.
]

{ #category : #other }
EventHatMorph >> eventName [
	"Answer the name of this script."

	^ scriptNameMorph eventName

]

{ #category : #other }
EventHatMorph >> eventName: aString [
	"Set my event name. Used for initialization."

	scriptNameMorph eventName: aString.
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]
]

{ #category : #initialization }
EventHatMorph >> for: aString event: aSymbol [
	| s |
	super initialize.
	self removeAllMorphs.
	s := self newLabelString
		contents: aString localized;
		yourself.
	self addMorphBack: s.

	"create scriptNameMorph but don't add it"
	scriptNameMorph := EventTitleMorph new eventName: aSymbol.
	self fixBlockLayout
]

{ #category : #initialization }
EventHatMorph >> initialize [
	| label |
	super initialize.
	self removeAllMorphs.
	label := StringMorph
		contents: 'when I receive' localized
		font: ScratchTranslator labelFont.
	label color: Color white.
	self addMorphBack: label.
	scriptNameMorph := EventTitleMorph new.
	self addMorphBack: scriptNameMorph
]

{ #category : #initialization }
EventHatMorph >> newLabelString [
	^ StringMorph new
		font: ScratchTranslator labelFont;
		color: Color white;
		yourself
]
