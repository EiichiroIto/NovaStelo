program
eventBlocks
	^ blocksBin submorphs select: [:m | m class = EventHatMorph]