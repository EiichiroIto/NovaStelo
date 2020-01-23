private
updateContents
	| p |
	self target
		ifNil: [ self
				pageViewerContents: (Morph new color: ScratchTheme palettePaneColor).
			^ self ].
	p := self target viewerPageForCategory: currentCategory.
	p color: ScratchTheme palettePaneColor.
	self pageViewerContents: p.
	p fixLayout