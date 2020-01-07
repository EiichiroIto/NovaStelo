Class {
	#name : #SteloPlotterMorph,
	#superclass : #Morph,
	#instVars : [
		'pens',
		'data',
		'last',
		'min',
		'max',
		'cache',
		'lastUpdateTime',
		'project'
	],
	#category : #'Stelo-Morphic'
}

{ #category : #accessing }
SteloPlotterMorph >> addPen: anInteger color: aColor [
	self ensurePenExists: anInteger.
	pens at: anInteger put: aColor
]

{ #category : #accessing }
SteloPlotterMorph >> addPlots: aCollection [
	aCollection do: [ :each | self plot: each ].
	self updateDisplay
]

{ #category : #private }
SteloPlotterMorph >> axisFont [
	^ TextStyle defaultFont
]

{ #category : #accessing }
SteloPlotterMorph >> clearPlots [
	self
		reset;
		updateDisplay
]

{ #category : #'event handling' }
SteloPlotterMorph >> click: evt [
	self showMenu: evt
]

{ #category : #private }
SteloPlotterMorph >> colors [
	^ {Color blue.
	Color red.
	Color yellow.
	Color green}
]

{ #category : #accessing }
SteloPlotterMorph >> data [
	^ data
]

{ #category : #drawing }
SteloPlotterMorph >> drawAxesOn: aCanvas [
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
SteloPlotterMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawAxesOn: aCanvas.
	cache ifNil: [ ^ self ].
	self drawPlotDataOn: aCanvas
]

{ #category : #drawing }
SteloPlotterMorph >> drawPlotDataOn: aCanvas [
	| from x p2 y |
	from := Array new: pens size.
	x := self plottingBounds left.
	y := self plottingBounds bottom.
	cache
		do: [ :list | 
			list
				withIndexDo: [ :each :index | 
					each
						ifNotNil: [ p2 := x @ (y - each).
							(from at: index)
								ifNotNil: [ :p1 | aCanvas line: p1 to: p2 color: (pens at: index) ].
							from at: index put: p2 ] ].
			x := x + 1 ]
]

{ #category : #private }
SteloPlotterMorph >> ensurePenExists: anInteger [
	anInteger > pens size
		ifTrue: [ pens := pens grownBy: anInteger - pens size.
			last
				ifNotNil: [ last := last grownBy: anInteger - last size.
					data at: data size put: last ] ].
	(pens at: anInteger)
		ifNil: [ pens at: anInteger put: (self colors atWrap: anInteger) ]
]

{ #category : #'event handling' }
SteloPlotterMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #initialization }
SteloPlotterMorph >> initialize [
	super initialize.
	self color: ScratchTheme plotterPaneColor.
	self reset.
	self ensurePenExists: 1.
	lastUpdateTime := Time now
]

{ #category : #accessing }
SteloPlotterMorph >> last [
	^ last
]

{ #category : #accessing }
SteloPlotterMorph >> layoutChanged [
	super layoutChanged.
	self updateCache
]

{ #category : #accessing }
SteloPlotterMorph >> listOf: anInteger [
	| stream value |
	stream := WriteStream on: Array new.
	data
		do: [ :each | 
			(each size >= anInteger and: [ (value := each at: anInteger) notNil ])
				ifTrue: [ stream nextPut: value ] ].
	^ stream contents
]

{ #category : #accessing }
SteloPlotterMorph >> max [
	^ max ifNil: [ self maxData ]
]

{ #category : #accessing }
SteloPlotterMorph >> max: aNumber [
	max := aNumber
]

{ #category : #private }
SteloPlotterMorph >> maxData [
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
SteloPlotterMorph >> min [
	^ min ifNil: [ self minData ]
]

{ #category : #accessing }
SteloPlotterMorph >> min: aNumber [
	min := aNumber
]

{ #category : #private }
SteloPlotterMorph >> minData [
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
SteloPlotterMorph >> modelBounds [
	^ bounds
]

{ #category : #'event handling' }
SteloPlotterMorph >> mouseDown: evt [
	evt hand newKeyboardFocus: nil.
	evt hand waitForClicksOrDrag: self event: evt
]

{ #category : #private }
SteloPlotterMorph >> newData [
	last := Array new: pens size.
	data add: last.
	^ last
]

{ #category : #accessing }
SteloPlotterMorph >> numPlots [
	^ pens size
]

{ #category : #accessing }
SteloPlotterMorph >> pens [
	^ pens
]

{ #category : #accessing }
SteloPlotterMorph >> plot: aPlotData [
	aPlotData applyTo: self
]

{ #category : #accessing }
SteloPlotterMorph >> plot: anInteger data: aFloat [
	self ensurePenExists: anInteger.
	(last isNil or: [ (last at: anInteger) notNil ])
		ifTrue: [ self newData ].
	last at: anInteger put: aFloat
]

{ #category : #accessing }
SteloPlotterMorph >> plot: anInteger list: aCollection [
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
SteloPlotterMorph >> plottingBounds [
	^ (self left + 50) @ (self top + 5)
		corner: (self right - 5) @ (self bottom - 30)
]

{ #category : #private }
SteloPlotterMorph >> plottingData [
	| stream rest count w |
	data isEmpty
		ifTrue: [ ^ Array new ].
	stream := WriteStream on: Array new.
	w := rest := self plottingBounds width truncated.
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
SteloPlotterMorph >> plottingDataAt: anInteger [
	| ret min1 max1 list ratio h |
	h := self plottingBounds height.
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
SteloPlotterMorph >> privCache [
	^ cache
]

{ #category : #private }
SteloPlotterMorph >> privCache: aCollection [
	cache := aCollection
]

{ #category : #accessing }
SteloPlotterMorph >> project [
	^ project
]

{ #category : #accessing }
SteloPlotterMorph >> project: aProject [
	project := aProject
]

{ #category : #private }
SteloPlotterMorph >> replacePlot: anInteger at: index put: value [
	| old |
	old := data at: index.
	anInteger > old size
		ifTrue: [ old := old grownBy: anInteger - old size ].
	old at: anInteger put: value.
	data at: index put: old
]

{ #category : #private }
SteloPlotterMorph >> reset [
	pens := Array new.
	data := OrderedCollection new.
	last := nil.
	min := nil.
	max := nil.
	cache := nil
]

{ #category : #'event handling' }
SteloPlotterMorph >> showMenu: anEvent [
	| m |
	(m := self project) ifNil: [ ^ self ].
	m application currentTarget
		ifNotNil: [ :s | self showMenu: anEvent script: s ]
]

{ #category : #'event handling' }
SteloPlotterMorph >> showMenu: anEvent script: aScript [
	"Present a menu of Scratch script operations."

	| app menu |
	app := self project application.
	menu := MenuMorph new.
	menu target: app.
	menu add: 'Clear Plots' target: self selector: #clearPlots.
	menu add: 'Save Plots as PNG' selector: #savePlotsAsImage.
	menu localize.
	menu popUpEvent: anEvent in: self world
]

{ #category : #private }
SteloPlotterMorph >> updateCache [
	cache := self plottingData
]

{ #category : #accessing }
SteloPlotterMorph >> updateDisplay [
	((Time now asDuration - lastUpdateTime asDuration) totalSeconds < 1.0)
		ifTrue: [ ^ self ].
	lastUpdateTime := Time now.
	self
		updateCache;
		changed
]
