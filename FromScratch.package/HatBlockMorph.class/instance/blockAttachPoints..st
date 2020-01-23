private
blockAttachPoints: aSet
	"Answer a collection of possible attachment points for me. Each entry is an Association mapping a point to the morph to which a dropping block could be attached."

	| nextB |
	nextB := self nextBlock.
	nextB
		ifNil: [ aSet add: self bottomLeft -> self ]
		ifNotNil: [ nextB blockAttachPoints: aSet ]