*FromScratch
equals: aForm
	"Answer true if the receiver is exactly the same as the given Form."

	self == aForm ifTrue: [^ true].

	self class = aForm class ifFalse: [^ false].
	self class = ColorForm ifTrue: [
		self colors = aForm colors  ifFalse: [^ false]].
	(width = aForm width) & (height = aForm height) ifFalse: [^ false].
	(depth = aForm depth) & (offset = aForm privateOffset) ifFalse: [^ false].

	bits class = aForm bits class ifFalse: [
		self hibernate.
		aForm hibernate].
	^ bits = aForm bits