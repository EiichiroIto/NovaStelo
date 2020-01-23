initialization
initialize
	super initialize.
	varNames := nil.
	reservedVarNames := Array new.
	classNames := Dictionary new.
	self setupReservedVarNames