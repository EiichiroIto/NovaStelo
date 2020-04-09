private
userClasses
	"Answer an array of (<class id>, <class name>) records for all version numbered user classes."
	"The following finds obsolete user classes:"
	"self initialize. self userClasses reject: [:rec | Smalltalk includesKey: rec second]"

	^ #(
		"id		class"
		(100		Morph)
		(101		BorderedMorph)
		(103		EllipseMorph)
		(104		AlignmentMorph)
		(105		StringMorph)
		(108		SimpleButtonMorph)
		(110		ImageMorph)
		"111-129 for subclass"
		(130 	EventId)
		(131		Variables)
		(132		VarDef)
		(133 	LazyArray)
		(134 	StringArray)

		"(140		ChoiceArgMorph)
		(141		ColorArgMorph)
		(142		ExpressionArgMorph)
		(145		SpriteArgMorph)
		(147		BlockMorph)
		(148		CommandBlockMorph)
		(149		CBlockMorph)
		(151		HatBlockMorph)
		(153		ScratchScriptsMorph)
		(157		SetterBlockMorph)
		(158		EventHatMorph)
		(159		SubHatMorph)
		(160		VariableBlockMorph)
		(166		BooleanArgMorph)
		(167		EventTitleMorph)
		(169		ExpressionArgMorphWithMenu)
		(170		ReporterBlockMorph)"
		(172		ToggleButton)
	)
