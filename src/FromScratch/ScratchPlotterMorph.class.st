Class {
	#name : #ScratchPlotterMorph,
	#superclass : #Morph,
	#instVars : [
		'pens',
		'data',
		'last',
		'min',
		'max',
		'cache',
		'lastUpdateTime',
		'updatePeriod',
		'whenMouseClicked',
		'maxSize',
		'acceptPlots'
	],
	#category : #'FromScratch-Plotter'
}

{ #category : #accessing }
ScratchPlotterMorph >> acceptPlots [
	^ acceptPlots ifNil: [ true ]
]

{ #category : #accessing }
ScratchPlotterMorph >> acceptPlots: aBoolean [
	acceptPlots := aBoolean
]

{ #category : #accessing }
ScratchPlotterMorph >> addPen: anInteger color: aColor [
	self ensurePenExists: anInteger.
	pens at: anInteger put: aColor
]

{ #category : #api }
ScratchPlotterMorph >> addPlots: aCollection [
	self acceptPlots
		ifFalse: [ ^ self ].
	aCollection do: [ :each | self plot: each ].
	self updateDisplay
]

{ #category : #private }
ScratchPlotterMorph >> axisFont [
	^ TextStyle defaultFont
]

{ #category : #api }
ScratchPlotterMorph >> clearPlots [
	self
		reset;
		updateDisplay
]

{ #category : #'event handling' }
ScratchPlotterMorph >> click: evt [
	whenMouseClicked ifNil: [ ^ self ].
	whenMouseClicked cull: self cull: evt
]

{ #category : #private }
ScratchPlotterMorph >> colors [
	^ {Color blue.
	Color red.
	Color yellow.
	Color green}
]

{ #category : #accessing }
ScratchPlotterMorph >> data [
	^ data
]

{ #category : #drawing }
ScratchPlotterMorph >> drawAxesOn: aCanvas [
	| str w |
	aCanvas
		frameRectangle: self plottingBounds
		color: ScratchTheme plotterFrameColor.
	self min
		ifNotNil: [ :num | 
			aCanvas
				drawString: num asString
				at: self plottingBounds bottomLeft + (-40 @ -15)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ].
	self max
		ifNotNil: [ :num | 
			aCanvas
				drawString: num asString
				at: self plottingBounds topLeft + (-40 @ 5)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ].
	self data
		ifNotNil: [ :list | 
			str := list size asString.
			w := self axisFont widthOfString: str.
			aCanvas
				drawString: str
				at: self plottingBounds bottomRight - (w @ 0)
				font: self axisFont
				color: ScratchTheme plotterFrameColor ]
]

{ #category : #drawing }
ScratchPlotterMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawAxesOn: aCanvas.
	cache ifNil: [ ^ self ].
	self drawPlotDataOn: aCanvas
]

{ #category : #drawing }
ScratchPlotterMorph >> drawPlotDataOn: aCanvas [
	| from x p2 y c drawMarker |
	from := Array new: pens size.
	x := self plottingBounds left.
	y := self plottingBounds bottom.
	drawMarker := self useMarker
		ifTrue: [ [ :p :c1 | 
			aCanvas
				fillRectangle: (Rectangle center: p extent: self markerExtent)
				color: c1 ] ]
		ifFalse: [ [ :p :c1 |  ] ].
	cache
		do: [ :list | 
			list
				withIndexDo: [ :each :index | 
					each
						ifNotNil: [ p2 := x @ (y - each).
							c := pens at: index.
							drawMarker cull: p2 cull: c.
							(from at: index)
								ifNotNil: [ :p1 | aCanvas line: p1 to: p2 color: c ].
							from at: index put: p2 ] ].
			x := x + 1 ]
]

{ #category : #private }
ScratchPlotterMorph >> ensurePenExists: anInteger [
	anInteger > pens size
		ifTrue: [ pens := pens grownBy: anInteger - pens size.
			last
				ifNotNil: [ last := last grownBy: anInteger - last size.
					data at: data size put: last ] ].
	(pens at: anInteger)
		ifNil: [ pens at: anInteger put: (self colors atWrap: anInteger) ]
]

{ #category : #'event handling' }
ScratchPlotterMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #initialization }
ScratchPlotterMorph >> initialize [
	super initialize.
	self color: ScratchTheme plotterPaneColor.
	self reset.
	self ensurePenExists: 1.
	lastUpdateTime := Time now
]

{ #category : #accessing }
ScratchPlotterMorph >> last [
	^ last
]

{ #category : #accessing }
ScratchPlotterMorph >> layoutChanged [
	super layoutChanged.
	self updateCache
]

{ #category : #accessing }
ScratchPlotterMorph >> listOf: anInteger [
	| stream value |
	stream := WriteStream on: Array new.
	data
		do: [ :each | 
			(each size >= anInteger and: [ (value := each at: anInteger) notNil ])
				ifTrue: [ stream nextPut: value ] ].
	^ stream contents
]

{ #category : #private }
ScratchPlotterMorph >> markerExtent [
	^ 5 @ 5
]

{ #category : #accessing }
ScratchPlotterMorph >> max [
	^ max ifNil: [ self maxData ]
]

{ #category : #accessing }
ScratchPlotterMorph >> max: aNumber [
	max := aNumber
]

{ #category : #private }
ScratchPlotterMorph >> maxData [
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
]

{ #category : #accessing }
ScratchPlotterMorph >> maxSize [
	^ maxSize
]

{ #category : #accessing }
ScratchPlotterMorph >> maxSize: anInteger [
	maxSize := anInteger
]

{ #category : #accessing }
ScratchPlotterMorph >> min [
	^ min ifNil: [ self minData ]
]

{ #category : #accessing }
ScratchPlotterMorph >> min: aNumber [
	min := aNumber
]

{ #category : #private }
ScratchPlotterMorph >> minData [
	| v |
	v := nil.
	data
		do: [ :each | 
			each
				do: [ :each2 | 
					each2
						ifNotNil: [ (v isNil or: [ each2 < v ])
								ifTrue: [ v := each2 ] ] ] ].
	^ v
]

{ #category : #accessing }
ScratchPlotterMorph >> modelBounds [
	^ bounds
]

{ #category : #'event handling' }
ScratchPlotterMorph >> mouseDown: evt [
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #private }
ScratchPlotterMorph >> newData [
	last := Array new: pens size.
	(maxSize notNil and: [ data size >= maxSize ])
		ifTrue: [ data removeFirst: data size - maxSize + 1 ].
	data add: last.
	^ last
]

{ #category : #accessing }
ScratchPlotterMorph >> numChannels [
	^ pens size
]

{ #category : #accessing }
ScratchPlotterMorph >> numData [
	^ data size
]

{ #category : #accessing }
ScratchPlotterMorph >> pens [
	^ pens
]

{ #category : #accessing }
ScratchPlotterMorph >> plot: aPlotData [
	aPlotData applyTo: self
]

{ #category : #accessing }
ScratchPlotterMorph >> plot: anInteger data: aFloat [
	self ensurePenExists: anInteger.
	(last isNil or: [ (last at: anInteger) notNil ])
		ifTrue: [ self newData ].
	last at: anInteger put: aFloat
]

{ #category : #accessing }
ScratchPlotterMorph >> plot: anInteger list: aCollection [
	self ensurePenExists: anInteger.
	data size > aCollection size
		ifTrue: [ aCollection
				withIndexDo: [ :each :index | self replacePlot: anInteger at: index put: each ].
			aCollection size + 1 to: data size do: [ :index | self replacePlot: anInteger at: index put: nil ].
			last at: anInteger put: nil ]
		ifFalse: [ 1 to: data size do:
				[ :index | self replacePlot: anInteger at: index put: (aCollection at: index) ].
			data size + 1 to: aCollection size do: [ :index | 
				self newData.
				last at: anInteger put: (aCollection at: index) ] ].
	self updateDisplay
]

{ #category : #private }
ScratchPlotterMorph >> plottingBounds [
	^ (self left + 50) @ (self top + 5)
		corner: (self right - 5) @ (self bottom - 30)
]

{ #category : #private }
ScratchPlotterMorph >> plottingData [
	| stream rest count w |
	data isEmpty
		ifTrue: [ ^ Array new ].
	stream := WriteStream on: Array new.
	w := rest := self plottingWidth.
	data size > rest
		ifTrue: [ 1 to: rest do: [ :each | 
				stream
					nextPut: (self plottingDataAt: (data size / rest * each) truncated) ] ]
		ifFalse: [ 1 to: data size do: [ :each | 
				stream nextPut: (self plottingDataAt: each).
				rest := rest - 1.
				data size > 1
					ifTrue: [ count := ((w - 1) / (data size - 1)) truncated - 1.
						(count min: rest)
							timesRepeat: [ stream nextPut: (Array new: pens size) ].
						rest := rest - count ] ].
			rest timesRepeat: [ stream nextPut: (Array new: pens size) ] ].
	^ stream contents
]

{ #category : #private }
ScratchPlotterMorph >> plottingDataAt: anInteger [
	| ret min1 max1 list ratio h |
	h := self plottingHeight.
	min1 := min ifNil: [ self minData ].
	max1 := max ifNil: [ self maxData ].
	(min1 isNil or: [ max1 isNil ])
		ifTrue: [ ^ nil ].
	list := data at: anInteger.
	list size < pens size
		ifTrue: [ list := list grownBy: pens size - list size ].
	^ list
		collect: [ :each | 
			each
				ifNotNil: [ ratio := (max1 closeTo: min1)
						ifTrue: [ 0.5 ]
						ifFalse: [ ((each - min1) / (max1 - min1)) asFloat ].
					ret := 0 interpolateTo: h at: ratio.
					ret := 0 max: ret.
					ret := h min: ret.
					ret ] ]
]

{ #category : #private }
ScratchPlotterMorph >> plottingHeight [
	^ self plottingBounds height truncated
]

{ #category : #private }
ScratchPlotterMorph >> plottingWidth [
	^ self plottingBounds width truncated
]

{ #category : #private }
ScratchPlotterMorph >> privCache [
	^ cache
]

{ #category : #private }
ScratchPlotterMorph >> privCache: aCollection [
	cache := aCollection
]

{ #category : #private }
ScratchPlotterMorph >> replacePlot: anInteger at: index put: value [
	| old |
	old := data at: index.
	anInteger > old size
		ifTrue: [ old := old grownBy: anInteger - old size ].
	old at: anInteger put: value.
	data at: index put: old
]

{ #category : #private }
ScratchPlotterMorph >> reset [
	pens := Array new.
	data := OrderedCollection new.
	last := nil.
	min := nil.
	max := nil.
	cache := nil
]

{ #category : #private }
ScratchPlotterMorph >> updateCache [
	cache := self plottingData
]

{ #category : #accessing }
ScratchPlotterMorph >> updateDisplay [
	(Time now asDuration - lastUpdateTime asDuration) totalSeconds
		< (self updatePeriod / 1000)
		ifTrue: [ ^ self ].
	lastUpdateTime := Time now.
	self
		updateCache;
		changed
]

{ #category : #accessing }
ScratchPlotterMorph >> updatePeriod [
	^ updatePeriod ifNil: [ 1000 ]
]

{ #category : #accessing }
ScratchPlotterMorph >> updatePeriod: anInteger [
	updatePeriod := anInteger
]

{ #category : #testing }
ScratchPlotterMorph >> useMarker [
	^ self numData * 6 < self plottingWidth
]

{ #category : #accessing }
ScratchPlotterMorph >> whenMouseClicked [
	^ whenMouseClicked
]

{ #category : #accessing }
ScratchPlotterMorph >> whenMouseClicked: aBlock [
	whenMouseClicked := aBlock
]
