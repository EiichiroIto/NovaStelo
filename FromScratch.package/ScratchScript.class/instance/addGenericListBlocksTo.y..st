blocks
addGenericListBlocksTo: page y: startY
	"Add the generic list blocks to the given page starting at the given y offset."

	| addButton deleteButton x y |
	addButton := ScratchTheme
		buttonLabel: 'Make a list' localized
		selector: #addList:.
	deleteButton := ScratchTheme
		buttonLabel: 'Delete a list' localized
		selector: #deleteList:.
	x := 13.
	y := startY + 10.
	page
		addMorph:
			(addButton
				target: self project application;
				arguments: {self};
				position: x @ y).
	y := addButton bottom + 3.
	self listVarNames isEmpty
		ifTrue: [ ^ y ].
	page
		addMorph:
			(deleteButton
				target: self project application;
				arguments: {self};
				position: x @ y).
	y := deleteButton bottom + 10.
	"y := (self addListReportersTo: page x: x y: y) + 10."
	(self blocksFor: 'list')
		do: [ :blockOrSym | 
			blockOrSym = #- | (blockOrSym = #~)
				ifTrue: [ "insert a half space"
					blockOrSym = #-
						ifTrue: [ y := y + 15 ].
					blockOrSym = #~
						ifTrue: [ y := y + 5 ] ]
				ifFalse: [ y := self createBlock: blockOrSym atPosition: x @ y onPage: page.
					page submorphs last color: ScratchTheme listBlockColor ] ].
	^ y