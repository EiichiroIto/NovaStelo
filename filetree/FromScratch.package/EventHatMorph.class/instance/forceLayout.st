initialization
forceLayout
	"My UpdatingStringMorph calls this when its contents change"

	self fixBlockLayout.
	(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) ifNotNil:[
		(self meOrOwnerThatIsA: ScratchBlockPaletteMorph) fixLayout].
