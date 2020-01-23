accessing
putOn: aStream
	data = false
		ifTrue: [ ^ aStream nextPut: #push0 ].
	data = true
		ifTrue: [ ^ aStream nextPut: #push1 ].
	data = 0
		ifTrue: [ ^ aStream nextPut: #push0 ].
	data = 1
		ifTrue: [ ^ aStream nextPut: #push1 ].
	(data isInteger and: [ data between: -32768 and: 32767 ])
		ifTrue: [ ^ self putShortOn: aStream ].
	self putFloatOn: aStream