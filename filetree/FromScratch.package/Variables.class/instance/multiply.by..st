accessing
multiply: vno by: aNumber
	vno = 0
		ifTrue: [ ^ self ].
	^ (self varAt: vno) multiplyBy: aNumber