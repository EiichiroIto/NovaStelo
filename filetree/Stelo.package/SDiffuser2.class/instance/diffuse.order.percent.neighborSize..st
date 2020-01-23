accessing
diffuse: anArray order: anInteger1 percent: aNumber neighborSize: anInteger2
	self setupDiffuseOrder: anInteger1 neighborSize: anInteger2.
	self diffuse: anArray percent: aNumber.
	self restoreExtended: anArray.