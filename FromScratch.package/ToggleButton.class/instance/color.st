accessing
color

	isOn
		ifNotNil:[isOn
			ifTrue:[^ onForm colorAt: ((onForm width // 2)@(onForm height // 2))]
			ifFalse:[isOver
				ifTrue:[^ overForm colorAt: ((overForm width // 2)@(overForm height // 2))]
				ifFalse:[^ offForm colorAt: ((offForm width // 2)@(offForm height // 2))]]]
		ifNil:[^ super color].