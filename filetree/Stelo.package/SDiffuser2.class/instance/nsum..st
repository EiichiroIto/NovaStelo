private
nsum: anArray
	| src dst n sum |
	n := neighbor copyFrom: 1 to: neighborSize.
	0 to: order - 1 do: [ :y | 
		src := self indexOfExtendedX: 0 y: y.
		dst := self indexOfNormalX: 0 y: y.
		order
			timesRepeat: [ sum := n sum: [ :each | extented at: src + each ].
				anArray at: dst put: sum.
				src := src + 1.
				dst := dst + 1 ] ]