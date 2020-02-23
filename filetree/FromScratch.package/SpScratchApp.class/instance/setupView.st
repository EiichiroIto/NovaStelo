private
setupView
	| viewTarget |
	viewTarget := project scripts first.
	project scripts
		do: [ :m | 
			m hatBlocks size > viewTarget hatBlocks size
				ifTrue: [ viewTarget := m ] ].
	presenter target: viewTarget