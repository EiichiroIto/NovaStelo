Class {
	#name : 'LocalVarBlockMorph',
	#superclass : 'VariableBlockMorph',
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'code generation' }
LocalVarBlockMorph >> argString: aGenerator [
	^ aGenerator localVarArgString: self
]

{ #category : 'private' }
LocalVarBlockMorph >> asBlockTuple [
	"Answer a tuple (Array) describing this block and its arguments."

	^ Array with: #localVar with: commandSpec
]

{ #category : 'watcher' }
LocalVarBlockMorph >> canBecomeWatcher [
	^ false
]

{ #category : 'evaluation' }
LocalVarBlockMorph >> evaluateWithArgs: args [
	^ self topBlock scratchProc localVarAt: commandSpec
]
