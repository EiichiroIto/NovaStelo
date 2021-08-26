Class {
	#name : #ScratchTheme,
	#superclass : #Object,
	#instVars : [
		'colors',
		'forms'
	],
	#classVars : [
		'CurrentTheme',
		'ThemesURL'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #colors }
ScratchTheme class >> blockArgColor [
	^ self colorAt: #blockArgColor
]

{ #category : #accessing }
ScratchTheme class >> buttonLabel: aString selector: aSymbolOrNil [
	"Answer a big button with the given label."

	| button |
	button := ResizableToggleButton2 new
		offForm: (self formAt: #btn) onForm: (self formAt: #btnPressed);
		label: aString font: ScratchTranslator buttonFont;
		actionSelector: aSymbolOrNil;
		labelColorOn: self labelOnColor
			labelColorOff: self labelOffColor
			labelColorOver: self labelOnColor.
	^ button
]

{ #category : #accessing }
ScratchTheme class >> colorAt: aSymbol [
	^ self current colorAt: aSymbol
]

{ #category : #accessing }
ScratchTheme class >> current [
	^ CurrentTheme ifNil: [ self error: 'No themes!' ]
]

{ #category : #accessing }
ScratchTheme class >> current: aTheme [
	CurrentTheme := aTheme
]

{ #category : #colors }
ScratchTheme class >> dialogBoxTextColor [
	^ self colorAt: #dialogBoxTextColor
]

{ #category : #accessing }
ScratchTheme class >> formAt: aSymbolOrString [
	^ self formAt: aSymbolOrString ifAbsent: [ self error ]
]

{ #category : #accessing }
ScratchTheme class >> formAt: aString ifAbsent: aBlock [
	^ self current formAt: aString ifAbsent: aBlock
]

{ #category : #private }
ScratchTheme class >> getThemes [
	| response ref url |
	url := self themesURL.
	url ifNil: [ self error: 'ThemesURL is not set!' ].
	response := ZnEasy get: url.
	response isSuccess
		ifFalse: [ self error: 'Could not get Themes.zip!' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.
]

{ #category : #colors }
ScratchTheme class >> labelOffColor [
	^ self colorAt: #labelOffColor
]

{ #category : #colors }
ScratchTheme class >> labelOnColor [
	^ self colorAt: #labelOnColor
]

{ #category : #colors }
ScratchTheme class >> listBlockColor [
	^ self colorAt: #listBlockColor
]

{ #category : #'instance creation' }
ScratchTheme class >> newThemeNamed: aString [
	| obj |
	obj := self new.
	self readForms: aString to: obj.
	^ obj
]

{ #category : #colors }
ScratchTheme class >> palettePaneColor [
	^ self colorAt: #palettePaneColor
]

{ #category : #colors }
ScratchTheme class >> plotterFrameColor [
	^ self colorAt: #plotterFrameColor
]

{ #category : #colors }
ScratchTheme class >> plotterPaneColor [
	^ self colorAt: #plotterPaneColor
]

{ #category : #private }
ScratchTheme class >> readForms: aString to: aTheme [
	| base dir |
	base := 'Themes' asFileReference.
	base exists
		ifFalse: [ self error: 'Themes folder not found!' ].
	dir := base / 'common'.
	dir isDirectory
		ifFalse: [ self error: 'common folder not found!' ].
	aTheme readFormsFrom: dir.
	dir := base / aString.
	dir isDirectory
		ifFalse: [ self error: 'That folder not found: ' , aString ].
	aTheme readFormsFrom: dir
]

{ #category : #colors }
ScratchTheme class >> scriptsPaneColor [
	^ self colorAt: #scriptsPaneColor
]

{ #category : #private }
ScratchTheme class >> setupThemeColor: aTheme [
	| systemTheme |
	systemTheme := Smalltalk ui theme.
	aTheme
		colorAt: #blockArgColor put: systemTheme backgroundColor;
		colorAt: #dialogBoxTextColor put: systemTheme textColor;
		colorAt: #labelOnColor put: Color black;
		colorAt: #labelOffColor put: Color white;
		colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068);
		colorAt: #plotterFrameColor put: systemTheme windowShadowColor;
		colorAt: #plotterPaneColor put: systemTheme backgroundColor;
		colorAt: #palettePaneColor put: systemTheme windowColor;
		colorAt: #scriptsPaneColor put: systemTheme windowColor;
		colorAt: #textColor put: systemTheme textColor;
		colorAt: #textSelectionColor put: systemTheme selectionColor
]

{ #category : #private }
ScratchTheme class >> setupThemeNamed: aString [
	| obj |
	self themeIsInstalled
		ifFalse: [ self getThemes ].
	obj := self newThemeNamed: aString.
	self setupThemeColor: obj.
	self current: obj
]

{ #category : #colors }
ScratchTheme class >> textColor [
	^ self colorAt: #textColor
]

{ #category : #colors }
ScratchTheme class >> textSelectionColor [
	^ self colorAt: #textSelectionColor
]

{ #category : #testing }
ScratchTheme class >> themeIsInstalled [
	^ 'Themes' asFileReference in: [ :ref | ref isDirectory and: [ ref entries notEmpty ] ]
]

{ #category : #accessing }
ScratchTheme class >> themesURL [
	^ ThemesURL
]

{ #category : #accessing }
ScratchTheme class >> themesURL: aString [
	ThemesURL := aString
]

{ #category : #colors }
ScratchTheme class >> variableBlockColor [
	^ Color h: 25 s: 0.88 v: 0.95
]

{ #category : #accessing }
ScratchTheme >> colorAt: aSymbol [
	^ colors at: aSymbol asSymbol
]

{ #category : #accessing }
ScratchTheme >> colorAt: aSymbol put: aColor [
	colors at: aSymbol asSymbol put: aColor
]

{ #category : #private }
ScratchTheme >> colors [
	^ colors copy
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol [
	^ forms at: aSymbol asSymbol
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol ifAbsent: aBlock [
	^ forms at: aSymbol asSymbol ifAbsent: aBlock
]

{ #category : #accessing }
ScratchTheme >> formAt: aSymbol put: aForm [
	forms at: aSymbol asSymbol put: aForm
]

{ #category : #private }
ScratchTheme >> forms [
	^ forms copy
]

{ #category : #initialization }
ScratchTheme >> initialize [
	colors := Dictionary new.
	forms := Dictionary new
]

{ #category : #'file read' }
ScratchTheme >> readFormsFrom: aFileReference [
	| img fn |
	aFileReference files
		do: [ :entry | 
			fn := entry fullName.
			Cursor read showWhile: [ img := [ Form fromFileNamed: fn ] ifError: [ self error	"nil" ] ].
			img ifNotNil: [ self formAt: entry base asSymbol put: img ] ].
]
