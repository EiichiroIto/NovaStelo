private
blockAttachPoints: aSet
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping command block could be attached."

	| result |
	result := #().
	self = self topBlock
		ifTrue: [ result := result copyWith: self topLeft -> self ].
	(self isKindOf: HatBlockMorph)
		ifFalse: [ result := result copyWith: self topLeft -> self ].
	trueBlock
		ifNil: [ result := result
				copyWith: self topLeft + (12 @ (self topBarHeight + 7)) -> self ]
		ifNotNil: [ trueBlock blockAttachPoints: aSet ].
	falseBlock
		ifNil: [ result := result
				copyWith: self topLeft + (12 @ (elseBarY + self elseBarHeight + 9)) -> self ]
		ifNotNil: [ falseBlock blockAttachPoints: aSet ].
	nextBlock
		ifNil: [ result := result copyWith: self bottomLeft -> self ]
		ifNotNil: [ nextBlock blockAttachPoints: aSet ].
	aSet addAll: result