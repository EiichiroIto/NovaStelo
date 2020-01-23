instance creation
buildDarkTheme
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