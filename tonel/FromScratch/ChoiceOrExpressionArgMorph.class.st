"
Argument placeholder that can either allow selection from a menu or be replaced with a numeric reporter block.

"
Class {
	#name : #ChoiceOrExpressionArgMorph,
	#superclass : #ChoiceArgMorph,
	#category : #'FromScratch-Blocks'
}

{ #category : #queries }
ChoiceOrExpressionArgMorph >> acceptsDroppedReporters [

	^ true

]

{ #category : #queries }
ChoiceOrExpressionArgMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not  "must be a number"

]
