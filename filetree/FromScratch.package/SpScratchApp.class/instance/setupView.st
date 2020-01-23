private
setupView
	| viewTarget |
	viewTarget := project scripts first.
	project scripts
		do: [ :m | 
			m scripts size > viewTarget scripts size
				ifTrue: [ viewTarget := m ] ].
	presenter target: viewTarget