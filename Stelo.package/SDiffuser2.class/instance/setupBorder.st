private
setupBorder
	| src dst |
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: 0 y: order.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: 0 y: order - 1.
	dst := self indexOfExtendedX: 0 y: -1.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + 1.
			dst := dst + 1 ].
	src := self indexOfExtendedX: order - 1 y: 0.
	dst := self indexOfExtendedX: -1 y: 0.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + order + 2.
			dst := dst + order + 2 ].
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: order y: 0.
	order
		timesRepeat: [ extented at: dst put: (extented at: src).
			src := src + order + 2.
			dst := dst + order + 2 ].
	src := self indexOfExtendedX: 0 y: 0.
	dst := self indexOfExtendedX: order y: order.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: order - 1 y: order - 1.
	dst := self indexOfExtendedX: -1 y: -1.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: order - 1 y: 0.
	dst := self indexOfExtendedX: -1 y: order.
	extented at: dst put: (extented at: src).
	src := self indexOfExtendedX: 0 y: order - 1.
	dst := self indexOfExtendedX: order y: -1.
	extented at: dst put: (extented at: src)