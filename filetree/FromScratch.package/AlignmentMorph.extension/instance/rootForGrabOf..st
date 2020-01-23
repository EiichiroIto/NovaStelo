*FromScratch
rootForGrabOf: aMorph

	| root |
	self dragNDropEnabled ifFalse: [^ super rootForGrabOf: aMorph].
	root := aMorph.
	[root == self] whileFalse:
		[root owner = self ifTrue: [^ root].
		root := root owner].
	^ super rootForGrabOf: aMorph