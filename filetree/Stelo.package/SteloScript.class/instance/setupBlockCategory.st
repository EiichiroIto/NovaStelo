block specs
setupBlockCategory
	super setupBlockCategory.
	blockDef
		addCategory: 'basic' color: (Color h: 225 s: 0.65 v: 0.83);
		addCategory: 'color' color: (Color h: 264 s: 0.62 v: 0.89);
		addCategory: 'pen' color: (Color h: 165 s: 1 v: 0.63);
		addCategory: 'patch' color: (Color h: 296 s: 0.66 v: 0.85)