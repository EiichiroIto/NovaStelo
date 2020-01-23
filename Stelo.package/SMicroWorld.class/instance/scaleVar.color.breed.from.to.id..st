command
scaleVar: v color: c breed: bid from: f to: t id: id
	bid = SBreedId observerBreedNo
		ifTrue: [ self patches
				scaleVarNo: v
				color: c
				from: f
				to: t ]
		ifFalse: [ (breeds at: bid)
				scaleVarNo: v
				color: c
				from: f
				to: t
				index: id ]