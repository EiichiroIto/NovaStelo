private
blockAttachPoints: aSet
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping command block could be attached."

	| nextB result |
	result := #().
	self isHatBlock
		ifFalse: [ result := result copyWith: self topLeft -> self ].
	nextB := self nextBlock.
	nextB
		ifNil: [ self isStopOrForever
				ifFalse: [ result := result copyWith: self bottomLeft -> self ] ].
	nextB ifNotNil: [ nextB blockAttachPoints: aSet ].
	aSet addAll: result