private
resolveJumpAddress: aCollection using: anArray
	aCollection
		do: [ :each | 
			each isJump
				ifTrue: [ each address: (anArray at: each labelId) ] ].