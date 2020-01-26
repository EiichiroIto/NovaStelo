initialization
initialize
	super initialize.
	varNames := nil.
	reservedVarNames := Array new.
	varClasses := Dictionary new.
	self setupReservedVarNames