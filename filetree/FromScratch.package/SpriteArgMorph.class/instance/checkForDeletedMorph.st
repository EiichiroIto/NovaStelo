other
checkForDeletedMorph
	"If I refer to a Sprite that has been deleted, nil out my morph field. Do nothing if my morph is a SteloStageMorph"

	(morph isKindOf: Morph) ifFalse: [^ self].
	morph owner ifNotNil: [^ self].

	(morph isStageMorph) ifTrue: [^ self].

	morph := nil.  "nil out reference to deleted sprite"

