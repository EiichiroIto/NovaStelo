blocks
viewerPageForSensing
	| bin x y |
	bin := self newBlockPaletteMorph isForScript: true; yourself.
	x := 12.
	y := 10.
	(self blocksFor: 'sensing')
		do: [ :blockOrSym | 
			blockOrSym = #- | (blockOrSym = #~)
				ifTrue: [ blockOrSym = #-
						ifTrue: [ y := y + 15 ].
					blockOrSym = #~
						ifTrue: [ y := y + 7.
							bin
								addMorph:
									((ImageMorph new form: (ScratchTheme formAt: #connector))
										position: x @ y).
							y := y + 20 ] ]
				ifFalse: [ y := self createBlock: blockOrSym atPosition: x @ y onPage: bin ] ].
	^ bin