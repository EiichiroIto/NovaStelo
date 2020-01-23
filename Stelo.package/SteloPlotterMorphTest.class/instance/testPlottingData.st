test
testPlottingData
	| p ret |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 1 data: 30.
	p plot: 1 data: 40.
	p width: 56.
	self assert: p plottingBounds width equals: 1.
	p height: 75.
	self assert: p plottingBounds height equals: 40.
	p min: 0.
	ret := p plottingData.
	self assertCollection: ret equals: #(#(40)).
	p width: 55+2.
	self assert: p plottingBounds width equals: 2.
	ret := p plottingData.
	self assertCollection: ret equals: #(#(20) #(40)).
	p width: 55+3.
	self assert: p plottingBounds width equals: 3.
	ret := p plottingData.
	self assertCollection: ret equals: #(#(10) #(20) #(40)).
	p width: 55+4.
	self assert: p plottingBounds width equals: 4.
	ret := p plottingData.
	self assertCollection: ret equals: #(#(10) #(20) #(30) #(40)).
	p width: 55+5.
	self assert: p plottingBounds width equals: 5.
	ret := p plottingData.
	self assertCollection: ret equals: #(#(10) #(20) #(30) #(40) #(nil)).
	p width: 55+6.
	self assert: p plottingBounds width equals: 6.
	ret := p plottingData.
	self
		assertCollection: ret
		equals: #(#(10) #(20) #(30) #(40) #(nil) #(nil)).
	p width: 55+7.
	self assert: p plottingBounds width equals: 7.
	ret := p plottingData.
	self
		assertCollection: ret
		equals: #(#(10) #(nil) #(20) #(nil) #(30) #(nil) #(40)).
	p width: 55+8.
	self assert: p plottingBounds width equals: 8.
	ret := p plottingData.
	self
		assertCollection: ret
		equals: #(#(10) #(nil) #(20) #(nil) #(30) #(nil) #(40) #(nil)).
	p width: 55+9.
	self assert: p plottingBounds width equals: 9.
	ret := p plottingData.
	self
		assertCollection: ret
		equals: #(#(10) #(nil) #(20) #(nil) #(30) #(nil) #(40) #(nil) #(nil)).
	p width: 55+10.
	self assert: p plottingBounds width equals: 10.
	ret := p plottingData.
	self
		assertCollection: ret
		equals: #(#(10) #(nil) #(nil) #(20) #(nil) #(nil) #(30) #(nil) #(nil) #(40)).
	p width: 55+11.
	self assert: p plottingBounds width equals: 11.
	ret := p plottingData.
	self
		assertCollection: ret
		equals:
			#(#(10) #(nil) #(nil) #(20) #(nil) #(nil) #(30) #(nil) #(nil) #(40) #(nil))