"
This subclass of ScrollFrameMorph uses ScratchScrollBars.

"
Class {
	#name : #ScrollFrameMorph2,
	#superclass : #ScrollFrameMorph,
	#instVars : [
		'scrollBarStartInset',
		'scrollBarEndInset'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #drawing }
ScrollFrameMorph2 >> drawSubmorphsOn: aCanvas [
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
ScrollFrameMorph2 >> extent: aPoint [
	"After setting my size, position and size my scrollbars and grow box. Also update my contents and scrollbar ranges."

	| inner w h |
	super extent: (aPoint truncated max: self minWidth @ self minHeight).
	scrollBarStartInset
		ifNil: [ scrollBarStartInset := scrollBarEndInset := 0 ].	"needed during initialization"
	inner := self innerBounds.
	w := inner width - scrollBarStartInset.
	vScrollbar owner = self
		ifTrue: [ w := w - vbarInset ]
		ifFalse: [ w := w - scrollBarEndInset ].
	hScrollbar
		position: (inner left + scrollBarStartInset) @ (inner bottom - hbarInset).
	hScrollbar width: w.
	h := inner height - scrollBarStartInset.
	hScrollbar owner = self
		ifTrue: [ h := h - hbarInset ]
		ifFalse: [ h := h - scrollBarEndInset ].
	vScrollbar
		position: (inner right - vbarInset) @ (inner top + scrollBarStartInset).
	vScrollbar height: h.
	self updateContentsExtent.
	self updateScrollbars
]

{ #category : #initialization }
ScrollFrameMorph2 >> initialize [

	super initialize.
	self borderWidth: 0.
	self removeAllMorphs.

	self color: Color blue.
	hbarInset := 30.
	vbarInset := 25.
	scrollBarStartInset := 10.
	scrollBarEndInset := 14.
	contentsChanged := false.

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
	self extent: 160@120.

]

{ #category : #'scrollbar visibility' }
ScrollFrameMorph2 >> showHorizontalScrollbar: aBoolean [
	"Show or hide my horizontal scrollbar."

	aBoolean = (hScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: hScrollbar]
		ifFalse: [hScrollbar delete].

	self extent: self extent.

]

{ #category : #'scrollbar visibility' }
ScrollFrameMorph2 >> showVerticalScrollbar: aBoolean [
	"Show or hide my vertical scrollbar."

	aBoolean = (vScrollbar owner = self) ifTrue: [^ self].

	aBoolean
		ifTrue: [self addMorph: vScrollbar]
		ifFalse: [vScrollbar delete].

	self extent: self extent.

]
