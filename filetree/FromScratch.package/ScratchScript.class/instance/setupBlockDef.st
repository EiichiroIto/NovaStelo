block specs
setupBlockDef
	blockDef := ScratchBlockDef new.
	self setupBlockCategory.
	blockDef
		setupFrom: self blocks;
		addUnknownCategories