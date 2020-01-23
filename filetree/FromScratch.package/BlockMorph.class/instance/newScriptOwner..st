accessing
newScriptOwner: newOwner
	"Update the receiver of all blocks to be the given morph. Used when moving scripts from one object to another."

	| rcvr |
	self allMorphsDo: [:m |
		(m isKindOf: BlockMorph) ifTrue: [
			rcvr := newOwner.
			((m isKindOf: VariableBlockMorph) | (m isKindOf: SetterBlockMorph)) ifTrue: [
				(m receiver isStageMorph) ifTrue: [rcvr := m receiver].
				newOwner ensureVariableExists: m variable asString.  "ensure that variable exists"
				m color: rcvr variableBlockColor].
			m receiver: rcvr].
		"(m isKindOf: CommandBlockMorph) ifTrue: [
			m argMorphs do: [:arg |
				((arg isKindOf: ChoiceArgMorph) and:
				 [arg getOptionsSelector = #listVarMenu]) ifTrue: [
					arg choice ifNotNil: [newOwner ensureListExists: arg choice]]]]."
		"(m isKindOf: ListContentsBlockMorph) ifTrue: [
			newOwner ensureListExists: m commandSpec]."
		(m isKindOf: HatBlockMorph) ifTrue: [m scriptOwner: newOwner]].
