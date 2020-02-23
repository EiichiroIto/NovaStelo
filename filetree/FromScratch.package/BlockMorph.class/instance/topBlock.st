block enumerating
topBlock
	"Answer the top Block of this stack. The top block may be a HatBlockMorph, a CommandBlockMorph, or perhaps some other kind of BlockMorph."

	| m |
	m := self.
	[ m owner notNil and: [ m owner isBlockMorph ] ]
		whileTrue: [ m := m owner ].
	^ m