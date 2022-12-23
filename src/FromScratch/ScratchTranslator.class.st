Class {
	#name : #ScratchTranslator,
	#superclass : #Object,
	#instVars : [
		'fonts',
		'texts',
		'locale'
	],
	#classVars : [
		'Current',
		'RenderCenterOffsetCache',
		'RenderVerticalTrimCache'
	],
	#category : #'FromScratch-Translation'
}

{ #category : #utilities }
ScratchTranslator class >> addBlockDefs: aCollection to: aSet [

	aCollection do: [ :each | 
		aSet addAll: each blockCategories.
		each blocks do: [ :each2 | 
			each2 = '-' ifFalse: [ 
				each2 isString
					ifTrue: [ aSet add: each2 ]
					ifFalse: [ 
						(each2 isArray and: [ each2 size > 2 ]) ifTrue: [ 
							aSet add: each2 first ] ] ] ] ]
]

{ #category : #utilities }
ScratchTranslator class >> addLocalizedTextsTo: aSet [

	| list list3 |
	list := #localized senders.
	list do: [ :each | 
		list3 := each sendNodes select: [ :each2 | 
			         each2 selector = #localized and: [ 
				         each2 receiver isLiteralNode and: [ 
					         each2 receiver isLiteralArray not ] ] ].
		list3 := list3 collect: [ :each2 | each2 receiver value ].
		aSet addAll: list3 ]
]

{ #category : #accessing }
ScratchTranslator class >> argFont [
	^ self fontAt: #Arg
]

{ #category : #accessing }
ScratchTranslator class >> availableLocaleFiles [

	| fr |
	fr := 'locale' asFileReference.
	fr isDirectory ifFalse: [ ^ #(  ) ].
	^ fr filesMatching: '*.po'
]

{ #category : #accessing }
ScratchTranslator class >> availableLocales [
	^ ({'en'} , (self availableLocaleFiles collect: [ :f | f base ]))
		sorted
]

{ #category : #accessing }
ScratchTranslator class >> buttonFont [
	^ self fontAt: #Button
]

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

{ #category : #accessing }
ScratchTranslator class >> current [
	^ Current ifNil: [ Current := self defaultTranslator ]
]

{ #category : #accessing }
ScratchTranslator class >> current: aTranslator [
	Current := aTranslator
]

{ #category : #private }
ScratchTranslator class >> defaultTranslator [
	| obj |
	obj := self new.
	obj fontAt: #Arg put: StandardFonts defaultFont.
	obj fontAt: #Button put: StandardFonts buttonFont.
	obj fontAt: #Label put: StandardFonts listFont.
	^ obj
]

{ #category : #'language translation' }
ScratchTranslator class >> ellipsesSuffix [
	"Answer an ellipses suffix (three periods). If the current language is RTL, then include the Unicode RTL mark after the colon."

	^ '...'
]

{ #category : #private }
ScratchTranslator class >> fontAt: aSymbol [
	^ self current fontAt: aSymbol
]

{ #category : #utilities }
ScratchTranslator class >> generatePOTFile [

	"ScratchTranslator generatePOTFile"

	| list strings |
	strings := Set new.
	list := ScratchScript allSubclasses collect: [ :each | each new ].
	self addBlockDefs: list to: strings.
	self addLocalizedTextsTo: strings.
	self writePOT: strings fileNamed: 'app.pot'
]

{ #category : #'class initialization' }
ScratchTranslator class >> initialize [
	"ScratchTranslator initialize"
	RenderCenterOffsetCache := Dictionary new.
	RenderVerticalTrimCache := Dictionary new
]

{ #category : #accessing }
ScratchTranslator class >> labelFont [
	^ self fontAt: #Label
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

{ #category : #accessing }
ScratchTranslator class >> setLocale: aString [
	| fr tr |
	aString ifEmpty: [ ^ false ].
	fr := ('locale/' , aString , '.po') asFileReference.
	fr isFile
		ifFalse: [ self current: nil.
			GraphicFontSettings setFontsToStyleNamed: #medium.
			^ aString = 'en' ].
	tr := self new.
	tr readFrom: fr readStream.
	tr setupFonts.
	self current: tr.
	^ true
]

{ #category : #'Unicode rendering' }
ScratchTranslator class >> stringExtent: aString font: aStrikeFont [
	"Answer the extent of the given string using my font under the current font rendering system."
	"self stringExtent: 'Hello, Scratch!' font: (StrikeFont fontName: 'Verdana' size: 18)"

	^ (aStrikeFont widthOfString: aString asString) @ aStrikeFont height
]

{ #category : #accessing }
ScratchTranslator class >> translationFor: aString [
	^ self current textAt: aString
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

{ #category : #utilities }
ScratchTranslator class >> writePOT: aCollection fileNamed: aString [

	| file |
	file := FileSystem workingDirectory / aString.
	file isFile ifTrue: [ file delete ].
	file writeStreamDo: [ :stream | 
		aCollection asSortedCollection do: [ :each | 
			stream
				nextPutAll: 'msgid "';
				nextPutAll: each;
				nextPut: $";
				nextPutAll: String crlf;
				nextPutAll: 'msgstr ""';
				nextPutAll: String crlf;
				nextPutAll: String crlf ] ]
]

{ #category : #private }
ScratchTranslator >> addMsgId: aString1 msgStr: aString2 [
	| key value |
	key := self unquoteString: aString1.
	key isEmpty
		ifTrue: [ ^ self ].
	value := self unquoteString: aString2.
	self textAt: key put: value
]

{ #category : #private }
ScratchTranslator >> defaultFont [
	^ StrikeFont familyName: 'Verdana' size: 10
]

{ #category : #accessing }
ScratchTranslator >> fontAt: aString [
	^ fonts at: aString ifAbsent: [ self defaultFont ]
]

{ #category : #accessing }
ScratchTranslator >> fontAt: aString put: aFont [
	fonts at: aString put: aFont
]

{ #category : #private }
ScratchTranslator >> fontFromString: aString [
	| ret family point |
	(aString includes: $:)
		ifFalse: [ ^ nil ].
	ret := aString splitOn: $:.
	family := ret first trimBoth.
	point := ret second asNumberNoError max: 5.
	^ LogicalFont familyName: family pointSize: point
]

{ #category : #accessing }
ScratchTranslator >> fonts [
	^ fonts
]

{ #category : #initialization }
ScratchTranslator >> initialize [
	fonts := Dictionary new.
	texts := Dictionary new
]

{ #category : #accessing }
ScratchTranslator >> readFrom: aStream [
	| line key value |
	key := value := ''.
	[ aStream atEnd ]
		whileFalse: [ line := aStream nextLine.
			(line beginsWith: 'msgid')
				ifTrue: [ key := line copyFrom: 7 to: line size ].
			(line beginsWith: 'msgstr')
				ifTrue: [ value := line copyFrom: 8 to: line size.
					self addMsgId: key msgStr: value.
					key := '' ] ]
]

{ #category : #private }
ScratchTranslator >> setupFonts [
	| str |
	str := self textAt: 'ArgFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | self fontAt: 'Arg' put: font ].
	str := self textAt: 'ButtonFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			self fontAt: 'Button' put: font.
			StandardFonts buttonFont: font ].
	str := self textAt: 'LabelFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			self fontAt: 'Label' put: font.
			StandardFonts
				listFont: font;
				menuFont: font;
				defaultFont: font ].
	str := self textAt: 'CodeFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | StandardFonts codeFont: font ].
	str := self textAt: 'TitleFont'.
	(self fontFromString: str)
		ifNotNil: [ :font | 
			StandardFonts
				windowTitleFont: font;
				balloonFont: font ]
]

{ #category : #accessing }
ScratchTranslator >> textAt: aString [
	^ texts at: aString ifAbsent: [ aString ]
]

{ #category : #accessing }
ScratchTranslator >> textAt: aString1 put: aString2 [
	texts at: aString1 put: aString2
]

{ #category : #accessing }
ScratchTranslator >> texts [
	^ texts
]

{ #category : #private }
ScratchTranslator >> unquoteString: aString [
	| tmp |
	tmp := aString trimBoth.
	tmp ifEmpty: [ ^ tmp ].
	tmp first = $"
		ifTrue: [ tmp := tmp allButFirst ].
	tmp ifEmpty: [ ^ tmp ].
	tmp last = $"
		ifTrue: [ tmp := tmp allButLast ].
	^ tmp
]
