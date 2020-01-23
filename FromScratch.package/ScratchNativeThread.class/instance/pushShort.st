private
pushShort
	| v |
	v := codes at: pc.
	pc := pc + 1.
	v := (codes at: pc) * 16r100 + v.
	pc := pc + 1.
	v >= 16r8000
		ifTrue: [ v := v - 16r10000 ].
	^ self push: v