microworld
scaleVarNo: vid color: baseColor from: from to: to
	| v c |
	v := variables realArrayAt: vid.
	v
		withIndexDo: [ :each :index | 
			c := self
				scaleValue: each
				color: baseColor
				from: from
				to: to.
			self colorAt: index put: c ]