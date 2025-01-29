Class {
	#name : 'StartHatMorph',
	#superclass : 'HatBlockMorph',
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'other' }
StartHatMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its event name."

	^ Array with: selector
]

{ #category : 'initialization' }
StartHatMorph >> commandSpec [

	^ scriptNameMorph contents asString
]

{ #category : 'initialization' }
StartHatMorph >> commandSpec: aString [

	scriptNameMorph contents: aString.
	self fixBlockLayout
]

{ #category : 'code generation' }
StartHatMorph >> emitCode: aGenerator indent: indent [

	aGenerator emitStartHatBlock: self indent: indent
]
