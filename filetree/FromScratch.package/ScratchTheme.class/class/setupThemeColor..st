private
setupThemeColor: aTheme
	| systemTheme |
	systemTheme := Smalltalk ui theme.
	aTheme
		colorAt: #blockArgColor put: systemTheme backgroundColor;
		colorAt: #dialogBoxTextColor put: systemTheme textColor;
		colorAt: #labelOnColor put: Color black;
		colorAt: #labelOffColor put: Color white;
		colorAt: #listBlockColor put: (Color r: 0.85 g: 0.303 b: 0.068);
		colorAt: #plotterFrameColor put: systemTheme windowShadowColor;
		colorAt: #plotterPaneColor put: systemTheme windowColor;
		colorAt: #palettePaneColor put: systemTheme windowColor;
		colorAt: #scriptsPaneColor put: systemTheme windowColor;
		colorAt: #textColor put: systemTheme textColor;
		colorAt: #textSelectionColor put: systemTheme selectionColor