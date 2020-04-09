block specs
setupBlockDef
	self setupArgBuilder.
	blockDef := ScratchBlockDef new.
	self setupBlockCategory.
	blockDef
		setupFrom: self blocks;
		addUnknownCategories