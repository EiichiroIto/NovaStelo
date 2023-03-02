Class {
	#name : #SteloObjStream,
	#superclass : #ObjStream,
	#category : #'Stelo-Converter'
}

{ #category : #'class initialization' }
SteloObjStream class >> initialize [
	"SteloObjStream initialize"
	self setupVariables
]

{ #category : #'class initialization' }
SteloObjStream class >> userClasses [
	^ super userClasses, #(
		"id		class"
		(111 	SteloProject)
		(112 	SteloScript)
		(113	ObserverScript)
		(114	PatchesScript)
		(115	TurtlesScript)
		(116 	SteloBreed)
		(117 	SObserver)
		(118	SPatches)
		(119 	STurtles)
		"(120 	SteloVarDef)"
		(121 	SObserverVarDef)
		(122 	SPatchesVarDef)
		(123 	STurtlesVarDef)
		(124 	SDisplay)
		(125 	SBreedId)
		(130 	EventId)
		(131	Variables)
		(132	VarDef)
		(133 	LazyArray)
		(134 	StringArray)
	)
]
