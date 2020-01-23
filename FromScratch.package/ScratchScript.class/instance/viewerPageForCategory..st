blocks
viewerPageForCategory: aCategoryName
	| bin x y |
	aCategoryName = 'variables'
		ifTrue: [ ^ self variablesPage ].
	aCategoryName = 'sensing'
		ifTrue: [ ^ self viewerPageForSensing ].
	bin := self newBlockPaletteMorph isForScript: true; yourself.
	x := 12.
	y := 10.
	(self blocksFor: aCategoryName)
		do: [ :blockOrSym | 
			blockOrSym = #- | (blockOrSym = #~)
				ifTrue: [ "insert a half space"
					blockOrSym = #-
						ifTrue: [ y := y + 15 ].	"insert a full space"
					blockOrSym = #~
						ifTrue: [ y := y + 5 ] ]
				ifFalse: [ y := self createBlock: blockOrSym atPosition: x @ y onPage: bin ] ].
	^ bin