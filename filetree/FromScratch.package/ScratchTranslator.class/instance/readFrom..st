accessing
readFrom: aStream
	| line key value |
	key := value := ''.
	[ aStream atEnd ]
		whileFalse: [ line := aStream nextLine.
			(line beginsWith: 'msgid')
				ifTrue: [ key := line copyFrom: 7 to: line size ].
			(line beginsWith: 'msgstr')
				ifTrue: [ value := line copyFrom: 8 to: line size.
					self addMsgId: key msgStr: value.
					key := '' ] ]