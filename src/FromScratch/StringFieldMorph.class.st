"
I am a simple, editable one-line string for use in dialog boxes.

If cr, lf, or enter is pressed and my client responds to it, I send the ""accept"" message to the client.

I support selection by dragging the mouse. Double-clicking on a word selects that word. Double-clicking at either end selects everything.

I respond to a number of editing keys including:

  backspace/delete				delete the current selection; backspace if nothing is selected
  ctrl-a							select all
  ctrl-z, ctrl-x, ctrl-c, ctrl-v		undo, cut, copy, paste
  left/right arrow				move the cursor left or right

Either the control or command key can be used to type the editing keys. That is, cmd-a does the same thing as ctrl-a. This should make both PC and Mac users happy.

"
Class {
	#name : #StringFieldMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'stringMorph',
		'frame',
		'client',
		'insetX',
		'insetY',
		'heightPadding',
		'doResizing',
		'isNumeric',
		'acceptWhenFocusLost',
		'isKeyboardFocus',
		'selectionColor',
		'selectionStart',
		'selectionEnd',
		'dragStartIndex',
		'undoState',
		'blinkState',
		'lastContents'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #private }
StringFieldMorph >> acceptEdits [
	"Tell the client to accept edits."

	client ifNil: [^ self].
	(client respondsTo: #accept) ifTrue: [client accept].
	(client respondsTo: #acceptContents) ifTrue: [client acceptContents].
	(client respondsTo: #yes) ifTrue: [client yes].

]

{ #category : #'text editing' }
StringFieldMorph >> backspace [
	"Delete the current selection. If there is no selection, delete the character before the cursor."

	| str newStr |
	(self rightSelection - self leftSelection) > 0 ifTrue: [^ self removeSelection].
	self leftSelection < 1 ifTrue: [^ self].
	self recordUndoState.
	str := stringMorph contents.
	newStr :=
		(str copyFrom: 1 to: self leftSelection - 1),
		(str copyFrom: self leftSelection + 1 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := (self leftSelection - 1) max: 0.
	self stringChanged.

]

{ #category : #accessing }
StringFieldMorph >> borderWidth: aNumber [
	"Adjust the position of my stringMorph to the new border size."

	super borderWidth: (aNumber asInteger max: 0).
	stringMorph position: self position + borderWidth + (insetX@insetY).

]

{ #category : #private }
StringFieldMorph >> characterOffsetForXOffset: screenX [
	"Answer the character offset at the given width into the string."

	| x xRanges p best isLTR |
	stringMorph contents size = 0 ifTrue: [^ 0].

	x := screenX - stringMorph leftMargin.  "x offset within the string"
	xRanges := stringMorph xRangesFor: stringMorph stringToDisplay.

	1 to: xRanges size do: [:i |
		p := xRanges at: i.
		(x between: p first and: p last) ifTrue: [
			isLTR := self isLTRAt: i in: xRanges.
			(x - p first) <= (p last - x)   "left half of character?"
				ifTrue: [^ isLTR ifTrue: [i - 1] ifFalse: [i]]
				ifFalse: [^ isLTR ifTrue: [i] ifFalse: [i - 1]]]].

	"x is not within any x-range"
	x < 0
		ifTrue: [  "x is left of the entire string; find left-most char index"
			best := 1.
			1 to: xRanges size do: [:i |
				p := xRanges at: i.
				p first < (xRanges at: best) first ifTrue: [best := i]].
			best = 1 ifTrue: [best := 0].
			^ best]
		ifFalse: [  "x is right of entire string; find right-most char index"
			best := 1.
			1 to: xRanges size do: [:i |
				p := xRanges at: i.
				p last > (xRanges at: best) last ifTrue: [best := i]].
			best = 1 ifTrue: [best := 0].
			^ best].


]

{ #category : #'event handling' }
StringFieldMorph >> click: evt [

	| hadFocus |
	hadFocus := isKeyboardFocus.
	evt hand newKeyboardFocus: self.
	hadFocus
		ifTrue: [
			selectionStart := self characterOffsetForXOffset: evt cursorPoint x.
			selectionEnd := selectionStart]
		ifFalse: [
			self selectAll].
	self stringChanged.

]

{ #category : #accessing }
StringFieldMorph >> client: aMorphOrNil [

	client := aMorphOrNil.

]

{ #category : #accessing }
StringFieldMorph >> color [

	frame ifNotNil: [^ frame color].
	^ color = Color transparent
		ifTrue: [owner color]
		ifFalse: [color]


]

{ #category : #accessing }
StringFieldMorph >> contents [

	^ stringMorph contents

]

{ #category : #accessing }
StringFieldMorph >> contents: aString [

	doResizing
		ifTrue: [stringMorph contents: aString "asUTF32"]
		ifFalse: [stringMorph contentsClipped: aString "asUTF32"].

	self stringChanged.

]

{ #category : #'text editing' }
StringFieldMorph >> copySelection [
	"Save the current selection in the clipboard."

	| s |
	s := stringMorph contents
		copyFrom: self leftSelection + 1
		to: self rightSelection.
	s isEmpty
		ifTrue: [ ^ self ].
	ScratchTranslator unicodeClipboardPut: s
]

{ #category : #private }
StringFieldMorph >> currsorOffsetFor: characterOffset [
	"Answer the insertion cursor x offset for the given character offset."

	| s xRanges xPairChar0 xPairCharLast startsOnLeft r xPairCharOffset |
	stringMorph contents size = 0 ifTrue: [^ 0].

	s := stringMorph stringToDisplay.
	xRanges := stringMorph xRangesFor: s.
	xPairChar0 := xRanges at: 1.
	xPairCharLast := xRanges last.
	startsOnLeft := xPairChar0 first < xPairCharLast last.

	"special case for a single character; double it to see if it is RTL"
	xRanges size = 1 ifTrue: [
		r := stringMorph xRangesFor: (s, s).
		startsOnLeft := r first first < r last last].

	"if string starts left-to-right, then put cursor on the left side left of first char, otherwise put it on the right side"
	characterOffset < 1 ifTrue: [
		startsOnLeft
			ifTrue: [^ xPairChar0 first]
			ifFalse: [^ xPairChar0 last - 1]].

	xPairCharOffset := xRanges at: (characterOffset min: xRanges size).

	"if string starts left-to-right, then put cursor on right size of character"
	startsOnLeft
		ifTrue: [^ xPairCharOffset last]
		ifFalse: [^ xPairCharOffset first].

]

{ #category : #'text editing' }
StringFieldMorph >> cutSelection [
	"Cut the current selection."

	selectionStart = selectionEnd ifTrue: [^ self].  "no selection; do nothing"
	self copySelection.  "save the selection we're about to cut"
	self removeSelection.

]

{ #category : #'text editing' }
StringFieldMorph >> deleteSelection [
	"Delete the current selection. If there is no selection, delete the character after the cursor."

	| str newStr |
	str := stringMorph contents.
	(self rightSelection - self leftSelection) > 0 ifTrue: [^ self removeSelection].
	(self rightSelection >= str size) ifTrue: [^ self].
	self recordUndoState.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		(str copyFrom: self leftSelection + 2 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := self leftSelection max: 0.
	self stringChanged.

]

{ #category : #accessing }
StringFieldMorph >> doResizing: aBoolean [
	"If true, resize myself to the size of the string."

	doResizing := aBoolean.

]

{ #category : #'event handling' }
StringFieldMorph >> doubleClick: evt [
	"Select word or entire contents."

	| xOffset i |
	evt hand newKeyboardFocus: self.
	xOffset := evt cursorPoint x - stringMorph left.
	xOffset < 3 ifTrue: [^ self selectAll].
	i := self characterOffsetForXOffset: evt cursorPoint x.
	self selectWordOrAll: i + 1.

]

{ #category : #drawing }
StringFieldMorph >> drawOn: aCanvas [
	"Draw the background then the selection."

	frame
		ifNil: [
			super drawOn: aCanvas]
		ifNotNil: [
			frame position: self topLeft; extent: self extent.
			frame drawOn: aCanvas].

	isKeyboardFocus ifTrue: [self drawSelectionOn: aCanvas].

]

{ #category : #drawing }
StringFieldMorph >> drawSelectionOn: aCanvas [

 	| xRanges clipC vInset offset selectionH rect pair start end |
	xRanges := stringMorph xRangesFor: stringMorph stringToDisplay.
	clipC := aCanvas copyClipRect: self innerBounds.
	vInset := borderWidth + 2.
	offset := stringMorph leftMargin@(self top + vInset).
	selectionH := self height - (2 * vInset).

	selectionStart = selectionEnd ifTrue: [
		blinkState ifNil: [blinkState := true].
		blinkState ifTrue: [
			rect := ((self currsorOffsetFor: selectionStart) - 1)@0 extent: 2@selectionH.
			clipC fillRectangle: (rect translateBy: offset) color: selectionColor].
		^ self].

	selectionStart < selectionEnd
		ifTrue: [
			start := selectionStart + 1.
			end := selectionEnd]
		ifFalse: [
			start := selectionEnd + 1.
			end := selectionStart].

	start to: end do: [:i |
		(i between: 1 and: xRanges size) ifTrue: [
			pair := xRanges at: i.
			rect := (pair first @ 0) corner: (pair second @ selectionH).
			clipC fillRectangle: (rect translateBy: offset) color: selectionColor]].

]

{ #category : #drawing }
StringFieldMorph >> drawSubmorphsOn: aCanvas [
	"Clip submorph drawing to my bounds."

	"stringMorph suppressAntiAliasing: isKeyboardFocus."
	super drawSubmorphsOn: (aCanvas copyClipRect: self innerBounds).

]

{ #category : #geometry }
StringFieldMorph >> extent: aPoint [

	super extent: aPoint.
	stringMorph width: ((self width - (2 * borderWidth) - insetX) max: 0).

]

{ #category : #accessing }
StringFieldMorph >> font [

	^ stringMorph font

]

{ #category : #accessing }
StringFieldMorph >> font: aFont [

	stringMorph font: aFont.
	stringMorph height: (stringMorph stringHeight: ScratchTranslator renderHintString).
	self height: stringMorph height + (2 * borderWidth) + heightPadding.
	insetY := (self height // 2) - borderWidth - (ScratchTranslator centerOffsetForButtonWithFont: aFont).
	insetY := insetY max: 1.
	self borderWidth: borderWidth.  "re-position string"

]

{ #category : #initialization }
StringFieldMorph >> forExpressionArg [
	frame := nil.
	borderColor := Color transparent.
	borderWidth := 0.
	insetX := 0.
	heightPadding := 2.
	self font: ScratchTranslator argFont
]

{ #category : #geometry }
StringFieldMorph >> fullBounds [
	"Overridden to clip submorph hit detection to my bounds."

	fullBounds ifNil: [fullBounds := bounds].
	^ bounds

]

{ #category : #'event handling' }
StringFieldMorph >> handlesKeyboard: evt [
	^ true
]

{ #category : #'event handling' }
StringFieldMorph >> handlesMouseDown: evt [

	^ true
]

{ #category : #initialization }
StringFieldMorph >> initialize [

	super initialize.

	stringMorph := StringMorph new
		contents: '';
		font: (StrikeFont familyName: 'Verdana' size: 12).
	self addMorph: stringMorph.

	self color: Color red.
	self textColor: ScratchTheme dialogBoxTextColor.
	doResizing := false.
	isNumeric := false.
	isKeyboardFocus := false.
	acceptWhenFocusLost := false.
	self keyboardFocusChange: false.
	selectionColor := ScratchTheme textSelectionColor.
	selectionStart := selectionEnd := 0.
	self recordUndoState.

	self borderInset; useNoFrame.
	self width: 100.
]

{ #category : #'text editing' }
StringFieldMorph >> insertCharacter: unicodeChar [
	"Insert the given character at the cursor position."

	| str newStr insertion |
	isNumeric ifTrue: [
		('-0123456789.,' asByteArray includes: unicodeChar)
			ifFalse: [^ self beep]].

	self recordUndoState.
	str := stringMorph contents.
	"insertion := UTF32 with: unicodeChar."
	insertion := (Unicode charFromUnicode: unicodeChar) asString.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		insertion,
		(str copyFrom: (self rightSelection + 1) to: str size).
	selectionEnd := selectionStart := self leftSelection + 1.
	stringMorph contentsClipped: newStr.
	self stringChanged.

]

{ #category : #private }
StringFieldMorph >> isLTRAt: index in: xRange [
	"True if the character at the given index in the given xRange is LTR."
	"Note: we decide direction based on the following character if possible."

	xRange size < 2 ifTrue: [^ true].  "can't tell direction from a single character; assume LTR"	

	index >= xRange size ifTrue: [
		^ (xRange at: xRange size - 1) first < xRange last first]. "at end; compare to previous character"

	^ (xRange at: index) first < (xRange at: index + 1) first

]

{ #category : #accessing }
StringFieldMorph >> isNumeric: aBoolean [
	"If true, then only allow typing digits and decimal point."

	isNumeric := aBoolean.

]

{ #category : #'event handling' }
StringFieldMorph >> keyDown: evt [

	| ch m |
	ch := evt keyCharacter.
	ch = Character tab ifTrue: [ 
		(m := self meOrOwnerThatIsA: CommandBlockMorph) ifNotNil: [ 
			m tabToNextField: evt ].
		^ self ].

	ch = Character cr | (ch = Character lf) ifTrue: [ 
		evt hand newKeyboardFocus: nil.
		^ self ].

	ch = Character escape ifTrue: [ ^ self ].

	ch = Character backspace ifTrue: [ ^ self backspace ].
	ch = Character delete ifTrue: [ ^ self deleteSelection ]
]

{ #category : #'event handling' }
StringFieldMorph >> keyStroke: evt [

	| ch |
	ch := evt keyCharacter asUnicode.
	ch = 0 ifTrue: [ch := evt keyValue].

	evt buttons = 64 ifTrue: [ch := ch \\ 32].  "command (alt) key pressed; map to a control key"
	(ch = 3) & (evt buttons = 0) ifTrue: [ch := 13].  "map enter key to cr"

	(evt buttons = 64) | (evt buttons = 16) ifTrue: [	"ctrl (or alt) is pressed"
		ch = 1 ifTrue: [self selectAll].		"ctrl-a"
		ch = 3 ifTrue: [self copySelection]. 	"ctrl-c"
		ch = 22 ifTrue: [self paste].			"ctrl-v"
		ch = 24 ifTrue: [self cutSelection].	"ctrl-x"
		ch = 26 ifTrue: [self undo]].			"ctrl-z"

	evt buttons = 8 ifTrue: [ "shift is pressed"
		ch = 28 ifTrue: [self moveCursorLeftAndSelect].  	"shift-left"
		ch = 29 ifTrue: [self moveCursorRightAndSelect].	"shift-right"
		ch = 1 ifTrue: [self moveCursorHomeAndSelect].	"home"
		ch = 4 ifTrue: [self moveCursorEndAndSelect]].	"end"

	evt buttons = 0 ifTrue: [
		ch = 1 ifTrue: [self moveCursorHome].	"home"
		ch = 4 ifTrue: [self moveCursorEnd].		"end"
		ch = 28 ifTrue: [self moveCursorLeft].	"left"
		ch = 29 ifTrue: [self moveCursorRight].	"right"
		blinkState := true].

	ch >= 32 ifTrue: [self insertCharacter: ch].

]

{ #category : #'event handling' }
StringFieldMorph >> keyboardFocusChange: amGettingFocus [
	"Set my color to show whether I have focus."

	(amGettingFocus and: [isKeyboardFocus not]) ifTrue: [
		lastContents := stringMorph contents].

	(isKeyboardFocus and: [amGettingFocus not]) ifTrue: [
		lastContents := nil.
		isNumeric ifTrue: [
			self contents: stringMorph contents asNumberNoError printString].
		acceptWhenFocusLost ifTrue: [self acceptEdits]].

	isKeyboardFocus := amGettingFocus.
	isKeyboardFocus ifTrue: [selectionStart := 0. selectionEnd := stringMorph contents size].
	self changed.

]

{ #category : #private }
StringFieldMorph >> leftSelection [

	^ selectionStart min: selectionEnd
]

{ #category : #'event handling' }
StringFieldMorph >> mouseDown: evt [

	dragStartIndex := self characterOffsetForXOffset: evt cursorPoint x.
	evt hand waitForClicksOrDrag: self event: evt.

]

{ #category : #'event handling' }
StringFieldMorph >> mouseMove: evt [

	| currIndex |
	dragStartIndex ifNil: [dragStartIndex := 0].
	currIndex := self characterOffsetForXOffset: evt cursorPoint x.
	selectionStart := currIndex min: dragStartIndex.
	selectionEnd := currIndex max: dragStartIndex.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorEnd [
	"Move the cursor (selectionStart) to the end of the current line."

	self moveCursorEndAndSelect.
	selectionEnd := selectionStart.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorEndAndSelect [
	"Move the cursor (selectionStart), and select contents, to the end of the current line."

	self recordUndoState.
	selectionStart := stringMorph contents size.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorHome [
	"Move the cursor (selectionStart) to the beginning of the current line."

	self moveCursorHomeAndSelect.
	selectionEnd := selectionStart.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorHomeAndSelect [
	"Move the cursor (selectionStart), and select contents, to the beginning of the current line."

	self recordUndoState.
	selectionStart := 0.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorLeft [
	"Move the cursor (selectionStart) left by one character."

	self moveCursorLeftAndSelect.
	selectionEnd := selectionStart.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorLeftAndSelect [
	"Move the cursor (selectionStart), and select, left by one character."

	self recordUndoState.
	selectionStart := (selectionStart - 1) max: 0.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorRight [
	"Move the cursor (selectionStart) right by one character."

	self moveCursorRightAndSelect.
	selectionEnd := selectionStart.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> moveCursorRightAndSelect [
	"Move the cursor (selectionStart), and select, right by one character."

	self recordUndoState.
	selectionStart := (selectionStart + 1) min: stringMorph contents size.
	self changed.

]

{ #category : #accessing }
StringFieldMorph >> passwordMode: aBoolean [

	stringMorph passwordMode: aBoolean.

]

{ #category : #'text editing' }
StringFieldMorph >> paste [
	"Paste the last cut or copy over the current selection."

	| strToInsert str newStr |
	strToInsert := ScratchTranslator unicodeClipboard.
	strToInsert isEmpty ifTrue: [^ self].

	self recordUndoState.
	str := stringMorph contents.
	newStr :=
		(str copyFrom: 1 to: self leftSelection),
		strToInsert,
		(str copyFrom: (self rightSelection + 1) to: str size).
	selectionEnd := selectionStart := self leftSelection + strToInsert size.
	stringMorph contentsClipped: newStr.
	self stringChanged.

]

{ #category : #'text editing' }
StringFieldMorph >> recordUndoState [
	"Remember the current contents and selection to allow undo."

	undoState := Array
		with: stringMorph contents
		with: selectionStart
		with: selectionEnd.

]

{ #category : #'text editing' }
StringFieldMorph >> removeSelection [
	"Cut the current selection."

	| str newStr |
	self recordUndoState.
	str := stringMorph contents.
	newStr := 
		(str copyFrom: 1 to: self leftSelection), 
		(str copyFrom: self rightSelection + 1 to: str size).
	stringMorph contentsClipped: newStr.
	selectionEnd := selectionStart := self leftSelection.
	self stringChanged.

]

{ #category : #private }
StringFieldMorph >> rightSelection [

	^ selectionStart max: selectionEnd
]

{ #category : #accessing }
StringFieldMorph >> savedContents [
	"If the user is editing, return the last contents before editing. Otherwise, return my contents."

	(isKeyboardFocus and: [lastContents notNil]) ifTrue: [^ lastContents].
	^ stringMorph contents

]

{ #category : #'text editing' }
StringFieldMorph >> selectAll [
	"Select my entire contents."

	self recordUndoState.
	selectionStart := 0.
	selectionEnd := stringMorph contents size.
	self changed.

]

{ #category : #'text editing' }
StringFieldMorph >> selectWordOrAll: index [

	| str wordStart wordEnd |
	str := stringMorph contents.
	(index < 1) | (index > str size) ifTrue: [^ self selectAll].  "off end, select all"
	(str at: index) isSeparator ifTrue: [^ self].  "on separator; do nothing"

	self recordUndoState.
	wordStart := index.
	[(wordStart >= 1) and: [(str at: wordStart) isSeparator not]]
		whileTrue: [wordStart := wordStart - 1].
	wordEnd := index.
	[(wordEnd < str size) and: [(str at: wordEnd) isSeparator not]]
		whileTrue: [wordEnd := wordEnd + 1].
	(str at: wordEnd) isSeparator ifTrue: [wordEnd := wordEnd - 1].

	selectionStart := wordStart.
	selectionEnd := wordEnd.
	self changed.

]

{ #category : #'event handling' }
StringFieldMorph >> startDrag: evt [
	"Do nothing if have keyboard focus. Otherwise, allow myself to be grabbed."

	| myBlock |
	isKeyboardFocus ifFalse: [
		myBlock := self meOrOwnerThatIsA: BlockMorph.
		myBlock
			ifNil: [super startDrag: evt]
			ifNotNil: [myBlock startDrag: evt]].

]

{ #category : #stepping }
StringFieldMorph >> step [

	isKeyboardFocus ifFalse: [^ self].
	blinkState ifNil: [blinkState := false].
	blinkState := blinkState not.
	selectionStart = selectionEnd ifTrue: [self changed].

]

{ #category : #stepping }
StringFieldMorph >> stepTime [

	^ 600

]

{ #category : #private }
StringFieldMorph >> stringChanged [
	"My string has changed. Resize myself if necessary and report the change."

	doResizing ifTrue: [
		stringMorph fitContents.
		self width: (stringMorph right - self left) + borderWidth + 3].
	(owner respondsTo: #fixArgLayout) ifTrue: [owner fixArgLayout].
	self changed.

]

{ #category : #accessing }
StringFieldMorph >> textColor: aColor [
	"Set the color of my text."

	stringMorph color: aColor.

]

{ #category : #'text editing' }
StringFieldMorph >> undo [
	"Swap the undo buffer witht the current state. Doing this a second time will undo the undo operation."

	| oldUndoState |
	oldUndoState := undoState.
	self recordUndoState.
	stringMorph contentsClipped: (oldUndoState at: 1).
	selectionStart := (oldUndoState at: 2).
	selectionEnd := (oldUndoState at: 3).
	self stringChanged.

]

{ #category : #initialization }
StringFieldMorph >> useNoFrame [

	frame := nil.
	borderWidth := 2.
	insetX := 2.
	heightPadding := 3.
	self font: stringMorph font.

]
