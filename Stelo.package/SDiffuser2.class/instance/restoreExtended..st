private
restoreExtended: anArray
	| src dst |
	0 to: order - 1 do: [ :y | 
		src := self indexOfExtendedX: 0 y: y.
		dst := self indexOfNormalX: 0 y: y.
		order
			timesRepeat: [ anArray at: dst put: (extented at: src).
				src := src + 1.
				dst := dst + 1 ] ].
	src := self indexOfExtendedX: 0 y: -1.
	dst := self indexOfNormalX: 0 y: order - 1.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: 0 y: order.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: -1 y: 0.
	dst := self indexOfNormalX: order - 1 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + order + 2.
			dst := dst + order ].
	src := self indexOfExtendedX: order y: 0.
	dst := self indexOfNormalX: 0 y: 0.
	order
		timesRepeat: [ anArray at: dst incrementBy: (extented at: src).
			src := src + order + 2.
			dst := dst + order ].
	src := self indexOfExtendedX: order y: order.
	dst := self indexOfNormalX: 0 y: 0.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: -1 y: -1.
	dst := self indexOfNormalX: order - 1 y: order - 1.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: -1 y: order.
	dst := self indexOfNormalX: order - 1 y: 0.
	anArray at: dst incrementBy: (extented at: src).
	src := self indexOfExtendedX: order y: -1.
	dst := self indexOfNormalX: 0 y: order - 1.
	anArray at: dst incrementBy: (extented at: src)