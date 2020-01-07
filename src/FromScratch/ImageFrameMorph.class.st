"
I am draw a rectangular frame using Forms. I have Forms for my four corners and form Forms that are used to tile my edges so that I can be resized.

"
Class {
	#name : #ImageFrameMorph,
	#superclass : #Morph,
	#instVars : [
		'frameInFront',
		'topLeftForm',
		'topRightForm',
		'bottomLeftForm',
		'bottomRightForm',
		'topEdgeForm',
		'leftEdgeForm',
		'rightEdgeForm',
		'bottomEdgeForm',
		'myBox',
		'edgeCache'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #drawing }
ImageFrameMorph >> areasRemainingToFill: aRectangle [
	"Drawing optimization. Since I completely fill my bounds with opaque pixels, this method tells Morphic that it isn't necessary to draw any morphs covered by me."
	
	^ aRectangle areasOutside: self bounds

]

{ #category : #drawing }
ImageFrameMorph >> drawBackgroundOn: aCanvas [
	"Draw my background."

	color isTransparent ifTrue: [^ self].

	aCanvas
		fillRectangle: ((myBox origin + topLeftForm extent) corner: (myBox corner - bottomRightForm extent))
		color: color.

]

{ #category : #drawing }
ImageFrameMorph >> drawBottomEdgeOn: aCanvas [
	"Draw my bottom edge."

	| r f |
	r := ((myBox left + topLeftForm width) @ (myBox bottom - bottomEdgeForm height)) corner: ((myBox right - bottomRightForm width) @ myBox bottom).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 3.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r width by: bottomEdgeForm width do: [:x | bottomEdgeForm displayOn: f at: x@0 rule: Form over].
		edgeCache at: 3 put: f].

	aCanvas translucentImage: f at: r topLeft.

]

{ #category : #drawing }
ImageFrameMorph >> drawCornersOn: aCanvas [
	"Draw my corners if they intersect the canvas clipping box."

	| clipR p |
	clipR := aCanvas clipRect.

	p := myBox topLeft.
	((p extent: topLeftForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: topLeftForm at: p].

	p := (myBox right - topRightForm width)@myBox top.
	((p extent: topRightForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: topRightForm at: p].

	p := myBox left@(myBox bottom - bottomLeftForm height).
	((p extent: bottomLeftForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: bottomLeftForm at: p].

	p := (myBox right - bottomRightForm width)@(myBox bottom - bottomRightForm height).
	((p extent: bottomRightForm extent) intersects: clipR) ifTrue: [
		aCanvas translucentImage: bottomRightForm at: p].

]

{ #category : #drawing }
ImageFrameMorph >> drawFrameOn: aCanvas [
	"Draw my edges and corners. Draw a simple border if any of my forms is nil."

	(topLeftForm isNil | topRightForm isNil | bottomLeftForm isNil | bottomRightForm isNil |
	 topEdgeForm isNil | leftEdgeForm isNil | rightEdgeForm isNil | bottomEdgeForm isNil)
		ifTrue: [^ aCanvas frameRectangle: self bounds width: 3 color: Color red].

	"draw edges"
	self drawTopEdgeOn: aCanvas.
	self drawLeftEdgeOn: aCanvas.
	self drawRightEdgeOn: aCanvas.
	self drawBottomEdgeOn: aCanvas.

	self drawCornersOn: aCanvas.


]

{ #category : #drawing }
ImageFrameMorph >> drawLeftEdgeOn: aCanvas [
	"Draw my left edge."

	| r f |
	r := (myBox left @ (myBox top + topLeftForm height)) corner: ((myBox left + leftEdgeForm width) @ (myBox bottom - bottomLeftForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 1.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r height by: leftEdgeForm height do: [:y | leftEdgeForm displayOn: f at: 0@y rule: Form over].
		edgeCache at: 1 put: f].

	aCanvas translucentImage: f at: r topLeft.

]

{ #category : #drawing }
ImageFrameMorph >> drawOn: aCanvas [
	"Draw my background."

	"myBox has integer position and extent and has a potentially inset bottom"
	myBox := bounds origin truncated corner: (bounds right@self insetBottom) truncated.

	self drawBackgroundOn: aCanvas.

	frameInFront ifFalse: [self drawFrameOn: aCanvas].

]

{ #category : #drawing }
ImageFrameMorph >> drawRightEdgeOn: aCanvas [
	"Draw my right edge."

	| r f |
	r := ((myBox right - rightEdgeForm width) @ (myBox top + topRightForm height)) corner: (myBox right @ (myBox bottom - bottomRightForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 4.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r height by: rightEdgeForm height do: [:y | rightEdgeForm displayOn: f at: 0@y rule: Form over].
		edgeCache at: 4 put: f].

	aCanvas translucentImage: f at: r topLeft.


]

{ #category : #drawing }
ImageFrameMorph >> drawTopEdgeOn: aCanvas [
	"Draw my top edge."

	| r f |
	r := ((myBox left + topLeftForm width) @ myBox top) corner: ((myBox right - topRightForm width) @ (myBox top + topEdgeForm height)).
	(r intersects: aCanvas clipRect) ifFalse: [^ self].

	f := edgeCache at: 2.
	(f isNil or: [f extent ~= r extent]) ifTrue: [
		f := Form extent: r extent depth: 32.
		0 to: r width by: topEdgeForm width do: [:x | topEdgeForm displayOn: f at: x@0 rule: Form over].
		edgeCache at: 2 put: f].

	aCanvas translucentImage: f at: r topLeft.

]

{ #category : #drawing }
ImageFrameMorph >> fullDrawOn: aCanvas [
	"Draw my frame in front of my submorphs."

	| clipC |
	self visible ifFalse: [^ self].
	(self hasProperty: #errorOnDraw) ifTrue:[^ self drawErrorOn: aCanvas].
	(aCanvas isVisible: self fullBounds) ifFalse: [^ self].

	"myBox has integer position and extent and has a potentially inset bottom"
	myBox := bounds truncated.
	clipC := aCanvas copyClipRect: myBox.

	frameInFront
		ifTrue: [
			self drawOn: clipC.
			self drawSubmorphsOn: clipC.
			self drawFrameOn: clipC]
		ifFalse: [
			self drawOn: clipC.
			self drawSubmorphsOn: clipC].

]

{ #category : #drawing }
ImageFrameMorph >> hasTranslucentColor [

	^ true

]

{ #category : #intialization }
ImageFrameMorph >> initFromForm: aForm [
	"Initialize myself by cutting up the given Form. The corners are taken to extend to one pixel short of the center in each dimension. A one-pixel strip from the center of each edge will be replicated to stretch the edge. The color of the center pixel of the rectangle will be used as the fill color. (You can suppress color filling by setting my color to transparent after calling this method)."

	| cornerExtent center |
	cornerExtent := (aForm extent - 1) // 2.
	center := aForm extent // 2.

	topLeftForm := (aForm copy: (0@0 extent: cornerExtent)).
	topRightForm := (aForm copy: ((aForm width - cornerExtent x) @ 0 extent: cornerExtent)).
	bottomLeftForm := (aForm copy: (0 @ (aForm height - cornerExtent y) extent: cornerExtent)).
	bottomRightForm := (aForm copy: ((aForm extent - cornerExtent) extent: cornerExtent)).

	topEdgeForm := (aForm copy: ((center x@0) extent: (1 @ cornerExtent y))).
	leftEdgeForm := (aForm copy: ((0 @ center y) extent: (cornerExtent x @ 1))).
	rightEdgeForm := (aForm copy: (((aForm width - cornerExtent x) @ center y) extent: (cornerExtent x @ 1))).
	bottomEdgeForm := (aForm copy: ((center x@(aForm height - cornerExtent y)) extent: (1 @ cornerExtent y))).

	color := aForm colorAt: center.

]

{ #category : #intialization }
ImageFrameMorph >> initFrontFromForm: aForm [
	"Initialize myself so that my frame is drawn in front of my submorphs, like a picture frame."

	| c f |
	frameInFront := true.

	c := (aForm colorAt: aForm extent // 2).
	f := aForm deepCopy.
	"f shapeFill: Color transparent interiorPoint: aForm extent // 2."
	self initFromForm: f.
	color := c.


]

{ #category : #intialization }
ImageFrameMorph >> initialize [

	super initialize.
	color := Color transparent.
	frameInFront := false.
	edgeCache := Array new: 5.
	self extent: 100@100.

]

{ #category : #drawing }
ImageFrameMorph >> insetBottom [

	^ self bottom

]

{ #category : #accessing }
ImageFrameMorph >> minExtent [
	"Answer my minimum extent."

	^ (topLeftForm width + topEdgeForm width + topRightForm width) @
	  (topLeftForm height + leftEdgeForm height + bottomLeftForm height)
]

{ #category : #private }
ImageFrameMorph >> orgMinExtent [
	^ super minExtent
]
