blocks
createBlock: block atPosition: pos onPage: page
	"Creates a block on the given page. If the block is one that can become a watcher, then a toggle button is created as well."

	| x y changingX toggleButton yOffset |
	x := pos x.
	y := pos y.
	changingX := x.
	block canBecomeWatcher
		ifTrue: [ toggleButton := self createToggleButtonFor: block.
			yOffset := (block fullBounds height
				- toggleButton fullBounds height) // 2.
			page addMorphBack: (toggleButton position: x @ (y + yOffset)).
			changingX := x + toggleButton fullBounds width + 4 ].
	block
		fixBlockLayout;
		position: changingX @ y.
	page addMorphBack: block.
	^ y + block height + 3