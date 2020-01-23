private
forceLayout
	self fixBlockLayout.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph)
		ifNotNil: [ :morph | morph fixLayout ]