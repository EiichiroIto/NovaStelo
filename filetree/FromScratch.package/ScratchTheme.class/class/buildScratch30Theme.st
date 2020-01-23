instance creation
buildScratch30Theme
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