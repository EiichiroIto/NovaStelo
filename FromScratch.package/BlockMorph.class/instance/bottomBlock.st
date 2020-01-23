block enumerating
bottomBlock
	"Answer the bottom Block of this stack. The top block may be a CommandBlockMorph, or perhaps some other kind of BlockMorph."

	| m obj |
	m := self.
	[ obj := m nextBlock.
	obj ifNil: [ ^ m ].
	obj isBlockMorph ] whileTrue: [ m := m nextBlock ].
	^ m