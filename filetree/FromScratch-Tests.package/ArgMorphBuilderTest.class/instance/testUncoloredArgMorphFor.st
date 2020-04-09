test
testUncoloredArgMorphFor
	| b |
	b := self newBuilder.
	b add: $x builder: [ 1 + 2 ].
	self assert: (b uncoloredArgMorphFor: #(1 $x)) equals: 3