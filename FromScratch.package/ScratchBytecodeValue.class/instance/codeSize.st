accessing
codeSize
	data = false
		ifTrue: [ ^ 1 ].
	data = true
		ifTrue: [ ^ 1 ].
	data = 0
		ifTrue: [ ^ 1 ].
	data = 1
		ifTrue: [ ^ 1 ].
	(data isInteger and: [ data between: -32768 and: 32767 ])
		ifTrue: [ ^ 3 ].
	^ 5