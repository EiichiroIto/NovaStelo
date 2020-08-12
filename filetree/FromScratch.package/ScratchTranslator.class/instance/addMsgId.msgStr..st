private
addMsgId: aString1 msgStr: aString2
	| key value |
	key := self unquoteString: aString1.
	key isEmpty
		ifTrue: [ ^ self ].
	value := self unquoteString: aString2.
	self textAt: key put: value