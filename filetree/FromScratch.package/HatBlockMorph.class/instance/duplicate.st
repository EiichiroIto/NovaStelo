event handling
duplicate
	"Overridden to pick an unused script name for the duplicate."

	| m |
	m := self fullCopy.
	scriptOwner ifNotNil: [m scriptOwner: scriptOwner].
	self world activeHand attachMorph: m.
