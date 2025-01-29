"
I am a hat block for stacks triggered by Scratch events.

"
Class {
	#name : 'EventHatMorph',
	#superclass : 'HatBlockMorph',
	#instVars : [
		'labelMorph'
	],
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'accessing' }
EventHatMorph >> asBlockTuple [

	"Answer a tuple (Array) describing this block and its event name."

	^ Array with: selector with: self eventName
]

{ #category : 'initialization' }
EventHatMorph >> commandSpec [

	^ labelMorph contents asString
]

{ #category : 'initialization' }
EventHatMorph >> commandSpec: aString [

	labelMorph contents: aString.
	self fixBlockLayout
]

{ #category : 'accessing' }
EventHatMorph >> defaultArgs: defaultValues [

	self eventName: defaultValues first
]

{ #category : 'code generation' }
EventHatMorph >> emitCode: aGenerator indent: indent [

	aGenerator emitEventHatBlock: self indent: indent
]

{ #category : 'accessing' }
EventHatMorph >> eventName [

	^ scriptNameMorph eventName
]

{ #category : 'accessing' }
EventHatMorph >> eventName: aString [

	scriptNameMorph eventName: aString.
	self fixBlockLayout.
	self applicationDo: [ :app | app updateContents ]
]

{ #category : 'initialization' }
EventHatMorph >> initialize [

	super initialize.
	self removeAllMorphs.
	labelMorph := StringMorph
		              contents: 'when I receive'
		              font: ScratchTranslator labelFont.
	labelMorph color: Color white.
	self addMorphBack: labelMorph.
	scriptNameMorph := EventTitleMorph new.
	self addMorphBack: scriptNameMorph
]

{ #category : 'initialization' }
EventHatMorph >> newLabelString [

	^ StringMorph new
		  font: ScratchTranslator labelFont;
		  color: Color white;
		  yourself
]
