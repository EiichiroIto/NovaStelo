private
mapReceiver: oldObj to: newObj
	"Used in cloning an object to make blocks that refererred to the original object new refer to the new copy."

	receiver == oldObj ifTrue: [receiver := newObj].
	argMorphs do: [:arg |
		(arg isKindOf: CommandBlockMorph) ifTrue: [
			arg mapReceiver: oldObj to: newObj]].
