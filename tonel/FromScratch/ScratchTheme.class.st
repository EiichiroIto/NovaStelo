Class {
	#name : #ScratchTheme,
	#superclass : #Object,
	#instVars : [
		'colors',
		'forms',
		'fonts'
	],
	#classVars : [
		'AvailableThemes',
		'CurrentTheme'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #fonts }
ScratchTheme class >> argFont [
	^ self fontAt: #Arg
]

{ #category : #colors }
ScratchTheme class >> blockArgColor [
	^ self colorAt: #blockArgColor
]

{ #category : #'instance creation' }
ScratchTheme class >> buildDarkTheme [
	| obj |
	obj := self newThemeNamed: 'darkTheme'.
	obj colorAt: #blockArgColor put: (Color gray: 0.2).
	obj colorAt: #categoryOnColor put: Color black.
	obj colorAt: #categoryOffColor put: (Color gray: 0.8).
	obj colorAt: #dialogBoxTextColor put: (Color gray: 0.8).
	obj colorAt: #dialogBoxTitleColor put: (Color gray: 0.4).
	obj colorAt: #fieldColor put: (Color gray: 0.2).
	obj colorAt: #folderHighlightColor put: (Color r: (96/255) g: (136/255) b: (182/255)).
	obj colorAt: #labelOnColor put: Color black.
	obj colorAt: #labelOffColor put: (Color gray: 0.8).
	obj colorAt: #libraryColor put: (Color gray: 0.2).
	obj colorAt: #listColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068).
	obj colorAt: #menuNormalColor put: (Color gray: 0.8).
	obj colorAt: #menuHighlightColor put: Color white.
	obj colorAt: #plotterFrameColor put: (Color gray: 0.4).
	obj colorAt: #plotterPaneColor put: (Color gray: 0.8).
	obj colorAt: #palettePaneColor put: (Color gray: 0.2).
	obj colorAt: #readoutColor put: (Color gray: 0.2).
	obj colorAt: #scriptsPaneColor put: (Color gray: 0.2).
	obj colorAt: #sensorBoardColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #textColor put: (Color gray: 0.8).
	obj colorAt: #textSelectionColor put: (Color r: 0.353 g: 0.607 b: 0.788).
	obj colorAt: #thumbnailDirectionColor put: (Color gray: 0.8).
	obj colorAt: #viewerPaneColor put: (Color gray: 0.2).
	obj colorAt: #watcherColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #watcherBorderColor put: (Color r: (148/255) g: (145/255) b: (145/255)).
	^ obj
]

{ #category : #'instance creation' }
ScratchTheme class >> buildScratch14Theme [
	| obj |
	obj := self newThemeNamed: 'scratch14Theme'.
	obj colorAt: #blockArgColor put: (Color gray: 0.95).
	obj colorAt: #categoryOnColor put: Color white.
	obj colorAt: #categoryOffColor put: Color white.
	obj colorAt: #dialogBoxTextColor put: Color black.
	obj colorAt: #dialogBoxTitleColor put: Color white.
	obj colorAt: #fieldColor put: (Color r: (211/255) g: (214/255) b: (216/255)).
	obj colorAt: #folderHighlightColor put: (Color r: (96/255) g: (136/255) b: (182/255)).
	obj colorAt: #labelOnColor put: Color black.
	obj colorAt: #labelOffColor put: (Color r: (78/255) g: (82/255) b: (82/255)).
	obj colorAt: #libraryColor put: Color gray.
	obj colorAt: #listColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068).
	obj colorAt: #menuNormalColor put: (Color gray: 0.3).
	obj colorAt: #menuHighlightColor put: Color white.
	obj colorAt: #palettePaneColor put: (Color r: 124 g: 128 b: 131 range: 255).
	obj colorAt: #readoutColor put: (Color r: 0.753 g: 0.764 b: 0.776).
	obj colorAt: #scriptsPaneColor put: (Color r: (149/255) g: (154/255) b: (159/255)).
	obj colorAt: #sensorBoardColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #textColor put: Color white.
	obj colorAt: #textSelectionColor put: (Color r: 0.353 g: 0.607 b: 0.788).
	obj colorAt: #thumbnailDirectionColor put: Color blue.
	obj colorAt: #viewerPaneColor put: (Color r: 0.584 g: 0.603 b: 0.623).
	obj colorAt: #watcherColor put: (Color r: (193/255) g: (196/255) b: (199/255)).
	obj colorAt: #watcherBorderColor put: (Color r: (148/255) g: (145/255) b: (145/255)).
	^ obj
]

{ #category : #'instance creation' }
ScratchTheme class >> buildScratch30Theme [
	| obj |
	obj := self newThemeNamed: 'scratch30Theme'.
	obj colorAt: #blockArgColor put: (Color gray: 0.95).
	obj colorAt: #categoryOnColor put: Color black.
	obj colorAt: #categoryOffColor put: (Color r: (78/255) g: (82/255) b: (82/255)).
	obj colorAt: #dialogBoxTextColor put: Color black.
	obj colorAt: #dialogBoxTitleColor put: Color white.
	obj colorAt: #fieldColor put: Color white.
	obj colorAt: #folderHighlightColor put: (Color fromString: '#4c97ff').
	obj colorAt: #labelOnColor put: Color black.
	obj colorAt: #labelOffColor put: (Color r: (78/255) g: (82/255) b: (82/255)).
	obj colorAt: #libraryColor put: Color white.
	obj colorAt: #listColor put: Color white.
	obj colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068).
	obj colorAt: #menuNormalColor put: Color white.
	obj colorAt: #menuHighlightColor put: (Color gray: 0.3).
	obj colorAt: #palettePaneColor put: Color white.
	obj colorAt: #readoutColor put: Color white.
	obj colorAt: #scriptsPaneColor put: Color white.
	obj colorAt: #sensorBoardColor put: Color white.
	obj colorAt: #textColor put: Color black.
	obj colorAt: #textSelectionColor put: Color green.
	obj colorAt: #thumbnailDirectionColor put: Color blue.
	obj colorAt: #viewerPaneColor put: Color white.
	obj colorAt: #watcherColor put: Color white.
	obj colorAt: #watcherBorderColor put: Color black.
	^ obj
]

{ #category : #fonts }
ScratchTheme class >> buttonFont [
	^ self fontAt: #Button
]

{ #category : #accessing }
ScratchTheme class >> buttonLabel: aString selector: aSymbolOrNil [
	"Answer a big button with the given label."

	| button |
	button := ResizableToggleButton2 new
		offForm: (self formAt: #btn) onForm: (self formAt: #btnPressed);
		label: aString font: self buttonFont;
		actionSelector: aSymbolOrNil;
		labelColorOn: self labelOnColor
			labelColorOff: self labelOffColor
			labelColorOver: self labelOnColor.
	^ button
]

{ #category : #accessing }
ScratchTheme class >> changeTheme: aSymbol [
	CurrentTheme := AvailableThemes at: aSymbol
]

{ #category : #accessing }
ScratchTheme class >> colorAt: aSymbol [
	^ self current colorAt: aSymbol
]

{ #category : #fonts }
ScratchTheme class >> commentFont [
	^ self fontAt: #CommentBlock
]

{ #category : #accessing }
ScratchTheme class >> current [
	^ CurrentTheme
]

{ #category : #colors }
ScratchTheme class >> dialogBoxTextColor [
	^ self colorAt: #dialogBoxTextColor
]

{ #category : #colors }
ScratchTheme class >> fieldColor [
	^ self colorAt: #fieldColor
]

{ #category : #accessing }
ScratchTheme class >> fontAt: aSymbol [
	^ self current fontAt: aSymbol
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
	| response ref |
	response := ZnEasy get: self themesURL.
	response isSuccess
		ifFalse: [ self error: 'Cannot get Themes.zip' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.
]

{ #category : #initialization }
ScratchTheme class >> initialize [
	"ScratchTheme initialize."

	| dict theme |
	self themeIsInstalled
		ifFalse: [ self getThemes ].
	dict := Dictionary new.
	('Themes' asFileReference directoryNames copyWithout: 'common')
		do: [ :each | 
			theme := self perform: ('build' , each asCamelCase) asSymbol.
			dict at: each asSymbol put: theme ].
	AvailableThemes := dict.
	self changeTheme: AvailableThemes keys anyOne
]

{ #category : #fonts }
ScratchTheme class >> labelFont [
	^ self fontAt: #Label
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
	obj := ScratchTheme new.
	self setupFont: obj.
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
		ifFalse: [self error: 'Themes directory not found'].
	dir := base / 'common'.
	dir isDirectory
		ifFalse: [self error: 'common directory not found'].
	aTheme readFormsFrom: dir.
	dir := base / aString.
	dir isDirectory
		ifFalse: [self error: aString , ' directory not found'].
	aTheme readFormsFrom: dir.
]

{ #category : #colors }
ScratchTheme class >> scriptsPaneColor [
	^ self colorAt: #scriptsPaneColor
]

{ #category : #private }
ScratchTheme class >> setupFont: aTheme [
	aTheme fontAt: #Arg name: 'Verdana' size: 10.
	aTheme fontAt: #Label name: 'VerdanaBoldNarrowSpace' size: 10.
	aTheme fontAt: #MenuTitle name: 'VerdanaBold' size: 14.
	aTheme fontAt: #Button name: 'VerdanaBold' size: 10.
	aTheme fontAt: #Category name: 'VerdanaBold' size: 10.
	aTheme fontAt: #Tab name: 'VerdanaBold' size: 11.
	aTheme fontAt: #CommentBlock name: 'Verdana' size: 10.
	aTheme fontAt: #TalkBubble name: 'VerdanaBold' size: 12.
	aTheme fontAt: #ToolTip name: 'Verdana' size: 13.
	aTheme fontAt: #ReporterToolTip name: 'Verdana' size: 14.
	aTheme fontAt: #XYReadout name: 'Verdana' size: 10.
	aTheme fontAt: #XYReadoutBold name: 'VerdanaBold' size: 10.
	aTheme fontAt: #CostumesPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #SoundsPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #ViewerPage name: 'VerdanaBold' size: 11.
	aTheme fontAt: #UpdatingStringField name: 'VerdanaBold' size: 11.
	aTheme fontAt: #Watcher name: 'VerdanaBold' size: 10.
	aTheme fontAt: #WatcherLarge name: 'VerdanaBold' size: 14.
	aTheme fontAt: #PaintUtilityButton name: 'VerdanaBold' size: 10.
	aTheme fontAt: #PaintSetRotationCenter name: 'VerdanaBold' size: 11.
	aTheme fontAt: #LibraryItemName name: 'VerdanaBold' size: 9	.
	aTheme fontAt: #LibraryItemInfo name: 'Verdana' size: 6	.
	aTheme fontAt: #MediaItemInfo name: 'Verdana' size: 9	.
	aTheme fontAt: #DialogBoxTitle name: 'VerdanaBold' size: 14.
	aTheme fontAt: #DialogBoxMessage name: 'VerdanaBold' size: 13.
	aTheme fontAt: #DialogBoxButton name: 'VerdanaBold' size: 11.
	aTheme fontAt: #ProjectNotes name: 'Verdana' size: 10.
	aTheme fontAt: #LinkMorphDefault name: 'VerdanaBold' size: 10.
	aTheme fontAt: #ShareLink name: 'VerdanaBold' size: 13.
	aTheme fontAt: #SoundRecorderButton name: 'VerdanaBold' size: 13.
	aTheme fontAt: #SoundRecorderTimer name: 'NewYorkBold' size: 10.
	aTheme fontAt: #StringDialogTypeIn name: 'Verdana' size: 12.
	aTheme fontAt: #NewVariableDialogBox name: 'Verdana' size: 11.
	aTheme fontAt: #AboutScratch name: 'VerdanaBold' size: 11.
	aTheme fontAt: #UploadTagLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #UploadTag name: 'Verdana' size: 10.
	aTheme fontAt: #UploadDialogLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #UploadDialogContents name: 'Verdana' size: 10.
	aTheme fontAt: #UploadDialogComment name: 'Verdana' size: 10.
	aTheme fontAt: #FolderShortcut name: 'Verdana' size: 11.
	aTheme fontAt: #FileChooserNewFileTitle name: 'VerdanaBold' size: 10.
	aTheme fontAt: #FileChooserNewFilename name: 'Verdana' size: 10.
	aTheme fontAt: #FileChooserLabel name: 'VerdanaBold' size: 10.
	aTheme fontAt: #FileChooserContents name: 'Verdana' size: 12.
	aTheme fontAt: #FileChooserComment name: 'Verdana' size: 10.
	aTheme fontAt: #FilePickerDirectoryName name: 'VerdanaBold' size: 9	.
	aTheme fontAt: #FilePickerEntry name: 'Verdana' size: 11.
	aTheme fontAt: #FilePickerEntryHighlighted name: 'VerdanaBold' size: 11.
	aTheme fontAt: #FrameMorphProjectTitle name: 'VerdanaBold' size: 13
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
ScratchTheme class >> themeNames [
	^ AvailableThemes keys
]

{ #category : #private }
ScratchTheme class >> themesURL [
	^ 'https://github.com/EiichiroIto/NovaStelo/raw/master/src/Themes.zip'
]

{ #category : #private }
ScratchTheme class >> updateDarkTheme [
	"ScratchTheme updateDarkTheme."
	AvailableThemes at: #darkTheme put: self buildDarkTheme.
	self changeTheme: #darkTheme.
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
ScratchTheme >> fontAt: aSymbol [
	^ fonts at: aSymbol
]

{ #category : #accessing }
ScratchTheme >> fontAt: aSymbol name: aString size: anInteger [
	| font |
	font := StrikeFont fontName: aString size: anInteger.
	fonts at: aSymbol put: font
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
	forms := Dictionary new.
	fonts := Dictionary new
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
