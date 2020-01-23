private
diffuse: anArray percent: aNumber
	| src dst data use distributes n |
	n := neighbor copyFrom: 1 to: neighborSize.
	0 to: order - 1 do: [ :y | 
		src := self indexOfNormalX: 0 y: y.
		dst := self indexOfExtendedX: 0 y: y.
		order
			timesRepeat: [ data := anArray at: src.
				use := data / 100.0 * aNumber.
				distributes := use / neighborSize.
				extented at: dst incrementBy: data - use.
				n do: [ :each | extented at: each + dst incrementBy: distributes ].
				src := src + 1.
				dst := dst + 1 ] ]