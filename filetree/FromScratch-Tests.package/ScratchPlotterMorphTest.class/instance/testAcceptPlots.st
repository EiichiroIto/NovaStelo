test
testAcceptPlots
	| p |
	p := self newPlotter.
	self assert: p acceptPlots.
	p acceptPlots: false.
	self deny: p acceptPlots.
	p acceptPlots: true.
	self assert: p acceptPlots