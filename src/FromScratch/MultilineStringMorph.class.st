"
An editable, multiple-line string in a single font with line wrapping.

Best for small amounts of text; for longer texts or texts with multiple type styles, see TextMorph.

My contents are stored in an array of strings ('lines') with all non-printing characters except cr's and spaces stripped out and tabs are replaced by a sequence of spaces.

Selection start and end points are represented as points where y holds the line number and x holds the index in the line of the character immediately after the selection point. The range of x for line L is thus 1 to (L size + 1), where the last selection point within the line is just before the line break.

Possible improvements:
  a. handle tabs correctly
  b. preserve non-printing characters (could be useful for editing files)

"
Class {
	#name : #MultilineStringMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'font',
		'textColor',
		'selectionColor',
		'lines',
		'isEditable',
		'centerText',
		'hasFocus',
		'selectionStart',
		'selectionEnd',
		'startLoc',
		'blinkState',
		'growWithText',
		'renderer',
		'suppressAntiAliasing',
		'renderWithSqueak',
		'inset',
		'lineHeight'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #'instance creation' }
MultilineStringMorph class >> includeInNewMorphMenu [

	^ true

]

{ #category : #'class initialization' }
MultilineStringMorph class >> initialize [
	"self initialize"

	CR := 13.

]

{ #category : #editing }
MultilineStringMorph >> backspaceChar [
	"If there is a selection, delete it. Otherwise delete the character just before the insertion point (i.e. backspace)."

	selectionStart = selectionEnd ifFalse: [^ self deleteSelection].

	selectionStart > 1 ifTrue: [
		selectionEnd := selectionStart.
		selectionStart := selectionStart - 1.
		self deleteSelection].

]

{ #category : #private }
MultilineStringMorph >> breakLine: lineIndex [
	"Break the given line by moving some of it down to the following line. Answer true if the line was broken, false otherwise. (This may cause the next line to become too long, thus propaging the need to word-wrap.)
	Try the following strategies, in order:
		a. break at an embedded if that leaves the line short enough
		b. break at the last space character before a word that hits the edge
		c. break a word that hits the edge if there is no space before that word"

	| line breakIndex i lineUpToBreak lineAfterBreak |
	line := lines at: lineIndex.
	breakIndex := nil.

	(self fits: line) ifTrue: [^ false].  "line already fits"

	(i := line indexOf: Character cr) ~= 0 ifTrue: [
		(self fits: (line copyFrom: 1 to: i - 1))
			ifTrue: [breakIndex := i]].

	breakIndex ifNil: [
		i := line indexOfSeparatorStartingAt: 1.
		[i <= line size] whileTrue: [
			(self fits: (line copyFrom: 1 to: i - 1))
				ifTrue: [
					breakIndex := i.
					i := line indexOfSeparatorStartingAt: i + 1]
				ifFalse: [i := line size + 1]]].

	breakIndex ifNil: [
		i := line size.
		[i > 1 and:
		 [(self fits: (line copyFrom: 1 to: i)) not]]
			whileTrue: [i := i - 1].
		breakIndex := i].

	lineUpToBreak := line copyFrom: 1 to: breakIndex.
	lineAfterBreak := line copyFrom: breakIndex + 1 to: line size.

	lineIndex = lines size ifTrue: [lines := lines copyWith: self emptyLine].  "make sure there is a next line"
	lines at: lineIndex put: lineUpToBreak.
	lines at: lineIndex + 1 put: lineAfterBreak, (lines at: lineIndex + 1).

	^ true

]

{ #category : #accessing }
MultilineStringMorph >> centerText: aBoolean [

	centerText := aBoolean.

]

{ #category : #private }
MultilineStringMorph >> charCount [

	| result |
	result := 0.
	lines do: [:s | result := result + s size].
	^ result

]

{ #category : #accessing }
MultilineStringMorph >> contents [
	"Answer my contents as a string."

	| sz result i |
	sz := 0.
	lines do: [:s | sz := sz + s size].
	result := String new: sz.
	i := 1.
	lines do: [:s |
		sz := s size.
		result replaceFrom: i to: i + sz - 1 with: s startingAt: 1.
		i := i + sz].
	^ result

]

{ #category : #accessing }
MultilineStringMorph >> contents: aStringOrText [
	"Set my contents to the given String or Text. Break into lines, emove non-printing characters, and replace tabs with sequences of spaces."

	lines := Array with: (self replaceTabs: aStringOrText).
	self lineWrapFrom: 1.

]

{ #category : #accessing }
MultilineStringMorph >> contents: aString font: aStrikeFont [
	"Set my contents to the given String, UTF8, or Text and set my font. Remove non-printing characters, and replace tabs with sequences of spaces, and word-wrap."

	lines := Array with: (self replaceTabs: aString).
	self font: aStrikeFont.

]

{ #category : #copying }
MultilineStringMorph >> copy [
	"Return a copy with a copy of my lines array."

	^ super copy setLines: lines copy

]

{ #category : #editing }
MultilineStringMorph >> copySelection [
	"Record the current selection in the clipboard."

	ScratchTranslator unicodeClipboardPut: self currentSelection.

]

{ #category : #editing }
MultilineStringMorph >> currentSelection [
	"Answer the current selection as a string."

	| line result start end startLineNum endLineNum |
	self ensureSelectionStartPrecedesEnd.
	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.
	startLineNum := start first.
	endLineNum := end first.

	startLineNum = endLineNum ifTrue: [
		line := lines at: startLineNum.
		^ line copyFrom: start second to: end second - 1].

	result := WriteStream on: (String new: 1000).

	line := lines at: startLineNum.
	result nextPutAll: (line copyFrom: start second to: line size).

	startLineNum + 1 to: endLineNum - 1 do: [:i |
		result nextPutAll: (lines at: i)].

	line := lines at: endLineNum.
	result nextPutAll: (line copyFrom: 1 to: end second - 1).

	^ result contents

]

{ #category : #'event handling' }
MultilineStringMorph >> cursorKey: evt [
	"Handle the given cursor control key."

	| ch pair lineNum line |
	ch := evt keyValue.

	selectionStart = selectionEnd ifTrue: [startLoc := selectionStart].

	ch = 28 ifTrue: [ "left"
		evt shiftPressed
			ifTrue: [
				selectionEnd > startLoc
					ifTrue: [selectionEnd := selectionEnd - 1]
					ifFalse: [selectionStart := selectionStart - 1]]
			ifFalse: [
				selectionStart := selectionEnd := selectionStart - 1]].

	ch = 29 ifTrue: [ "right"
		evt shiftPressed
			ifTrue: [
				selectionStart < startLoc
					ifTrue: [selectionStart := selectionStart + 1]
					ifFalse: [selectionEnd := selectionEnd + 1]]
			ifFalse: [
				selectionStart := selectionEnd := selectionStart + 1]].

	ch = 30 ifTrue: [  "up"
		pair := self lineAndIndexFor: selectionStart.	
		lineNum := (pair first - 1) max: 1.
		line := lines at: lineNum.
		selectionStart := (self startOfLine: lineNum) + (pair second min: line size).
		evt shiftPressed ifFalse: [selectionEnd := selectionStart]].

	ch = 31 ifTrue: [  "down"
		pair := self lineAndIndexFor: selectionEnd.	
		lineNum := (pair first + 1) min: lines size.
		line := lines at: lineNum.
		selectionEnd := (self startOfLine: lineNum) + (pair second min: line size).
		evt shiftPressed ifFalse: [selectionStart := selectionEnd]].

	blinkState := true.
	self ensureSelectionStartPrecedesEnd.
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> cutSelection [
	"Record the current selection in the clipboard, then delete it."

	selectionStart = selectionEnd ifTrue: [^ self].  "no selection"
	self copySelection.
	self deleteSelection.

]

{ #category : #editing }
MultilineStringMorph >> deleteNextChar [
	"If there is a selection, delete it. Otherwise delete the character just after the insertion point (i.e. delete)."

	selectionStart = selectionEnd ifFalse: [^ self deleteSelection].

	selectionEnd := selectionStart + 1.
	self deleteSelection.

]

{ #category : #editing }
MultilineStringMorph >> deleteSelection [
	"Delete the current selection."

	| start end startLineNum endLineNum s1 s2 mergedLine remainingLines |
	self ensureSelectionStartPrecedesEnd.
	selectionStart = selectionEnd ifTrue: [^ self].  "no selection"

	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.

	startLineNum := start first.
	endLineNum := end first.

	"merge the partial lines before and after the selection"
	s1 := lines at: startLineNum.
	s2 := lines at: endLineNum.
	mergedLine := (s1 copyFrom: 1 to: start second - 1), (s2 copyFrom: end second to: s2 size).

	"combine with following line, if any"
	endLineNum < lines size ifTrue: [
		mergedLine := mergedLine, (lines at: endLineNum + 1).
		remainingLines := lines copyFrom: endLineNum + 2 to: lines size].

	"update lines"
	lines := (lines copyFrom: 1 to: startLineNum - 1) copyWith: mergedLine.
	remainingLines ifNotNil: [lines := lines, remainingLines].

	selectionEnd := selectionStart.
	self lineWrapFrom: startLineNum.

]

{ #category : #'event handling' }
MultilineStringMorph >> doubleClick: evt [
	"Select a word."

	| lineAndIndex lineNum s index wordStart wordEnd lineStart |
	lines size = 0 ifTrue: [^ self].

	lineAndIndex := self lineAndIndexFor: (self indexForPoint: evt cursorPoint).
	lineNum := lineAndIndex first.
	s := lines at: lineNum.
	s size = 0 ifTrue: [^ self].  "empty line"

	index := lineAndIndex second.
	index > s size ifTrue: [index := s size].  "at end of line; try one char back"
	(s at: index) isSeparator ifTrue: [^ self].  "on separator; do nothing"

	wordStart := index.
	[(wordStart >= 1) and: [(s at: wordStart) isSeparator not]]
		whileTrue: [wordStart := wordStart - 1].
	wordEnd := index.
	[(wordEnd < s size) and: [(s at: wordEnd) isSeparator not]]
		whileTrue: [wordEnd := wordEnd + 1].
	(s at: wordEnd) isSeparator ifTrue: [wordEnd := wordEnd - 1].

	lineStart := self startOfLine: lineNum.
	selectionStart := lineStart + (wordStart + 1).
	selectionEnd := lineStart + (wordEnd + 1).
	startLoc := selectionStart.
	self changed.


]

{ #category : #drawing }
MultilineStringMorph >> drawCursor: charIndex line: lineIndex on: aCanvas [
	"Draw a cursor at the given character index on the given line."

	| line pair x p |
	line := lines at: lineIndex.
	line size = 0
		ifTrue: [ pair := #(0 0) ]
		ifFalse: [ pair := (renderer xRangesFor: line)
				at: (charIndex min: line size max: 1) ].
	x := charIndex > line size
		ifTrue: [ pair max ]
		ifFalse: [ pair min ].
	p := self offsetForLine: lineIndex.
	aCanvas
		fillRectangle: (p + (x @ 0) extent: 2 @ lineHeight)
		color: selectionColor
]

{ #category : #drawing }
MultilineStringMorph >> drawOn: aCanvas [

	| clipC |
	super drawOn: aCanvas.
	lineHeight ifNil: [self font: font].

	clipC := aCanvas
		copyOffset: bounds origin
		clipRect: (bounds insetBy: borderWidth).

	(hasFocus | owner isNil) ifTrue: [self drawSelectionOn: clipC].
	self drawTextOn: clipC.

]

{ #category : #drawing }
MultilineStringMorph >> drawSelectionFrom: startIndex to: endIndex line: lineIndex on: aCanvas [
	"Draw the selection for the given character range of the given line on the given canvas."

	| line xRanges p pair w |
	line := lines at: lineIndex.
	xRanges := renderer xRangesFor: line.
	p := self offsetForLine: lineIndex.
	startIndex to: endIndex - 1 do: [:i |
		pair := xRanges at: (i min: line size max: 1).
		w := (pair last - pair first) abs.
		aCanvas fillRectangle: ((p + (pair first@0)) extent: w@lineHeight) color: selectionColor].

]

{ #category : #drawing }
MultilineStringMorph >> drawSelectionLine: lineIndex on: aCanvas [
	"Draw the selection for the entire line with the given index on the given canvas."

	| p w |
	p := self offsetForLine: lineIndex.
	w := renderer stringWidth: (lines at: lineIndex).
	aCanvas fillRectangle: (p extent: w@lineHeight) color: selectionColor.

]

{ #category : #drawing }
MultilineStringMorph >> drawSelectionOn: aCanvas [
	"Draw my selection onto the given canvas. The canvas has been offset to my origin."

	| start end startLine endLine startIndex endIndex |
	lines size = 0 ifTrue: [^ self].

	self ensureSelectionStartPrecedesEnd.
	start := self lineAndIndexFor: selectionStart.
	end := self lineAndIndexFor: selectionEnd.
	startLine := start first.
	endLine := end first.
	startIndex := start last.
	endIndex := end last.

	startLine = endLine ifTrue: [
		startIndex = endIndex
			ifTrue: [
				blinkState ifTrue: [
					self drawCursor: startIndex line: startLine on: aCanvas]]
			ifFalse: [
				self drawSelectionFrom: startIndex to: endIndex line: startLine on: aCanvas].
		^ self].

	self drawSelectionFrom: startIndex to: (lines at: startLine) size + 1 line: startLine on: aCanvas.
	startLine + 1 to: endLine - 1 do: [:i | self drawSelectionLine: i on: aCanvas].
	self drawSelectionFrom: 1 to: endIndex line: endLine on: aCanvas.

]

{ #category : #drawing }
MultilineStringMorph >> drawString: aString at: aPoint on: aCanvas [
	| s |
	s := aString.
	suppressAntiAliasing ifNil: [ suppressAntiAliasing := false ].
	renderWithSqueak ifNil: [ renderWithSqueak := false ].
	aCanvas
		drawString: s
		in: (aPoint extent: 10000 @ 10000)
		font: font
		color: textColor
]

{ #category : #drawing }
MultilineStringMorph >> drawTextOn: aCanvas [
	| hInset x y |
	hInset := self insetX.
	y := self insetY.
	centerText ifNil: [ centerText := false ].
	lines
		do: [ :s | 
			x := hInset.
			centerText
				ifTrue: [ x := (self width - hInset - (renderer stringWidth: s)) // 2 ].
			self drawString: s at: x @ y on: aCanvas.
			y := y + lineHeight ]
]

{ #category : #private }
MultilineStringMorph >> emptyLine [

	^ ''
]

{ #category : #accessing }
MultilineStringMorph >> ensureOSFont [

	font isOSFont ifFalse: [
		self font: (StrikeFont osFontName: 'Helvetica Bold' size: font pointSize)].

]

{ #category : #private }
MultilineStringMorph >> ensureSelectionStartPrecedesEnd [
	"If selectionEnd is before selectionStart, swap them."

	| lastIndex tmp |
	lastIndex := self charCount + 1.
	selectionStart := selectionStart min: lastIndex max: 1.
	selectionEnd := selectionEnd min: lastIndex max: 1.
	selectionEnd < selectionStart ifTrue: [
		tmp := selectionEnd.
		selectionEnd := selectionStart.
		selectionStart := tmp].

]

{ #category : #geometry }
MultilineStringMorph >> extent: aPoint [

	| oldWidth |
	oldWidth := self width.
	super extent: (aPoint max: ((2 * borderWidth) + inset + 10)).
	self width ~= oldWidth ifTrue: [self wordWrapAll].


]

{ #category : #'object i/o' }
MultilineStringMorph >> fieldsVersion [

	^ 1

]

{ #category : #private }
MultilineStringMorph >> fitContents [
	"Set my extent to just fit around my contents."

	| w |
	w := 10.
	lines do: [:s | w := w max: (self widthWithContents: s)].
	super extent: (w@(lines size * lineHeight)) + (9@7).

]

{ #category : #private }
MultilineStringMorph >> fits: aString [
	"Answer true if the given string fits within my width."

	| i |
	i := aString indexOf: Character cr.
	((i > 0) and: [i < aString size]) ifTrue: [^ false].  "line includes an embedded CR; needs to be broken"
	aString size > 500 ifTrue: [^ false].
	^ (renderer stringWidth: aString) < (self width - (self insetX + borderWidth + 2))

]

{ #category : #accessing }
MultilineStringMorph >> font [

	^ font

]

{ #category : #accessing }
MultilineStringMorph >> font: aFont [

	font := aFont.
	renderer := StringMorph new font: aFont.
	lineHeight := renderer stringHeight: ScratchTranslator renderHintString, 'Ag'.
	self wordWrapAll.

]

{ #category : #accessing }
MultilineStringMorph >> growWithText: aBoolean [

	growWithText := aBoolean.

]

{ #category : #'event handling' }
MultilineStringMorph >> handlesKeyboard: evt [
	^ true
]

{ #category : #'event handling' }
MultilineStringMorph >> handlesMouseDown: evt [

	^ self isEditable

]

{ #category : #accessing }
MultilineStringMorph >> hasFocus [

	^ hasFocus

]

{ #category : #private }
MultilineStringMorph >> indexForPoint: aPoint [
	"Answer the character index for the given point in screen coordinates."
	"Note: This could be speeded up by doing a binary search for the character index, but it seems fast enough."

	| y lineNum x lineStart line xRanges pair |
	lines size = 0 ifTrue: [^ 1].

	y := aPoint y - (self top + self insetY).
	lineNum := ((y // lineHeight) + 1) max: 1.
	lineNum > lines size ifTrue: [^ (self startOfLine: lineNum) + 1].

	x := (aPoint x - self left - (self offsetForLine: lineNum) x) min: self width.
	x < 0 ifTrue: [  "start of a line"
		lineNum = 1 ifTrue: [^ 1] ifFalse: [^ self startOfLine: lineNum]].

	"search for character index"
	lineStart := self startOfLine: lineNum.
	line := lines at: lineNum.
	xRanges := renderer xRangesFor: line.
	1 to: line size do: [:i |
		pair := xRanges at: i.
		(x between: pair first and: pair second) ifTrue: [^ lineStart + i]].

	"end of line"
	lineNum = lines size
		ifTrue: [^ lineStart + line size + 1]
		ifFalse: [^ lineStart + line size].

]

{ #category : #'object i/o' }
MultilineStringMorph >> initFieldsFrom: anObjStream version: classVersion [

	| fontSpec |
	super initFieldsFrom: anObjStream version: classVersion.

	fontSpec := anObjStream nextField.
	self font: (StrikeFont fontName: fontSpec first size: fontSpec second).

	self initFieldsNamed: #(
		textColor
		selectionColor
		lines
	) from: anObjStream
]

{ #category : #initialization }
MultilineStringMorph >> initialize [

	super initialize.
	color := Color transparent.
	textColor := Color black.
	selectionColor := Color r: 0.353 g: 0.607 b: 0.788.
	lines := Array with: self emptyLine.
	isEditable := true.
	centerText := false.
	hasFocus := false.
	selectionStart := selectionEnd := 1.
	blinkState := true.
	growWithText := false.
	inset := 5@3.
	suppressAntiAliasing := false.
	renderWithSqueak := false.
	self font: TextStyle defaultFont.
	super extent: 90@25.

]

{ #category : #editing }
MultilineStringMorph >> insertString: aString [
	"Insert the given string at selectionStart."

	| start lineNum line prefix postfix |
	selectionStart = selectionEnd ifFalse: [self cutSelection].

	start := self lineAndIndexFor: selectionStart.
	lineNum := start first.
	line := lines at: lineNum.
	prefix := line copyFrom: 1 to: start second - 1.
	postfix := line copyFrom: start second to: line size.

	lines at: lineNum put: (prefix, (self replaceTabs: aString), postfix).

	selectionEnd := selectionStart := selectionStart + aString size.
	self lineWrapFrom: lineNum.


]

{ #category : #private }
MultilineStringMorph >> insetX [

	^ borderWidth + inset x

]

{ #category : #private }
MultilineStringMorph >> insetY [

	^ borderWidth + inset y

]

{ #category : #accessing }
MultilineStringMorph >> isEditable [

	isEditable ifNil: [isEditable := true].
	^ isEditable

]

{ #category : #accessing }
MultilineStringMorph >> isEditable: aBoolean [

	isEditable := aBoolean.

]

{ #category : #accessing }
MultilineStringMorph >> isEmpty [
	"Answer true if my contents is empty."

	^ lines size = 0 or: [lines size = 1 and: [lines first size = 0]]

]

{ #category : #'event handling' }
MultilineStringMorph >> keyStroke: evt [

	| ch m |
	ch := evt keyCharacter charCode.
	ch = 0 ifTrue: [ch := evt keyValue].

	evt commandKeyPressed ifTrue: [ch := ch \\ 32].	"map cmd/alt keys to control keys"
	(ch = 3) & (evt buttons = 0) ifTrue: [ch := 13].	"map enter key to cr"

	ch = 9 ifTrue: [  "tab"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m tabToNextField: evt]."
		^ self].

	ch = 27 ifTrue: [  "escape key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m escapeKeyPressed: evt]."
		^ self].

	evt controlKeyPressed | evt commandKeyPressed ifTrue: [	"ctrl (or alt) is pressed"
		ch = 1 ifTrue: [^ self selectAll].			"ctrl-a"
		ch = 3 ifTrue: [^ self copySelection].		"ctrl-c"
		ch = 22 ifTrue: [^ self paste].			"ctrl-v"
		ch = 24 ifTrue: [^ self cutSelection]].		"ctrl-x"

	evt shiftPressed ifTrue: [ "shift is pressed"
		ch = 1 ifTrue: [^ self moveCursorHomeAndSelect: true].		"home"
		ch = 4 ifTrue: [^ self moveCursorEndAndSelect: true].			"end"
		ch = 11 ifTrue: [^ self moveCursorPageUpAndSelect: true].		"page up"
		ch = 12 ifTrue: [^ self moveCursorPageDownAndSelect: true]].	"page down"

	evt buttons = 0 ifTrue: [ "no modifier keys"
		ch = 8 ifTrue: [^ self backspaceChar].						"backspace"
		ch = 127 ifTrue: [^ self deleteNextChar].						"delete"
		ch = 1 ifTrue: [^ self moveCursorHomeAndSelect: false].		"home"
		ch = 4 ifTrue: [^ self moveCursorEndAndSelect: false].		"end"
		ch = 11 ifTrue: [^ self moveCursorPageUpAndSelect: false].	"page up"
		ch = 12 ifTrue: [^ self moveCursorPageDownAndSelect: false]]."page down"

	(ch between: 28 and: 31) ifTrue: [^ self cursorKey: evt].  "arrow keys"

	"not a special character--just insert it"
	self insertString: evt keyCharacter asString
]

{ #category : #'event handling' }
MultilineStringMorph >> keyboardFocusChange: aBoolean [

	hasFocus = aBoolean ifTrue: [^ self].

	self changed.
	aBoolean
		ifTrue: [
			self selectAll.
			self startStepping]
		ifFalse: [
			self stopStepping].

	hasFocus := aBoolean.

]

{ #category : #private }
MultilineStringMorph >> lineAndIndexFor: charPos [
	"Answer an Array containing the line number and the character index within that line for the given character position in my text."

	| count line |
	charPos < 1 ifTrue: [^ Array with: 1 with: 1].

	count := 0.
	1 to: lines size do: [:lineNum |
		line := lines at: lineNum.
		(charPos between: count + 1 and: count + line size)
			ifTrue: [^ Array with: lineNum with: charPos - count].
		count := count + line size].
	
	^ Array with: lines size with: ((lines at: lines size) size + 1)

]

{ #category : #private }
MultilineStringMorph >> lineWrapFrom: startLine [
	"Fix line wrapping starting at the given line."

	| lineIndex newH |
	lineIndex := startLine.
	[lineIndex <= lines size and: [self breakLine: lineIndex]]
		whileTrue: [lineIndex := lineIndex + 1].

	"if the last line ends with a CR, add a blank line after it"
	(lines last size > 0 and: [lines last last = Character cr])
		ifTrue: [lines := lines copyWith: self emptyLine].

	growWithText ifTrue: [
		newH := ((lines size max: 1) * lineHeight) + (2 * self insetY).
		bounds height ~= newH ifTrue: [self height: newH]].

	self changed.

]

{ #category : #accessing }
MultilineStringMorph >> lines [

	^ lines

]

{ #category : #'event handling' }
MultilineStringMorph >> mouseDown: evt [

	self isEditable ifFalse: [^ self].
	evt hand newKeyboardFocus: self.
	startLoc := self indexForPoint: evt cursorPoint.
	selectionStart := selectionEnd := startLoc.
	evt hand waitForClicksOrDrag: self event: evt.
	self changed.

]

{ #category : #'event handling' }
MultilineStringMorph >> mouseMove: evt [

	| newLoc |
	self isEditable ifFalse: [^ self].
	newLoc := self indexForPoint: evt cursorPoint.
	startLoc ifNil: [startLoc := newLoc].
	newLoc < startLoc
		ifTrue: [selectionStart := newLoc. selectionEnd := startLoc]
		ifFalse: [selectionStart := startLoc. selectionEnd := newLoc].
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> moveCursorContentsEnd [
	"Position the cursor at the end of my contents (i.e. at very end, not the end of the current line)."

	selectionStart := selectionEnd := self charCount + 1.
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> moveCursorEndAndSelect: selectFlag [

	| lineNum line |
	lineNum := (self lineAndIndexFor: selectionStart) first.
	line := lines at: lineNum.
	selectionEnd := (self startOfLine: lineNum) + line size.
	lineNum = lines size ifTrue: [selectionEnd := selectionEnd + 1].
	selectFlag ifFalse: [selectionStart := selectionEnd].
	startLoc := selectionStart.
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> moveCursorHomeAndSelect: selectFlag [

	selectionStart := (self startOfLine: (self lineAndIndexFor: selectionStart) first) + 1.
	selectFlag ifFalse: [selectionEnd := selectionStart].
	startLoc := selectionEnd.
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> moveCursorPageDownAndSelect: selectFlag [

	| i lastLine |
	i := (self lineAndIndexFor: selectionStart) second.
	lastLine := lines at: lines size.
	selectionEnd := (self startOfLine: lines size) + (i min: lastLine size + 1).
	selectFlag ifFalse: [selectionStart := selectionEnd].
	startLoc := selectionStart.
	self changed.

]

{ #category : #editing }
MultilineStringMorph >> moveCursorPageUpAndSelect: selectFlag [

	| i |
	i := (self lineAndIndexFor: selectionStart) second.
	selectionStart := i min: (lines at: 1) size max: 1.
	selectFlag ifFalse: [selectionEnd := selectionStart].
	startLoc := selectionEnd.
	self changed.

]

{ #category : #private }
MultilineStringMorph >> offsetForLine: lineIndex [
	"Answer the offset from my origin to the start of the line with the given index, taking RTL into account."

	| top |
	top := self insetY + (lineHeight * (lineIndex - 1)).
	^ self insetX @ top
]

{ #category : #editing }
MultilineStringMorph >> paste [
	"Paste the last cut or copied text over the current selection."

	| s |
	s := ScratchTranslator unicodeClipboard.
	s isEmpty
		ifTrue: [ ^ self ].
	self deleteSelection.
	self insertString: s
]

{ #category : #accessing }
MultilineStringMorph >> renderWithSqueak: aBoolean [
	"If true, then if my font is a StrikeFont render my contents using that font and the Squeak rendering system. Note that it will only be able to render MacRoman text. This flag allows the text layer from old costumes to be edited in it's original Squeak font."

	renderWithSqueak := aBoolean.

]

{ #category : #private }
MultilineStringMorph >> replaceTabs: aString [
	"Answer a copy of the given UTF32 with each tab replaced by four spaces and all non-printing characters except spaces and line ends removed. Covert LF's to CR's."

	| s tab lf cr space result |
	s := aString.
	tab := Character tab.
	lf := Character lf.
	cr := Character cr.
	space := Character space.
	result := WriteStream on: (String new: s size * 4).
	s do: [:ch |
		ch < space
			ifTrue: [ "non-printing"
				ch = tab ifTrue: [result nextPutAll: '    '].
				(ch = cr) | (ch = lf) ifTrue: [result nextPut: cr]]
			ifFalse: [
				result nextPut: ch]].

	^ result contents

]

{ #category : #editing }
MultilineStringMorph >> selectAll [
	"Select all of my text."

	selectionStart := 1.
	selectionEnd := self charCount + 1.
	self changed.

]

{ #category : #accessing }
MultilineStringMorph >> selectionColor: aColor [

	selectionColor := aColor.

]

{ #category : #private }
MultilineStringMorph >> setLines: anArray [
	"Private! Used when copying."

	lines := anArray.

]

{ #category : #'event handling' }
MultilineStringMorph >> startDrag: evt [
	"Do nothing."

]

{ #category : #private }
MultilineStringMorph >> startOfLine: lineIndex [
	"Answer the character index for the start of the line with the given index. If the line is out of range treat it as if it were the first or last line."

	| result |
	lineIndex < 1 ifTrue: [^ 1].

	result := 0.
	1 to: ((lineIndex - 1) min: lines size) do: [:i | result := result + (lines at: i) size].
	^ result

]

{ #category : #stepping }
MultilineStringMorph >> step [

	blinkState := blinkState not.
	selectionStart = selectionEnd ifTrue: [self changed].

]

{ #category : #stepping }
MultilineStringMorph >> stepTime [

	^ 600

]

{ #category : #'object i/o' }
MultilineStringMorph >> storeFieldsOn: anObjStream [

	super storeFieldsOn: anObjStream.

	anObjStream putField: {font familyName. font pointSize}.  "font spec"
	self storeFieldsNamed: #(
		textColor
		selectionColor
		lines
	) on: anObjStream.


]

{ #category : #private }
MultilineStringMorph >> stringWidth: aString [
	"Answer the width of the givne string."

	^ renderer stringWidth: aString

]

{ #category : #accessing }
MultilineStringMorph >> suppressAntiAliasing: aBoolean [

	suppressAntiAliasing := aBoolean.

]

{ #category : #accessing }
MultilineStringMorph >> textColor [

	^ textColor

]

{ #category : #accessing }
MultilineStringMorph >> textColor: aColor [

	textColor := aColor.

]

{ #category : #stepping }
MultilineStringMorph >> wantsSteps [

	^ hasFocus

]

{ #category : #private }
MultilineStringMorph >> widthWithContents: aString [
	"Answer how wide I would need to be to fit the given string on a single line."

	^ (renderer stringWidth: aString) + self insetX + borderWidth + 3


]

{ #category : #private }
MultilineStringMorph >> wordWrapAll [
	"Redo my wordwrap."

	((lines size > 1) or: [lines first size > 0]) ifTrue: [
		self contents: self contents].

]

{ #category : #'event handling' }
MultilineStringMorph >> wouldAcceptKeyboardFocus [

	^ self isEditable

]
