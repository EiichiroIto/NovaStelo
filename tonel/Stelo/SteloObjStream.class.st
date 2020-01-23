Class {
	#name : #SteloObjStream,
	#superclass : #ObjStream,
	#category : #'Stelo-Project'
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
		(113		ObserverScript)
		(114		PatchesScript)
		(115		TurtlesScript)
		(116 	SBreed)
		(117 	SObserver)
		(118		SPatches)
		(119 	STurtles)
		(120 	SBreedVarDef)
		(121 	SObserverVarDef)
		(122 	SPatchVarDef)
		(123 	STurtleVarDef)
		(124 	SDisplay)
		(125 	SBreedId)
	)
]
