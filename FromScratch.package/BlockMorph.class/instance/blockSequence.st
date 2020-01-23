block enumerating
blockSequence
	"Answer the sequence of blocks starting with myself. Each block is a submorph of the previous block."

	| result this |
	result := OrderedCollection new: 20.
	this := self.
	[this isNil] whileFalse: [
		result addLast: this.
		this := this nextBlock].
	^ result asArray
