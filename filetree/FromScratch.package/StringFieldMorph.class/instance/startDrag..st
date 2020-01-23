event handling
startDrag: evt
	"Do nothing if have keyboard focus. Otherwise, allow myself to be grabbed."

	| myBlock |
	isKeyboardFocus ifFalse: [
		myBlock := self meOrOwnerThatIsA: BlockMorph.
		myBlock
			ifNil: [super startDrag: evt]
			ifNotNil: [myBlock startDrag: evt]].
