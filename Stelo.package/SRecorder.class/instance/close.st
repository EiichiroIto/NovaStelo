accessing
close
	writer ifNil: [ ^ self ].
	writer close.
	writer := nil.