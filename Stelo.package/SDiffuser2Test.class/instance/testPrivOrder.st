tests-private
testPrivOrder
	| d |
	d := SDiffuser2 new.
	self assert: d privOrder equals: 0.
	d privOrder: 123.
	self assertCollection: d privOrder equals: 123.