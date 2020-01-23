private
maxData
	| v |
	v := nil.
	data
		do: [ :each | 
			each
				do: [ :each2 | 
					each2
						ifNotNil: [ (v isNil or: [ each2 > v ])
								ifTrue: [ v := each2 ] ] ] ].
	^ v