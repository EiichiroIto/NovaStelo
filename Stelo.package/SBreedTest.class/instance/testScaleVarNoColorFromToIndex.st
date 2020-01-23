tests-command
testScaleVarNoColorFromToIndex
	| br a |
	br := STurtles new.
	a := br addVariable: 'a'.
	br privVariables forceSize: 2.
	br var: a at: 1 put: 0.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: SColorList black.
	br var: a at: 1 put: 10.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: SColorList white.
	br var: a at: 1 put: 5.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 34.
	br var: a at: 1 put: 1.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 30.
	br var: a at: 1 put: 9.
	br
		scaleVarNo: a
		color: 35
		from: 1
		to: 9
		index: 1.
	self assert: (br colorAt: 1) equals: 39.
	br var: a at: 1 put: 10.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: SColorList black.
	br var: a at: 1 put: 0.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: SColorList white.
	br var: a at: 1 put: 5.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 34.
	br var: a at: 1 put: 1.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 39.
	br var: a at: 1 put: 9.
	br
		scaleVarNo: a
		color: 35
		from: 9
		to: 1
		index: 1.
	self assert: (br colorAt: 1) equals: 30