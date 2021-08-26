"
A ScratchLinePlotterTest is a test class for testing the behavior of ScratchLinePlotter
"
Class {
	#name : #ScratchPlotterMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchPlotterMorphTest >> newPlotter [
	^ ScratchPlotterMorph new
]

{ #category : #test }
ScratchPlotterMorphTest >> testAcceptPlots [
	| p |
	p := self newPlotter.
	self assert: p acceptPlots.
	p acceptPlots: false.
	self deny: p acceptPlots.
	p acceptPlots: true.
	self assert: p acceptPlots
]

{ #category : #test }
ScratchPlotterMorphTest >> testAddPenColor [
	| p |
	p := self newPlotter.
	self assert: p pens size equals: 1.
	self assert: p pens first equals: Color blue.
	p addPen: 1 color: Color red.
	self assert: p pens first equals: Color red.
	p addPen: 3 color: Color black.
	self assert: p pens third equals: Color black
]

{ #category : #test }
ScratchPlotterMorphTest >> testAddPlots [
	| p |
	p := self newPlotter.
	p
		addPlots:
			{(ScratchPlot channel: 1 data: 2).
			(ScratchPlot channel: 1 data: 3)}.
	self assert: p data size equals: 2.
	self assertCollection: p data first equals: #(2).
	self assertCollection: p data second equals: #(3).
	p acceptPlots: false.
	p addPlots: {(ScratchPlot channel: 1 data: 2)}.
	self assert: p data size equals: 2
]

{ #category : #test }
ScratchPlotterMorphTest >> testAxisFont [
	| p |
	p := self newPlotter.
	self assert: (p axisFont isKindOf: AbstractFont)
]

{ #category : #test }
ScratchPlotterMorphTest >> testClearPlots [
	self testReset
]

{ #category : #test }
ScratchPlotterMorphTest >> testColors [
	| p |
	p := self newPlotter.
	self assert: p colors isArray.
	p colors do: [ :each | self assert: each isColor ]
]

{ #category : #test }
ScratchPlotterMorphTest >> testData [
	| p |
	p := self newPlotter.
	self assert: p data isCollection.
	self assert: p data isEmpty.
	p plot: 1 data: 99.
	self assert: p data size equals: 1
]

{ #category : #test }
ScratchPlotterMorphTest >> testEnsurePenExists [
	| p |
	p := self newPlotter.
	self assert: p pens size equals: 1.
	self assert: p pens first isColor.
	p ensurePenExists: 3.
	self assert: p pens size equals: 3.
	self assert: p pens first isColor.
	self assert: p pens second isNil.
	self assert: p pens third isColor.
	p plot: 1 data: 10.
	p ensurePenExists: 5.
	self assert: p last size equals: 5
]

{ #category : #test }
ScratchPlotterMorphTest >> testInitialize [
	| p |
	p := self newPlotter.
	self assert: p data isCollection.
	self assert: p last isNil.
	self assert: p colors isArray
]

{ #category : #test }
ScratchPlotterMorphTest >> testLast [
	| p |
	p := self newPlotter.
	self assert: p last isNil.
	p plot: 1 data: 99.
	self assert: (p last at: 1) equals: 99
]

{ #category : #test }
ScratchPlotterMorphTest >> testListOf [
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assertCollection: (p listOf: 1) equals: #(10 20).
	self assertCollection: (p listOf: 2) equals: #(30 40)
]

{ #category : #test }
ScratchPlotterMorphTest >> testMarkerExtent [
	| p |
	p := self newPlotter.
	self assert: p markerExtent equals: 5 @ 5
]

{ #category : #test }
ScratchPlotterMorphTest >> testMax [
	| p |
	p := self newPlotter.
	self assert: p max isNil.
	p max: 123.
	self assert: p max equals: 123.
	p max: 456.
	self assert: p max equals: 456
]

{ #category : #test }
ScratchPlotterMorphTest >> testMaxData [
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	self assert: p maxData equals: 10.
	p plot: 2 data: 20.
	self assert: p maxData equals: 20.
	p plot: 1 data: 30.
	self assert: p maxData equals: 30.
	p plot: 2 data: 40.
	self assert: p maxData equals: 40.
	p plot: 1 data: 5.
	self assert: p maxData equals: 40.
	p plot: 2 data: 4.
	self assert: p maxData equals: 40
]

{ #category : #test }
ScratchPlotterMorphTest >> testMaxSize [
	| p |
	p := self newPlotter.
	self assert: p maxSize isNil.
	p maxSize: 10.
	self assert: p maxSize equals: 10.
	p maxSize: 2.
	self assert: p maxSize equals: 2.
	self assert: p numData equals: 0.
	p newData.
	p newData.
	self assert: p numData equals: 2.
	p newData.
	self assert: p numData equals: 2
]

{ #category : #test }
ScratchPlotterMorphTest >> testMin [
	| p |
	p := self newPlotter.
	self assert: p min isNil.
	p min: 123.
	self assert: p min equals: 123.
	p min: 456.
	self assert: p min equals: 456
]

{ #category : #test }
ScratchPlotterMorphTest >> testMinData [
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	self assert: p minData equals: 10.
	p plot: 2 data: 20.
	self assert: p minData equals: 10.
	p plot: 1 data: 30.
	self assert: p minData equals: 10.
	p plot: 2 data: 40.
	self assert: p minData equals: 10.
	p plot: 1 data: 5.
	self assert: p minData equals: 5.
	p plot: 2 data: 4.
	self assert: p minData equals: 4
]

{ #category : #test }
ScratchPlotterMorphTest >> testModelBounds [
	| p |
	p := self newPlotter.
	self assert: p modelBounds equals: p bounds
]

{ #category : #test }
ScratchPlotterMorphTest >> testNewData [
	| p |
	p := self newPlotter.
	self assert: p last isNil.
	self assert: p data isEmpty.
	p newData.
	self assert: p last isArray.
	self assert: p data size equals: 1
]

{ #category : #test }
ScratchPlotterMorphTest >> testNumChannels [
	| p |
	p := self newPlotter.
	self assert: p numChannels equals: 1.
	p addPen: 2 color: Color red.
	self assert: p numChannels equals: 2.
	p addPen: 5 color: Color red.
	self assert: p numChannels equals: 5.
	p addPen: 3 color: Color red.
	self assert: p numChannels equals: 5
]

{ #category : #test }
ScratchPlotterMorphTest >> testNumData [
	| p |
	p := self newPlotter.
	self assert: p numData equals: 0.
	p addPlots: { ScratchPlot channel: 1 data: 1 }.
	p addPlots: { ScratchPlot channel: 1 data: 2 }.
	p addPlots: { ScratchPlot channel: 1 data: 3 }.
	self assert: p numData equals: 3
]

{ #category : #test }
ScratchPlotterMorphTest >> testPens [
	| p |
	p := self newPlotter.
	self assert: p pens isCollection.
	self assert: p pens size equals: 1.
	p plot: 2 data: 99.
	self assert: p pens size equals: 2
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlot [
	| p d |
	p := self newPlotter.
	p plot: 1 data: 2.
	p plot: 1 data: 3.
	self deny: p data isEmpty.
	d := ScratchPlot clearPlots.
	p plot: d.
	self assert: p data isEmpty
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlotData [
	| p |
	p := self newPlotter.
	self assert: p data isEmpty.
	self assert: p last isNil.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	self assert: p data size equals: 2.
	self assert: p data second equals: p last.
	self assert: p last first equals: 20.
	p plot: 2 data: 30.
	self assert: p data size equals: 2.
	self assert: p data second equals: p last.
	self assert: p last second equals: 30.
	p plot: 2 data: 40.
	self assert: p data size equals: 3.
	self assert: p data third equals: p last.
	self assert: p last second equals: 40
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlotList [
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assertCollection: p data first equals: #(10).
	self assertCollection: p data second equals: #(20 30).
	self assertCollection: p data third equals: #(nil 40).
	self assertCollection: p last equals: #(nil 40).
	p plot: 2 list: #(2 3).
	self assertCollection: p data first equals: #(10 2).
	self assertCollection: p data second equals: #(20 3).
	self assertCollection: p data third equals: #(nil nil).
	self assertCollection: p last equals: #(nil nil).
	p plot: 1 list: #(5 6 7 8).
	self assertCollection: p data first equals: #(5 2).
	self assertCollection: p data second equals: #(6 3).
	self assertCollection: p data third equals: #(7 nil).
	self assertCollection: p data fourth equals: #(8 nil).
	self assertCollection: p last equals: #(8 nil)
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlottingBounds [
	| p |
	p := self newPlotter.
	self assert: p plottingBounds isRectangle.
	self assert: p plottingBounds width > 0.
	self assert: p plottingBounds height > 0
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlottingData [
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
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlottingDataAt [
	| p ret |
	p := self newPlotter.
	p min: 5.
	p max: 10.
	p plot: 1 data: 5.
	p plot: 1 data: 10.
	p plot: 1 data: 7.5.
	p plot: 1 data: 0.
	p plot: 1 data: 15.
	p height: 35+100.
	self assert: p plottingBounds height equals: 100.
	ret := p plottingDataAt: 1.
	self assertCollection: ret equals: #(0).
	ret := p plottingDataAt: 2.
	self assertCollection: ret equals: #(100).
	ret := p plottingDataAt: 3.
	self assertCollection: ret equals: #(50).
	ret := p plottingDataAt: 4.
	self assertCollection: ret equals: #(0).
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100).
	p plot: 2 data: 7.5.
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100 50).
	ret := p plottingDataAt: 4.
	self assertCollection: ret equals: #(0 nil).
	p addPen: 3 color: Color black.
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100 50 nil)
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlottingHeight [
	| p |
	p := self newPlotter.
	self assert: p plottingHeight > 0
]

{ #category : #test }
ScratchPlotterMorphTest >> testPlottingWidth [
	| p |
	p := self newPlotter.
	self assert: p plottingWidth > 0
]

{ #category : #test }
ScratchPlotterMorphTest >> testPrivCache [
	| p |
	p := self newPlotter.
	self assert: p privCache isNil.
	p privCache: #(1 2 3).
	self assertCollection: p privCache equals: #(1 2 3)
]

{ #category : #test }
ScratchPlotterMorphTest >> testReplacePlotAtPut [
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assert: p data first equals: #(10).
	self assert: p data second equals: #(20 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 1 at: 2 put: 5.
	self assert: p data first equals: #(10).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 2 at: 1 put: 6.
	self assert: p data first equals: #(10 6).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 1 at: 3 put: 7.
	self assert: p data first equals: #(10 6).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(7 40)
]

{ #category : #test }
ScratchPlotterMorphTest >> testReset [
	| p |
	p := self newPlotter.
	p plot: 2 data: 99.
	self assert: (p last at: 2) equals: 99.
	self assert: p pens size equals: 2.
	self assert: p data size equals: 1.
	p min: 456.
	self assert: p min equals: 456.
	p max: 123.
	self assert: p max equals: 123.
	p reset.
	self assert: p pens isArray.
	self assert: p pens isEmpty.
	self assert: p data isCollection.
	self assert: p data isEmpty.
	self assert: p last isNil.
	self assert: p min isNil.
	self assert: p max isNil
]

{ #category : #test }
ScratchPlotterMorphTest >> testUpdateCache [
	| p |
	p := self newPlotter.
	self assert: p privCache isNil.
	p updateCache.
	self assert: p privCache isCollection
]

{ #category : #test }
ScratchPlotterMorphTest >> testUpdatePeriod [
	| p |
	p := self newPlotter.
	self assert: p updatePeriod equals: 1000.
	p updatePeriod: 100.
	self assert: p updatePeriod equals: 100.
	p updatePeriod: 200.
	self assert: p updatePeriod equals: 200
]

{ #category : #test }
ScratchPlotterMorphTest >> testUseMarker [
	| p |
	p := self newPlotter.
	p width: 100.
	self assert: p useMarker.
	100 timesRepeat: [ p addPlots: {(ScratchPlot channel: 1 data: 1)} ].
	self deny: p useMarker
]

{ #category : #test }
ScratchPlotterMorphTest >> testWhenMouseClicked [
	| p x a b |
	p := self newPlotter.
	self assert: p whenMouseClicked isNil.
	x := 0.
	a := b := nil.
	p
		whenMouseClicked: [ :obj :evt | 
			x := 1.
			a := obj.
			b := evt ].
	self assert: p whenMouseClicked isBlock.
	self assert: x equals: 0.
	p click: 5.
	self assert: x equals: 1.
	self assert: (a isKindOf: ScratchPlotterMorph).
	self assert: b equals: 5
]
