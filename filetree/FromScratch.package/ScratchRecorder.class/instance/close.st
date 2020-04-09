accessing
close
	self isOpen
		ifFalse: [ ^ self ].
	writer close.
	writer := nil