instance creation
buildScratch14Theme
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