tests-private
testPrivExtended
	| d |
	d := SDiffuser2 new.
	self assert: d privExtended isNil.
	d privExtended: #(1 2 3).
	self assertCollection: d privExtended equals: #(1 2 3).