private
unquoteString: aString
	| tmp |
	tmp := aString trimBoth.
	tmp ifEmpty: [ ^ tmp ].
	tmp first = $"
		ifTrue: [ tmp := tmp allButFirst ].
	tmp ifEmpty: [ ^ tmp ].
	tmp last = $"
		ifTrue: [ tmp := tmp allButLast ].
	^ tmp