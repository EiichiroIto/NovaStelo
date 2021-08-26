"
I am a block for setting a variable.

"
Class {
	#name : #SetterBlockMorph,
	#superclass : #CommandBlockMorph,
	#category : #'FromScratch-Blocks'
}

{ #category : #private }
SetterBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	| result arg |
	result := Array with: #changeVariable with: self variable with: selector with: nil.

	arg := (argMorphs first isKindOf: ChoiceArgMorph)
		ifTrue: [argMorphs last]
		ifFalse: [argMorphs first].

	(arg isKindOf: ArgMorph)
		ifTrue: [result at: 4 put: arg evaluate]
		ifFalse: [result at: 4 put: arg asBlockTuple].

	^ result


]

{ #category : #accessing }
SetterBlockMorph >> expressionArg [

	submorphs do: [:m |
		(m isKindOf: ExpressionArgMorph) ifTrue: [^ m]].

	^ nil
]

{ #category : #initialization }
SetterBlockMorph >> initChangerForVar: varName [
	self commandSpec: 'change %v by %n' localized.
	argPermutation := CommandBlockMorph
		argPermutationForSpec: 'change %v to %n'
		withTranslation: commandSpec.
	self selector: #changeVar:by:.
	self variable: varName
]

{ #category : #initialization }
SetterBlockMorph >> initSetterForVar: varName [
	self commandSpec: 'set %v to %n' localized.
	argPermutation := CommandBlockMorph
		argPermutationForSpec: 'set %v to %n'
		withTranslation: commandSpec.
	self selector: #setVar:to:.
	self variable: varName
]

{ #category : #initialization }
SetterBlockMorph >> initialize [

	super initialize.
	isSpecialForm := false.
	isTimed := false.

]

{ #category : #private }
SetterBlockMorph >> labelMorphFor: aString [
	| s |
	s := aString.
	"commandSpec isUnicode ifTrue: [s := UTF8 withAll: s].
	self variable isUnicode ifTrue: [s := UTF8 withAll: s]."
	^ (StringMorph contents: s font: ScratchTranslator labelFont)
		color: self labelColor
]

{ #category : #accessing }
SetterBlockMorph >> receiver: anObject [
	"Set my receiver object and, if possible, my block color."

	receiver := anObject.
	self color: ScratchTheme variableBlockColor
]

{ #category : #accessing }
SetterBlockMorph >> variable [

	submorphs do: [:m |
		(m isKindOf: ChoiceArgMorph) ifTrue: [^ m choice]].
	^ ''


]

{ #category : #accessing }
SetterBlockMorph >> variable: aVar [

	submorphs do: [:m |
		(m isKindOf: ChoiceArgMorph) ifTrue: [^ m choice: aVar]].

]
