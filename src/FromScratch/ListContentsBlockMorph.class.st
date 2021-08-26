"
Reporter for the contents of a list.

"
Class {
	#name : #ListContentsBlockMorph,
	#superclass : #ReporterBlockMorph,
	#category : #'FromScratch-Blocks'
}

{ #category : #all }
ListContentsBlockMorph >> addLabel [
	"Add a label for my command and arguments. 
	This is the method that really creates the whole block."
	"Details: This overrides the superclass method to allow 
	using percent character in variable/list names"

	commandSpec ifNil: [^ self].
	self removeAllMorphs.
	self addMorphBack: (self labelMorphFor: commandSpec).

]

{ #category : #all }
ListContentsBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	^ Array with: #contentsOfList: with: commandSpec

]

{ #category : #all }
ListContentsBlockMorph >> evaluateWithArgs: ignored [

	^ receiver contentsOfList: commandSpec

]
