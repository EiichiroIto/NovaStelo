private
setupIndexes
	| dict left right index inner tleft tright bleft bright top bottom |
	dict := Dictionary new.
	tleft := 1.
	tright := rows.
	top := (1 to: rows) asArray.
	left := OrderedCollection new.
	inner := OrderedCollection new.
	right := OrderedCollection new.
	index := rows.
	left add: 1.
	right add: rows.
	cols - 2
		timesRepeat: [ left add: index + 1.
			inner addAll: (index + 2 to: index + rows - 1).
			right add: index + rows.
			index := index + rows ].
	left add: index + 1.
	right add: index + rows.
	bleft := index + 1.
	bottom := (index + 1 to: index + rows) asArray.
	bright := index + rows.
	dict at: #inner put: inner asArray.
	dict at: #top put: bottom , top , (top collect: [ :each | each + rows ]).
	dict at: #bottom put: (bottom collect: [ :each | each - rows ]) , bottom , top.
	dict at: #left put: (right , left , (left collect: [ :each | each + 1 ])) asArray.
	dict at: #right put: ((right collect: [ :each | each - 1 ]) , right , left) asArray.
	dict
		at: #topLeft
		put:
			{bright.
			bleft.
			(bleft + 1).
			tright.
			tleft.
			(tleft + 1).
			tright + rows.
			rows + 1.
			(rows + 2).}.
	dict
		at: #topRight
		put:
			{(bright - 1).
			bright.
			bleft.
			(tright - 1).
			tright.
			tleft.
			(tright + rows - 1).
			(tright + rows).
			(tleft + rows).}.
	dict
		at: #bottomLeft
		put:
			{(bright - rows).
			(bleft - rows).
			(bleft - rows + 1).
			bright.
			bleft.
			(bleft + 1).
			tright.
			tleft.
			(tleft + 1).}.
	dict
		at: #bottomRight
		put:
			{(bright - rows - 1).
			(bright - rows).
			(bleft - rows).
			(bright - 1).
			bright.
			bleft.
			(tright - 1).
			tright.
			tleft.}.
	indexesDict := dict.