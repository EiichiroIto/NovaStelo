tests-private
testBorders
	| d |
	d := SDiffuser neighbor4.
	self assertCollection: d borders equals: #(top left right bottom).