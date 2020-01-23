private
newPatchesScript
	^ PatchesScript new
		breed: application newPatches;
		project: self;
		yourself