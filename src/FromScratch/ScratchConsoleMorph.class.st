Class {
	#name : 'ScratchConsoleMorph',
	#superclass : 'Morph',
	#instVars : [
		'font',
		'charExtent',
		'screen',
		'screenSize',
		'cursor'
	],
	#category : 'FromScratch-Morphic',
	#package : 'FromScratch',
	#tag : 'Morphic'
}

{ #category : 'accessing' }
ScratchConsoleMorph >> charExtent [

	^ charExtent
]

{ #category : 'accessing' }
ScratchConsoleMorph >> charExtent: anObject [

	charExtent := anObject
]

{ #category : 'private' }
ScratchConsoleMorph >> characterAt: aPoint [

	| line |
	(self withinScreen: aPoint) ifFalse: [ ^ Character space ].
	line := screen at: aPoint y + 1.
	aPoint x >= line size ifTrue: [ ^ Character space ].
	^ line at: aPoint x + 1
]

{ #category : 'private' }
ScratchConsoleMorph >> characterAt: aPoint put: aCharacter [

	| line |
	(self withinScreen: aPoint) ifFalse: [ ^ self ].
	line := screen at: aPoint y + 1.
	line := aPoint x >= line size
		        ifTrue: [ 
		        line , (String new: aPoint x - line size withAll: Character space)
		        , aCharacter asString ]
		        ifFalse: [ 
			        (line copyFrom: 1 to: aPoint x) , aCharacter asString
			        , (line copyFrom: aPoint x + 2 to: line size) ].
	screen at: aPoint y + 1 put: line
]

{ #category : 'api' }
ScratchConsoleMorph >> clearScreen [

	screen := Array new: screenSize y withAll: ''.
	cursor := 0 @ 0
]

{ #category : 'private' }
ScratchConsoleMorph >> currentLine [
	^ screen at: cursor y + 1
]

{ #category : 'private' }
ScratchConsoleMorph >> currentLine: aString [
	screen at: cursor y + 1 put: aString
]

{ #category : 'accessing' }
ScratchConsoleMorph >> cursor [

	^ cursor
]

{ #category : 'accessing' }
ScratchConsoleMorph >> cursor: anObject [

	cursor := anObject
]

{ #category : 'private' }
ScratchConsoleMorph >> defaultFont [
	^ StandardFonts codeFont
]

{ #category : 'private' }
ScratchConsoleMorph >> defaultScreenSize [
	^ 80 @ 25
]

{ #category : 'drawing' }
ScratchConsoleMorph >> drawCursorOn: aCanvas [

	| pos c |
	c := self characterAt: cursor.
	pos := self topLeft + (cursor * charExtent).
	aCanvas fillRectangle: (pos extent: charExtent) color: self textColor.
	aCanvas
		drawString: c asString
		at: pos
		font: font
		color: self color
]

{ #category : 'drawing' }
ScratchConsoleMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawScreenOn: aCanvas.
	self drawCursorOn: aCanvas
]

{ #category : 'drawing' }
ScratchConsoleMorph >> drawScreenOn: aCanvas [

	| pos |
	pos := self topLeft.
	screen do: [ :each | 
		aCanvas
			drawString: each
			at: pos
			font: font
			color: self textColor.
		pos := pos x @ (pos y + charExtent y) ]
]

{ #category : 'geometry' }
ScratchConsoleMorph >> extent: aPoint [

	| old |
	old := self extent.
	super extent: aPoint.
	aPoint = old ifTrue: [ ^ self ].
	screenSize := aPoint // charExtent.
	self clearScreen
]

{ #category : 'accessing' }
ScratchConsoleMorph >> font [

	^ font
]

{ #category : 'accessing' }
ScratchConsoleMorph >> font: anObject [

	font := anObject.
	self updateCharExtent.
	self updateExtent
]

{ #category : 'api' }
ScratchConsoleMorph >> goto: aPoint [

	(self withinScreen: aPoint) ifFalse: [ ^ cursor := 0 @ 0 ].
	cursor := aPoint
]

{ #category : 'event handling' }
ScratchConsoleMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : 'initialization' }
ScratchConsoleMorph >> initialize [
	super initialize.
	self color: Color black.
	screenSize := self defaultScreenSize.
	self clearScreen.
	font := self defaultFont.
	self updateCharExtent.
	self updateExtent
]

{ #category : 'event handling' }
ScratchConsoleMorph >> mouseDown: evt [
	
]

{ #category : 'private' }
ScratchConsoleMorph >> newLine [

	| line |
	(self withinScreen: cursor) ifFalse: [ ^ self ].
	line := self currentLine.
	line := line copyFrom: 1 to: cursor x.
	self currentLine: line.
	cursor := 0 @ (cursor y + 1).
	cursor y < screenSize y ifTrue: [ ^ self ].
	self scroll: 1.
	cursor := 0 @ (screenSize y - 1)
]

{ #category : 'api' }
ScratchConsoleMorph >> put: aString [

	aString do: [ :each | 
		(each = Character lf or: [ each = Character cr ])
			ifTrue: [ self newLine ]
			ifFalse: [ self putChar: each ] ]
]

{ #category : 'private' }
ScratchConsoleMorph >> putChar: aCharacter [

	self characterAt: cursor put: aCharacter.
	cursor := cursor + (1 @ 0).
	(self withinScreen: cursor) ifTrue: [ ^ self ].
	cursor x >= screenSize x ifTrue: [ cursor := 0 @ (cursor y + 1) ].
	cursor y < screenSize y ifTrue: [ ^ self ].
	self scroll: 1.
	cursor := 0 @ (screenSize y - 1)
]

{ #category : 'accessing' }
ScratchConsoleMorph >> screen [

	^ screen
]

{ #category : 'accessing' }
ScratchConsoleMorph >> screen: anObject [

	screen := anObject
]

{ #category : 'accessing' }
ScratchConsoleMorph >> screenSize [

	^ screenSize
]

{ #category : 'accessing' }
ScratchConsoleMorph >> screenSize: anObject [

	screenSize := anObject.
	self clearScreen.
	self updateExtent
]

{ #category : 'private' }
ScratchConsoleMorph >> scroll: anInteger [

	anInteger >= screenSize y ifTrue: [ ^ self clearScreen ].
	screen := (screen
		           copyFrom: screen size - (screenSize y - anInteger - 1)
		           to: screen size) , (Array new: anInteger withAll: '')
]

{ #category : 'private' }
ScratchConsoleMorph >> textColor [
	^ Color green
]

{ #category : 'private' }
ScratchConsoleMorph >> updateCharExtent [
	charExtent := (font linearWidthOf: $M) @ font height
]

{ #category : 'private' }
ScratchConsoleMorph >> updateExtent [

	super extent: screenSize * charExtent
]

{ #category : 'testing' }
ScratchConsoleMorph >> withinScreen: aPoint [

	^ aPoint >= (0 @ 0) and: [ aPoint < screenSize ]
]
