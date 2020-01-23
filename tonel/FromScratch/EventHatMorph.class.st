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
		contents: aString;
		yourself.
	self addMorphBack: s.

	"create scriptNameMorph but don't add it"
	scriptNameMorph := EventTitleMorph new eventName: aSymbol.
	self fixBlockLayout
]

{ #category : #initialization }
EventHatMorph >> forLoopEvent [
	self for: 'when loop' event: #loop
]

{ #category : #initialization }
EventHatMorph >> forSetupEvent [
	self for: 'when setup' event: #setup
]

{ #category : #initialization }
EventHatMorph >> forStartupEvent [
	self for: 'when setup' event: #startup
]

{ #category : #initialization }
EventHatMorph >> forceLayout [
	"My UpdatingStringMorph calls this when its contents change"

	self fixBlockLayout.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNotNil:[
		(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) fixLayout].

]

{ #category : #initialization }
EventHatMorph >> initialize [
	| label |
	super initialize.
	self removeAllMorphs.
	label := StringMorph
		contents: 'when I receive'
		font: ScratchTheme labelFont.
	label color: Color white.
	self addMorphBack: label.
	scriptNameMorph := EventTitleMorph new.
	self addMorphBack: scriptNameMorph
]

{ #category : #initialization }
EventHatMorph >> newLabelString [
	^ StringMorph new
		font: ScratchTheme labelFont;
		color: Color white;
		yourself
]

{ #category : #other }
EventHatMorph >> printHatNameOn: aStream [
	"Append a human-readable string for this hat block's name to the given stream."

	| evtName |
	evtName := self eventName.
	evtName = 'Scratch-StartClicked'
		ifTrue: [aStream nextPutAll: 'when green flag clicked']
		ifFalse: [aStream nextPutAll: 'when I receive "', evtName, '"'].
	aStream cr.


]
