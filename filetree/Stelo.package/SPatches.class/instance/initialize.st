initialization
initialize
	super initialize.
	diffuser := SDiffuser2 new.
	self create: self defaultOrder.