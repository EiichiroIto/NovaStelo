private
updateContents
	| p |
	p := self target
		ifNil: [ ScratchBlockPaletteMorph new ]
		ifNotNil: [ self target viewerPageForCategory: self currentCategory ].
	p color: ScratchTheme palettePaneColor.
	p fixLayout.
	pageViewer morph contents: p