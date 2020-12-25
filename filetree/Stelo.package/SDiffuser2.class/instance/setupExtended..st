private
setupExtended: anArray
	| src dst |
	src := 1.
	dst := order + 4.
	order
		timesRepeat: [ extented
				replaceFrom: dst
				to: dst + order - 1
				with: anArray
				startingAt: src.
			src := src + order.
			dst := dst + order + 2 ]