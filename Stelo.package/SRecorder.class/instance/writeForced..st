accessing
writeForced: aBoolean
	self isOpen
		ifFalse: [ ^ self ].
	count := count + 1.
	(aBoolean or: [ count >= rate ])
		ifFalse: [ ^ self ].
	writer nextPutFrame: self makeForm.
	count := 0.