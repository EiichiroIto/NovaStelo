"
I manage language translations for Scratch. All of my code in in class methods.

"
Class {
	#name : #ScratchTranslator,
	#superclass : #Object,
	#classVars : [
		'RenderCenterOffsetCache',
		'RenderVerticalTrimCache'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #'Unicode rendering' }
ScratchTranslator class >> centerOffsetForButtonWithFont: aStrikeFont [
	"Answer the vertical offset above the center of a button for the given font. If the translator has provided a render hint string, return an offset that will center the first character of that string. Otherwise, return an offset that will center a lowercase 'x'."
	"[self centerOffsetForFont: (StrikeFont fontName: 'VerdanaBold' size: 10)] msecs"

	| f r vOffset |
	(RenderCenterOffsetCache includesKey: aStrikeFont) ifTrue: [
		^ RenderCenterOffsetCache at: aStrikeFont].

	f := (StringMorph contents: self renderHintString font: aStrikeFont) imageForm.
	r := f rectangleEnclosingPixelsNotOfColor: Color transparent.
	vOffset := r top + (r height // 2).  "offset of string morph above the centerline of a button to center the given letter"

	r height = 0 ifTrue: [vOffset := f height // 2].

	RenderCenterOffsetCache at: aStrikeFont put: vOffset.
	^ vOffset

]

{ #category : #'language translation' }
ScratchTranslator class >> ellipsesSuffix [
	"Answer an ellipses suffix (three periods). If the current language is RTL, then include the Unicode RTL mark after the colon."

	^ '...'
]

{ #category : #'class initialization' }
ScratchTranslator class >> initialize [
	"ScratchTranslator initialize"
	RenderCenterOffsetCache := Dictionary new.
	RenderVerticalTrimCache := Dictionary new
]

{ #category : #'import/export' }
ScratchTranslator class >> parseCommandSpec: aCommandSpec [
	"Answer an array of token strings containing my keywords and argument specs."
	"self parseCommandSpec: '%a of %m'"

	| result len i j spec |
	result := OrderedCollection new.
	spec := aCommandSpec.
	"(spec isKindOf: UTF8) ifTrue: [spec := String withAll: spec]."
	len := aCommandSpec size.

	i := 1.
	[(i < len) and: [(spec at: i) isSeparator]] whileTrue: [i := i + 1].
	[i <= len] whileTrue: [
		j := spec indexOf: $% startingAt: i.
		j > 0
			ifTrue: [
				j > i ifTrue: [result addLast: (spec copyFrom: i to: j - 1)].
				j < len
					ifTrue: [result addLast: (spec copyFrom: j to: j + 1)]
					ifFalse: [result addLast: '%'].
				i := j + 2]
			ifFalse: [
				result addLast: (spec copyFrom: i to: len).
				i := len + 1]].

	^ result asArray collect: [:s | s trimBoth]
]

{ #category : #'Unicode rendering' }
ScratchTranslator class >> renderHintString [
	"Answer a string to be used as an example button lable to adjust button size and label centering."

	"self renderHintString"

	"self showHintString"

	| stream |
	stream := WriteStream on: String new.
	#('New' 'Open' 'Save' 'Save As' 'Share!' 'Undo' 'Language' 'Extras' 'Want Help?' 'motion' 'looks' 'sound' 'pen' 'control' 'sensing' 'operators' 'variables')
		do: [ :each | stream nextPutAll: each ].
	^ stream contents
]

{ #category : #'Unicode rendering' }
ScratchTranslator class >> stringExtent: aString font: aStrikeFont [
	"Answer the extent of the given string using my font under the current font rendering system."
	"self stringExtent: 'Hello, Scratch!' font: (StrikeFont fontName: 'Verdana' size: 18)"

	^ (aStrikeFont widthOfString: aString asString) @ aStrikeFont height
]

{ #category : #'Unicode copy/paste' }
ScratchTranslator class >> unicodeClipboard [
	^ Clipboard clipboardText asString
]

{ #category : #'Unicode copy/paste' }
ScratchTranslator class >> unicodeClipboardPut: unicodeOrString [
	Clipboard clipboardText: unicodeOrString
]

{ #category : #'Unicode rendering' }
ScratchTranslator class >> verticalTrimForFont: aStrikeFont [
	"Answer the number of pixels to trim from a button labeled with the given font. Some rendering systems (e.g. Pango on Mac OS), add excess space below the lowest extent of a font in some languages. This method computes the actual space needed by from the render hints string. It is the translator's responsibility to provide a render hints string that includes the tallest character and the the character with the maximum descent."
	"[self verticalTrimForFont: (StrikeFont fontName: 'VerdanaBold' size: 10)] msecs"

	| f r extra |
	(RenderVerticalTrimCache includesKey: aStrikeFont) ifTrue: [
		^ RenderVerticalTrimCache at: aStrikeFont].

	f := (StringMorph contents: self renderHintString font: aStrikeFont) imageForm.
	r := f rectangleEnclosingPixelsNotOfColor: (f colorAt: 0@0).
	extra := (f height - r height - 2) max: 0.
	RenderVerticalTrimCache at: aStrikeFont put: extra.
	^ extra


]
