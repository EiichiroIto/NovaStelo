private
countBlockMorph: aMorph
	| list |
	list := aMorph submorphs
		collect: [ :each | self countBlockMorph: each ].
	^ (list isEmpty ifTrue: [ 0 ] ifFalse: [ list sum ])
		+
			(aMorph isBlockMorph
				ifTrue: [ 1 ]
				ifFalse: [ 0 ])