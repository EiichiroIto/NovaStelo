private
diffuse: anArray percent: aNumber
	| src dst data use distributes n uses |
	n := neighbor copyFrom: 1 to: neighborSize.
	uses := anArray copy.
	uses /= 100.0.
	uses *= aNumber.
	src := self indexOfNormalX: 0 y: 0.
	dst := self indexOfExtendedX: 0 y: 0.
	order
		timesRepeat: [ order
				timesRepeat: [ data := anArray at: src.
					use := uses at: src.
					distributes := use / neighborSize.
					extented at: dst incrementBy: data - use.
					n
						do: [ :each | extented at: each + dst incrementBy: distributes ].
					src := src + 1.
					dst := dst + 1 ].
			dst := dst + 2 ]