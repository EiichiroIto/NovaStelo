private
updateContents
	| p |
	p := self target
		ifNil: [ Morph new ]
		ifNotNil: [ self target viewerPageForCategory: currentCategory ].
	p color: ScratchTheme palettePaneColor.
	p fixLayout.
	self pageViewerContents: p