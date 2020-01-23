tests-private
testPrivSrc
	| d |
	d := SDiffuser neighbor4.
	self assert: d result isNil.
	d privSrc: #(1 2 3).
	self assertCollection: d privSrc equals: #(1 2 3).
	self assertCollection: d result equals: #(0 0 0) asFloatArray.