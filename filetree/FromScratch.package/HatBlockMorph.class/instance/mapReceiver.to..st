private
mapReceiver: oldObj to: newObj
	"Used in cloning or importing to make blocks that refererred to the original object new refer to the new copy."

	scriptOwner == oldObj ifTrue: [scriptOwner := newObj].
