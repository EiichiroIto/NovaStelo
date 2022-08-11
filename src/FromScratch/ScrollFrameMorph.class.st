"
I am a frame for scrollable contents. I can independently show or hide my horizontal and vertical scrollbars.



"
Class {
	#name : #ScrollFrameMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'contents',
		'hScrollbar',
		'vScrollbar',
		'contentsChanged',
		'growthFraction'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #accessing }
ScrollFrameMorph >> contents [
	"Answer my contents morph."

	^ contents

]

{ #category : #accessing }
ScrollFrameMorph >> contents: aMorph [
	"Replace my contents morph. The argument can be any morph. Typically it is a BorderedMorph or a PasteUpMorph."

	contents ifNotNil: [contents delete].
	contents := aMorph.
	contents position: self topLeft + borderWidth.
	self addMorphBack: contents.
	self extent: self extent.

]

{ #category : #private }
ScrollFrameMorph >> contentsBounds [
	"Answer a rectangle that encloses the bounds of all my submorphs."

	| offset r |
	offset := contents topLeft negated.
	r := 0@0 extent: 1@1.
	contents submorphsDo: [:m |
		r := r quickMerge: (m fullBounds translateBy: offset) truncated].
	^ r

]

{ #category : #drawing }
ScrollFrameMorph >> drawSubmorphsOn: aCanvas [
	"If my contents has changed, fix it's extent and update my scrollbar ranges. Clip submorph drawing to my bounds."

	| clipR |
	contentsChanged ifTrue: [
		self updateContentsExtent.
		self updateScrollbars.
		contentsChanged := false].

	"draw my contents morph clipped to my visible extent"
	aCanvas isShadowDrawing ifFalse: [ 
	clipR := self innerBounds topLeft extent: self visibleExtent.
	(aCanvas copyClipRect: clipR) fullDrawMorph: contents].

	"draw all my submorphs other than my contents"
	submorphs reverseDo:[:m |
		(m ~~ contents) ifTrue: [aCanvas fullDrawMorph: m]].



]

{ #category : #geometry }
ScrollFrameMorph >> extent: aPoint [

	"After setting my size, position and size my scrollbars and grow box. Also update my contents and scrollbar ranges."

	| inner w h |
	super extent: (aPoint truncated max: self minWidth @ self minHeight).

	inner := self innerBounds.

	w := inner width - self scrollBarStartInset - (vScrollbar owner = self
		      ifTrue: [ self vbarInset ]
		      ifFalse: [ self scrollBarEndInset ]).
	hScrollbar position:
		inner left + self scrollBarStartInset @ (inner bottom - self hbarInset).
	hScrollbar extent: w @ self hbarInset.

	h := inner height - self scrollBarStartInset - (hScrollbar owner = self
		      ifTrue: [ self hbarInset ]
		      ifFalse: [ self scrollBarEndInset ]).
	vScrollbar position:
		inner right - self vbarInset @ (inner top + self scrollBarStartInset).
	vScrollbar extent: self vbarInset @ h.

	self updateContentsExtent.
	self updateScrollbars
]

{ #category : #geometry }
ScrollFrameMorph >> fullBounds [
	"Overridden to clip submorph hit detection to my bounds."

	^ bounds

]

{ #category : #accessing }
ScrollFrameMorph >> growthFraction: aNumber [
	"Set the amount to grow when contents do not fit, expressed as a fraction of the current size. For example, 0.5 makes the contains pane 50% larger if any submorph extends over the edge."

	growthFraction := aNumber max: 0.0.

]

{ #category : #layout }
ScrollFrameMorph >> hResizing [

	^ #spaceFill

]

{ #category : #scrolling }
ScrollFrameMorph >> hScrollPixels [
	"Answer the current horizontal scroll offset in pixels."

	^ (self left + borderWidth) - contents left


]

{ #category : #scrolling }
ScrollFrameMorph >> hScrollPixels: hOffset [
	"Scroll to the given horizontal offset in pixels. Zero is scrolled to the left and increasing values scroll right."

	| delta maxOffset |
	delta := (hOffset asInteger min: self maxScroll x) max: 0.
	contents left: ((self left + borderWidth) - delta) truncated.

	maxOffset := self maxScroll x.
	maxOffset > 0 ifTrue: [hScrollbar value: self hScrollPixels / maxOffset].

]

{ #category : #scrolling }
ScrollFrameMorph >> hScrollRelative: aFloat [
	"Sent by the horizontal scrollbar. Scroll to the given relative postion between 0.0 and 1.0."

	self hScrollPixels: aFloat * self maxScroll x.

]

{ #category : #private }
ScrollFrameMorph >> hbarInset [
	^ 30
]

{ #category : #initialization }
ScrollFrameMorph >> initialize [

	super initialize.
	self borderWidth: 0.
	self color: Color blue.
	contentsChanged := false.
	growthFraction := 0.6.

	contents := PasteUpMorph new
		            color: (Color gray: 0.9);
		            borderWidth: 0;
		            enableDragNDrop: true.
	hScrollbar := ScratchScrollBar newHorizontal
		              target: self;
		              selector: #hScrollRelative:.
	vScrollbar := ScratchScrollBar newVertical
		              target: self;
		              selector: #vScrollRelative:.

	contents position: self position + borderWidth.
	self addMorph: contents.
	self addMorph: hScrollbar.
	self addMorph: vScrollbar.
	self extent: 160 @ 120
]

{ #category : #geometry }
ScrollFrameMorph >> invalidRect: damageRect [
	"Clip damage reports to my bounds, since drawing is clipped to my bounds."

	| r |
	r := damageRect intersect: self bounds.
	(r width > 0 and: [r height > 0]) ifTrue: [super invalidRect: r].

]

{ #category : #geometry }
ScrollFrameMorph >> layoutChanged [
	"If my contents morph's layout has changed, record that fact."

	super layoutChanged.
	contents mayNeedLayout ifTrue: [contentsChanged := true].

]

{ #category : #scrolling }
ScrollFrameMorph >> maxScroll [
	"Answer a point representing the maximum horizontal and vertical scroll offsets in pixels."

	^ contents extent - self visibleExtent

]

{ #category : #layout }
ScrollFrameMorph >> minHeight [

	^ 45

]

{ #category : #layout }
ScrollFrameMorph >> minWidth [

	^ 60

]

{ #category : #private }
ScrollFrameMorph >> scrollBarEndInset [
	^ 14
]

{ #category : #private }
ScrollFrameMorph >> scrollBarStartInset [
	^ 10
]

{ #category : #'scrollbar visibility' }
ScrollFrameMorph >> showHorizontalScrollbar: aBoolean [
	"Show or hide my horizontal scrollbar."

	aBoolean = (hScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: hScrollbar]
		ifFalse: [hScrollbar delete].

	self extent: self extent.

]

{ #category : #'scrollbar visibility' }
ScrollFrameMorph >> showVerticalScrollbar: aBoolean [
	"Show or hide my vertical scrollbar."

	aBoolean = (vScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: vScrollbar]
		ifFalse: [vScrollbar delete].

	self extent: self extent.

]

{ #category : #private }
ScrollFrameMorph >> updateContentsExtent [
	"Make sure my content morph is large enough to both enclose all it's submorphs and to fill me. Adjust the scroll offsets if my bounds have shrunk."

	| r delta scrolledOff w h visible |
	r := self contentsBounds.
	((r left < 0) or: [r top < 0]) ifTrue: [
		"contents has morphs that stick out over its top or left edge"
		delta := (r topLeft truncated min: (0@0)) negated.
		contents submorphsDo: [:m | m position: m position + delta]].  "move all submorphs by delta"

	visible := self visibleExtent - (8@20).
	w := visible x. r width > w ifTrue: [w := (r width + (growthFraction * visible x)) rounded].
	h := visible y. r height > h ifTrue: [h := (r height + (growthFraction * visible y))  rounded].

	scrolledOff := ((self topLeft + borderWidth) - contents position) max: 0@0.
	contents extent: ((w@h) max: (self visibleExtent + scrolledOff)).
	contentsChanged := false.

]

{ #category : #private }
ScrollFrameMorph >> updateScrollbars [
	"Update my scrollbars based on my current contents."

	| visibleExtent currentScroll maxScroll |
	contents ifNil: [^ self].  "not fully initialized yet"

	visibleExtent := self visibleExtent.
	"hScrollbar percentVisible: (visibleExtent x asFloat / contents width).
	vScrollbar percentVisible: (visibleExtent y asFloat / contents height)."

	currentScroll := (self topLeft + borderWidth) - contents position.
	contents width > visibleExtent x
		ifTrue: [
			maxScroll := contents width - visibleExtent x.
			self showHorizontalScrollbar: true.
			hScrollbar
				scrollDelta: 4 / maxScroll asFloat 
				pageDelta: (visibleExtent x - 40) / maxScroll asFloat.
			hScrollbar value: currentScroll x / maxScroll]
		ifFalse: [
			self showHorizontalScrollbar: false.
			hScrollbar value: 0].

	contents height > visibleExtent y
		ifTrue: [
			maxScroll := contents height - visibleExtent y.
			self showVerticalScrollbar: true.
			vScrollbar
				scrollDelta: 4.0 / maxScroll asFloat 
				pageDelta: (visibleExtent y - 40) / maxScroll asFloat.
			vScrollbar value: currentScroll y / maxScroll]
		ifFalse: [
			self showVerticalScrollbar: false.
			vScrollbar value: 0].

]

{ #category : #layout }
ScrollFrameMorph >> vResizing [

	^ #spaceFill

]

{ #category : #scrolling }
ScrollFrameMorph >> vScrollPixels [
	"Answer the current vertical scroll offset in pixels."

	^ (self top + borderWidth) - contents top


]

{ #category : #scrolling }
ScrollFrameMorph >> vScrollPixels: vOffset [
	"Scroll to the given vertical offset in pixels. Zero is scrolled to the top and increasing values scroll down."

	| delta maxOffset |
	delta := (vOffset asInteger min: self maxScroll y) max: 0.
	contents top: ((self top + borderWidth) - delta) truncated.

	maxOffset := self maxScroll y.
	maxOffset > 0 ifTrue: [vScrollbar value: self vScrollPixels / maxOffset].

]

{ #category : #scrolling }
ScrollFrameMorph >> vScrollRelative: aFloat [
	"Sent by the vertical scrollbar. Scroll to the given relative postion between 0.0 and 1.0."

	self vScrollPixels: aFloat * self maxScroll y.

]

{ #category : #private }
ScrollFrameMorph >> vbarInset [
	^ 25
]

{ #category : #private }
ScrollFrameMorph >> visibleExtent [
	"Answer the extent of my visible area. That is, the area within my borders minus the space used for scrollbars."

	| clipToScrollBarEdge visibleW visibleH |
	clipToScrollBarEdge := false.
	clipToScrollBarEdge ifFalse: [^ self extent - (2 * borderWidth)].

	visibleW := self width - (2 * borderWidth).
	vScrollbar owner = self ifTrue: [visibleW := visibleW - self vbarInset].
	visibleH := self height - (2 * borderWidth).
	hScrollbar owner = self ifTrue: [visibleH := visibleH - self hbarInset].
	^ visibleW@visibleH

]
