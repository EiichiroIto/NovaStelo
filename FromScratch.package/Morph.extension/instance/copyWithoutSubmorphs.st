*FromScratch
copyWithoutSubmorphs

	^ self shallowCopy
		privateOwner: nil;
		privateSubmorphs: Array empty;
		privateBounds: (bounds origin corner: bounds corner)  "deep-copy bounds"
