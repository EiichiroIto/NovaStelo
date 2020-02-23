block enumerating
blockSequence
	"Answer the sequence of blocks starting with myself. Each block is a submorph of the previous block."

	| stream this |
	stream := WriteStream on: Array new.
	this := self.
	[ this isNil ]
		whileFalse: [ stream nextPut: this.
			this := this nextBlock ].
	^ stream contents