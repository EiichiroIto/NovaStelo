"
I am a block that reports the value of either a built-in or a user variable. When dropped into the workspace, I turn into a WatcherMorph for that variable with an optional slider.

"
Class {
	#name : 'VariableBlockMorph',
	#superclass : 'ReporterBlockMorph',
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'private' }
VariableBlockMorph >> addLabel [
	"Add a label for my command and arguments. 
	This is the method that really creates the whole block."
	"Details: This overrides the superclass method to allow 
	using percent character in variable/list names"

	commandSpec ifNil: [^ self].
	self removeAllMorphs.
	self addMorphBack: (self labelMorphFor: commandSpec).

]

{ #category : 'code generation' }
VariableBlockMorph >> argString: aGenerator [
	^ aGenerator variableArgString: self.
]

{ #category : 'accessing' }
VariableBlockMorph >> args [
	^ { self variable }
]

{ #category : 'private' }
VariableBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	^ Array with: #readVariable with: commandSpec

]

{ #category : 'watcher' }
VariableBlockMorph >> canBecomeWatcher [
	"All variable blocks can become watchers when dragged onto the stage."

	^ true
]

{ #category : 'evaluation' }
VariableBlockMorph >> evaluateWithArgs: args [
	"Overridden to read my variable value."

	^ receiver getVar: commandSpec

]

{ #category : 'initialization' }
VariableBlockMorph >> initialize [

	super initialize.
	commandSpec := ''.
	self color: (Color r: 0.4 g: 1.0 b: 0.4).

]

{ #category : 'accessing' }
VariableBlockMorph >> isReporter [

	^ true

]

{ #category : 'testing' }
VariableBlockMorph >> isVariableBlock [
	"do not delete"
	^ true
]

{ #category : 'accessing' }
VariableBlockMorph >> numberArgFlags [
	^ #(false)
]

{ #category : 'accessing' }
VariableBlockMorph >> receiver: anObject [
	"Set my receiver object and, if possible, my block color."

	receiver := anObject.
	self color: ScratchTheme variableBlockColor darker
]

{ #category : 'accessing' }
VariableBlockMorph >> selector [
	^ #getVar:
]

{ #category : 'accessing' }
VariableBlockMorph >> variable [

	^ commandSpec

]
