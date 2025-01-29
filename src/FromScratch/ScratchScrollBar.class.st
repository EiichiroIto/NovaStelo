Class {
	#name : 'ScratchScrollBar',
	#superclass : 'Morph',
	#instVars : [
		'target',
		'selector',
		'sliderStart',
		'sliderLength',
		'frameStartForm',
		'frameMiddleForm',
		'frameEndForm',
		'sliderStartForm',
		'sliderMiddleForm',
		'sliderEndForm',
		'sliderInsets',
		'dragOffset'
	],
	#category : 'FromScratch-Morphic',
	#package : 'FromScratch',
	#tag : 'Morphic'
}

{ #category : 'instance creation' }
ScratchScrollBar class >> newHorizontal [
	"Answer a new horizontal scrollbar."

	^ self new initVertical: false

]

{ #category : 'instance creation' }
ScratchScrollBar class >> newVertical [
	"Answer a new vertical scrollbar."

	^ self new initVertical: true

]

{ #category : 'drawing' }
ScratchScrollBar >> drawHEdge: aForm from: startX to: endX yOffset: yOffset on: aCanvas [
	"Use the given form starting at the given point to draw a horizontal edge between the given starting and ending x positions. Do nothing if the given form is nil."

	| x y |
	aForm ifNil: [^ self].
	x := startX.
	y := bounds top + yOffset.
	[x <= endX] whileTrue: [
		aCanvas translucentImage: aForm at: x@y.
		x := x + aForm width].

]

{ #category : 'drawing' }
ScratchScrollBar >> drawHSliderOn: aCanvas [
	"Draw a horizontal slider on the given canvas."

	| y leftX rightX |
	sliderLength = self maxSliderLength ifTrue: [^ self].
	y := self top + sliderInsets top.
	leftX := self left + sliderInsets left + sliderStart.
	rightX := leftX + sliderLength.
	self drawHEdge: sliderMiddleForm
		from: leftX + sliderStartForm width
		to: (rightX - sliderEndForm width)
		yOffset: sliderInsets top
		on: aCanvas.
	aCanvas translucentImage: sliderStartForm at: (leftX @ y).
	aCanvas translucentImage: sliderEndForm at: ((rightX - sliderEndForm width + 1) @ y).

]

{ #category : 'drawing' }
ScratchScrollBar >> drawOn: aCanvas [
	"Draw myself, clipping to my bounds."

	| clipC |
	clipC := aCanvas copyClipRect: self bounds.

	self bounds isWide
		ifTrue: [
			"draw horizontal frame"
			self drawHEdge: frameMiddleForm
				from: (self left + frameStartForm width)
				to: (self right - frameEndForm width)
				yOffset: 0
				on: clipC.
			clipC translucentImage: frameStartForm at: self topLeft.
			clipC translucentImage: frameEndForm at: ((self right + 1 - frameEndForm width) @ self top).

			self drawHSliderOn: clipC]	
		ifFalse: [
			"draw vertical frame"
			self drawVEdge: frameMiddleForm
				from: (self top + frameStartForm height)
				to: (self bottom - frameEndForm height)
				xOffset: 0
				on: clipC.
			clipC translucentImage: frameStartForm at: self topLeft.
			clipC translucentImage: frameEndForm at: (self left @ (self bottom + 1 - frameEndForm height)).

			self drawVSliderOn: clipC].


]

{ #category : 'drawing' }
ScratchScrollBar >> drawVEdge: aForm from: startY to: endY xOffset: xOffset on: aCanvas [
	"Use the given form starting at the given point to draw a vertical edge between the given starting and ending y positions. Do nothing if the given form is nil."

	| x y |
	aForm ifNil: [^ self].
	x := bounds left + xOffset.
	y := startY.
	[y <= endY] whileTrue: [
		aCanvas translucentImage: aForm at: x@y.
		y := y + aForm height].

]

{ #category : 'drawing' }
ScratchScrollBar >> drawVSliderOn: aCanvas [
	"Draw a vertical slider on the given canvas."

	| x topY bottomY |
	sliderLength = self maxSliderLength ifTrue: [^ self].
	x := self left + sliderInsets left.
	topY := self top + sliderInsets top + sliderStart.
	bottomY := topY + sliderLength.
	self drawVEdge: sliderMiddleForm
		from: topY + sliderStartForm height
		to: (bottomY - sliderEndForm height)
		xOffset: sliderInsets left
		on: aCanvas.
	aCanvas translucentImage: sliderStartForm at: (x @ topY).
	aCanvas translucentImage: sliderEndForm at: (x @ (bottomY - sliderEndForm height + 1)).

]

{ #category : 'initialization' }
ScratchScrollBar >> hFrameForm: frameForm sliderForm: sliderForm [
	"Initialize myself as a horizontal slider, setting my forms by cutting up the given forms."

	| midX h |
	"set my forms"
	midX := frameForm height // 2.
	h := frameForm height.
	frameStartForm := frameForm copy: (0@0 extent: midX@h).
	frameMiddleForm := frameForm copy: (midX@0 extent: 1@h).
	frameEndForm := frameForm copy: ((midX + 1)@0 corner: frameForm extent).

	h := sliderForm height.
	sliderStartForm := sliderForm copy: (0@0 extent: 7@h).
	sliderMiddleForm := sliderForm copy: (7@0 extent: 1@h).
	sliderEndForm := sliderForm copy: (8@0 corner: sliderForm extent).

	sliderInsets := 3@3 corner: 3@5.
	self extent: 200 @ frameStartForm height.

]

{ #category : 'event handling' }
ScratchScrollBar >> handlesMouseDown: evt [

	^ true

]

{ #category : 'initialization' }
ScratchScrollBar >> initVertical: aBoolean [

	aBoolean
		ifTrue: [
		 	self vFrameForm: (ScratchTheme formAt: #vScrollFrame)
				sliderForm: (ScratchTheme formAt: #vScrollSlider)]
		ifFalse: [
		 	self hFrameForm: (ScratchTheme formAt: #hScrollFrame)
				sliderForm: (ScratchTheme formAt: #hScrollSlider)].

]

{ #category : 'initialization' }
ScratchScrollBar >> initialize [

	super initialize.
	sliderStart := 0.
	sliderLength := 50.
	sliderInsets := 3 @ 3 corner: 0 @ 5.
	dragOffset := 0
]

{ #category : 'event handling' }
ScratchScrollBar >> linearOffset: evt [
	"Answer the linear position of the given event's cursor point along my slider's range. For example, this will be zero at the leftmost/topmost edge of the slider's range."

	bounds isWide
		ifTrue: [^ evt cursorPoint x - (self left + sliderInsets left)]  "horizontal"
		ifFalse: [^ evt cursorPoint y - (self top + sliderInsets top)].  "vertical"


]

{ #category : 'event handling' }
ScratchScrollBar >> maxSliderLength [
	"Answer the maximum slider length."

	bounds isWide
		ifTrue: [^ bounds width - (sliderInsets left + sliderInsets right)]
		ifFalse: [^ bounds height - (sliderInsets top + sliderInsets bottom)].


]

{ #category : 'event handling' }
ScratchScrollBar >> maxSliderStart [
	"Answer the maximum sliderStart value given the slider's length."

	bounds isWide
		ifTrue: [^ bounds width - (sliderLength + sliderInsets left + sliderInsets right)]
		ifFalse: [^ bounds height - (sliderLength + sliderInsets top + sliderInsets bottom)].

]

{ #category : 'event handling' }
ScratchScrollBar >> minSliderLength [
	"Answer the minimum slider length."

	bounds isWide
		ifTrue: [^ sliderEndForm width + sliderEndForm width]
		ifFalse: [^ sliderEndForm height + sliderEndForm height].

]

{ #category : 'event handling' }
ScratchScrollBar >> mouseDown: evt [
	"Record the offset between the slider's start offset and the relative event's location."

	| offset pageDelta |
	dragOffset := nil.
	self maxSliderLength = sliderLength ifTrue: [^ self].  "do nothing"

	offset := self linearOffset: evt.
	((offset >= sliderStart) & (offset <= (sliderStart + sliderLength)))
		ifTrue: [  "mouse went down on the slider: start dragging it"
			dragOffset := sliderStart - offset].

	"handle page up or down"
	pageDelta := sliderLength / self maxSliderLength.
	offset < sliderStart
		ifTrue: [self scrollFraction: self scrollFraction - pageDelta; updateTarget]
		ifFalse: [self scrollFraction: self scrollFraction + pageDelta; updateTarget]


]

{ #category : 'event handling' }
ScratchScrollBar >> mouseMove: evt [
	"Update the slider position if in drag mode."

	dragOffset ifNil: [^ self].  "not in slider drag mode"

	sliderStart := (self linearOffset: evt) + dragOffset.
	sliderStart := (sliderStart max: 0) min: (self maxSliderStart).
	self updateTarget.
	self changed.

]

{ #category : 'scroll bar protocol' }
ScratchScrollBar >> scrollDelta: ignore1 pageDelta: ignore2 [
	"For compatability with old scrollbars. I don't support paging or scrolling arrows."

]

{ #category : 'accessing' }
ScratchScrollBar >> scrollFraction [
	"Answer the scroll fraction, a number between 0.0 and 1.0."

	| maxStart |
	(maxStart := self maxSliderStart) = 0 ifTrue: [^ 0.0].
	^ sliderStart asFloat / maxStart

]

{ #category : 'accessing' }
ScratchScrollBar >> scrollFraction: aNumber [
	"Set my scroll fraction, a number between 0.0 and 1.0."

	sliderStart := (((aNumber asFloat min: 1.0) max: 0.0) * self maxSliderStart) rounded.
	self changed.

]

{ #category : 'accessing' }
ScratchScrollBar >> selector: aSymbol [

	selector := aSymbol.

]

{ #category : 'accessing' }
ScratchScrollBar >> target: anObject [

	target := anObject.

]

{ #category : 'scroll bar protocol' }
ScratchScrollBar >> updateTarget [
	"Update my target object with my current value, a number between 0.0 and 1.0. Do nothing if either my target or my selector is nil."

	target notNil & selector notNil
		ifTrue: [target perform: selector with: self scrollFraction].

]

{ #category : 'initialization' }
ScratchScrollBar >> vFrameForm: frameForm sliderForm: sliderForm [
	"Initialize myself as a vertical slider, setting my forms by cutting up the given forms."

	| midY w |
	"set my forms"
	midY := frameForm height // 2.
	w := frameForm width.
	frameStartForm := frameForm copy: (0@0 extent: w@midY).
	frameMiddleForm := frameForm copy: (0@midY extent: w@1).
	frameEndForm := frameForm copy: (0@(midY + 1) corner: frameForm extent).

	w := sliderForm width.
	sliderStartForm := sliderForm copy: (0@0 extent: w@7).
	sliderMiddleForm := sliderForm copy: (0@(7) extent: w@1).
	sliderEndForm := sliderForm copy: (0@(11) corner: sliderForm extent).

	sliderInsets := 3@3 corner: 0@5.
	self extent: frameStartForm width @ 200.

]

{ #category : 'scroll bar protocol' }
ScratchScrollBar >> value: scrollFraction [
	"Set my scroll fraction (range is 0.0 to 1.0). This method is for compatability with ScrollBar."

	self scrollFraction: scrollFraction.

]
