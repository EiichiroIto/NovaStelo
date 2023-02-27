"
A ScratchConsoleMorphTest is a test class for testing the behavior of ScratchConsoleMorph
"
Class {
	#name : #ScratchConsoleMorphTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchConsoleMorphTest >> newMorph [

	^ ScratchConsoleMorph new
]

{ #category : #test }
ScratchConsoleMorphTest >> testCharExtent [

	| m |
	m := self newMorph.
	self assert: m charExtent isPoint.
	m charExtent: 5 @ 6.
	self assert: m charExtent equals: 5 @ 6
]

{ #category : #test }
ScratchConsoleMorphTest >> testCharacterAt [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m screen at: 1 put: 'abcd'.
	m screen at: 2 put: 'efgh'.
	m screen at: 3 put: 'ijkl'.
	self assert: (m characterAt: 0 @ 0) equals: $a.
	self assert: (m characterAt: 3 @ 0) equals: $d.
	self assert: (m characterAt: 1 @ 1) equals: $f.
	self assert: (m characterAt: 2 @ 1) equals: $g.
	self assert: (m characterAt: 0 @ 2) equals: $i.
	self assert: (m characterAt: 3 @ 2) equals: $l.
	self assert: (m characterAt: 4 @ 0) equals: Character space.
	self assert: (m characterAt: -1 @ 0) equals: Character space.
	self assert: (m characterAt: 0 @ -1) equals: Character space.
	self assert: (m characterAt: 0 @ 3) equals: Character space
]

{ #category : #test }
ScratchConsoleMorphTest >> testCharacterAtPut [

	| m |
	m := self newMorph.
	m characterAt: 0 @ 0 put: $a.
	self assert: m screen first equals: 'a'.
	m characterAt: 1 @ 1 put: $b.
	self assert: m screen second equals: ' b'.
	m characterAt: 3 @ 2 put: $c.
	self assert: m screen third equals: '   c'.
	m characterAt: 4 @ 2 put: $d.
	self assert: m screen third equals: '   cd'.
	m characterAt: 2 @ 2 put: $e.
	self assert: m screen third equals: '  ecd'
]

{ #category : #test }
ScratchConsoleMorphTest >> testClearScreen [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m screen at: 1 put: 'abcd'.
	m screen at: 2 put: 'efgh'.
	m screen at: 3 put: 'hijk'.
	self deny: m screen first isEmpty.
	self deny: m screen second isEmpty.
	self deny: m screen third isEmpty.
	m clearScreen.
	self assert: m screen first isEmpty.
	self assert: m screen second isEmpty.
	self assert: m screen third isEmpty
]

{ #category : #test }
ScratchConsoleMorphTest >> testCurrentLine [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m screen at: 1 put: 'abcd'.
	m screen at: 2 put: 'efgh'.
	m screen at: 3 put: 'ijkl'.
	self assert: m currentLine equals: 'abcd'.
	m cursor: 1 @ 1.
	self assert: m currentLine equals: 'efgh'.
	m cursor: 3 @ 2.
	self assert: m currentLine equals: 'ijkl'.
	m currentLine: 'aaaa'.
	self assert: m currentLine equals: 'aaaa'
]

{ #category : #test }
ScratchConsoleMorphTest >> testCursor [

	| m |
	m := self newMorph.
	self assert: m cursor isPoint.
	m cursor: 5 @ 6.
	self assert: m cursor equals: 5 @ 6
]

{ #category : #test }
ScratchConsoleMorphTest >> testDefaultFont [

	self newMorph defaultFont isFontSet
]

{ #category : #test }
ScratchConsoleMorphTest >> testDefaultScreenSize [

	self assert: self newMorph defaultScreenSize isPoint
]

{ #category : #test }
ScratchConsoleMorphTest >> testFont [

	| m f |
	m := self newMorph.
	self assert: m font notNil.
	f := StandardFonts balloonFont.
	m font: f.
	self assert: m font identicalTo: f
]

{ #category : #test }
ScratchConsoleMorphTest >> testGoto [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	self assert: m cursor equals: 0 @ 0.
	m goto: 1 @ 2.
	self assert: m cursor equals: 1 @ 2.
	m goto: 5 @ 10.
	self assert: m cursor equals: 0 @ 0
]

{ #category : #test }
ScratchConsoleMorphTest >> testNewLine [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m screen at: 1 put: 'abcd'.
	m screen at: 2 put: 'efgh'.
	m screen at: 3 put: 'ijkl'.
	m cursor: 2 @ 0.
	m newLine.
	self assert: m screen first equals: 'ab'.
	self assert: m screen second equals: 'efgh'.
	m newLine.
	self assert: m screen second equals: ''.
	m cursor: 3 @ 2.
	m newLine.
	self assert: m screen first equals: ''.
	self assert: m screen second equals: 'ijk'.
	self assert: m screen third equals: ''
]

{ #category : #test }
ScratchConsoleMorphTest >> testPut [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m cursor: 1 @ 0.
	m put: 'abcde
fg'.
	self assert: m screen first equals: ' abc'.
	self assert: m screen second equals: 'de'.
	self assert: m screen third equals: 'fg'.
	m put: 'ab'.
	self assert: m screen first equals: 'de'.
	self assert: m screen second equals: 'fgab'.
	self assert: m screen third equals: ''
]

{ #category : #test }
ScratchConsoleMorphTest >> testPutChar [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m cursor: 1 @ 0.
	m putChar: $a.
	m putChar: $b.
	m putChar: $c.
	m putChar: $d.
	m putChar: $e.
	self assert: m screen first equals: ' abc'.
	self assert: m screen second equals: 'de'.
	self assert: m screen third equals: ''.
	m cursor: 2 @ 2.
	m putChar: $A.
	m putChar: $B.
	m putChar: $C.
	self assert: m screen first equals: 'de'.
	self assert: m screen second equals: '  AB'.
	self assert: m screen third equals: 'C'
]

{ #category : #test }
ScratchConsoleMorphTest >> testScreen [

	| m a |
	m := self newMorph.
	self assert: m screen isArray.
	a := Array with: 'abc' with: 'def'.
	m screen: a.
	self assert: m screen identicalTo: a
]

{ #category : #test }
ScratchConsoleMorphTest >> testScreenSize [

	| m |
	m := self newMorph.
	self assert: m screenSize equals: m defaultScreenSize.
	m screenSize: 10 @ 20.
	self assert: m screenSize equals: 10 @ 20
]

{ #category : #test }
ScratchConsoleMorphTest >> testScroll [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	m screen at: 1 put: 'abcd'.
	m screen at: 2 put: 'efgh'.
	m screen at: 3 put: 'ijkl'.
	m scroll: 0.
	self assert: (m screen at: 1) equals: 'abcd'.
	self assert: (m screen at: 2) equals: 'efgh'.
	self assert: (m screen at: 3) equals: 'ijkl'.
	m scroll: 1.
	self assert: (m screen at: 1) equals: 'efgh'.
	self assert: (m screen at: 2) equals: 'ijkl'.
	self assert: (m screen at: 3) equals: ''.
	m scroll: 2.
	self assert: (m screen at: 1) equals: ''.
	self assert: (m screen at: 2) equals: ''.
	self assert: (m screen at: 3) equals: ''.
	
]

{ #category : #test }
ScratchConsoleMorphTest >> testTextColor [

	self newMorph textColor isColor
]

{ #category : #test }
ScratchConsoleMorphTest >> testUpdateCharExtent [

	| m |
	m := self newMorph.
	m charExtent: nil.
	self assert: m charExtent isNil.
	m updateCharExtent.
	self assert: m charExtent isPoint
]

{ #category : #test }
ScratchConsoleMorphTest >> testWithinScreen [

	| m |
	m := self newMorph.
	m screenSize: 4 @ 3.
	self assert: (m withinScreen: 0 @ 0).
	self assert: (m withinScreen: 3 @ 0).
	self assert: (m withinScreen: 0 @ 1).
	self assert: (m withinScreen: 3 @ 1).
	self assert: (m withinScreen: 0 @ 2).
	self assert: (m withinScreen: 3 @ 2).
	self deny: (m withinScreen: 0 @ -1).
	self deny: (m withinScreen: -1 @ 0).
	self deny: (m withinScreen: 4 @ 0).
	self deny: (m withinScreen: -1 @ 1).
	self deny: (m withinScreen: 4 @ 1).
	self deny: (m withinScreen: -1 @ 2).
	self deny: (m withinScreen: 4 @ 2)
]
