private
nsum: anArray
	| src dst n sum |
	n := neighbor copyFrom: 1 to: neighborSize.
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ order
				timesRepeat: [ sum := n sum: [ :each | extented at: src + each ].
					anArray at: dst put: sum.
					src := src + 1.
					dst := dst + 1 ].
			src := src + 2 ]