*FromScratch
displayExtentChanged
	self model ifNil: [ ^ self ].
	(self model application respondsTo: #displayExtentChanged)
		ifFalse: [ ^ self ].
	self model application displayExtentChanged