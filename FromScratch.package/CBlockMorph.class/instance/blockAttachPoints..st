private
blockAttachPoints: aSet
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping command block could be attached."

	| result |
	result := #().
	self isHatBlock
		ifFalse: [ result := result copyWith: self topLeft -> self ].
	nestedBlock
		ifNil: [ result := result
				copyWith: self topLeft + (12 @ (self topBarHeight + 7)) -> self ]
		ifNotNil: [ nestedBlock blockAttachPoints: aSet ].
	nextBlock
		ifNil: [ self isStopOrForever
				ifFalse: [ result := result copyWith: self bottomLeft -> self ] ]
		ifNotNil: [ nextBlock blockAttachPoints: aSet ].
	aSet addAll: result