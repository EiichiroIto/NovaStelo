tests-private
testCorners
	| d |
	d := SDiffuser neighbor4.
	self assertCollection: d corners equals: #(topLeft topRight bottomLeft bottomRight).