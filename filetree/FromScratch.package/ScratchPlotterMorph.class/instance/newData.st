private
newData
	last := Array new: pens size.
	(maxSize notNil and: [ data size >= maxSize ])
		ifTrue: [ data removeFirst: data size - maxSize + 1 ].
	data add: last.
	^ last