test
testIsSpacer
	| def |
	def := self newBlockDef.
	self assert: (def isSpacer: #-).
	self assert: (def isSpacer: #~).
	self deny: (def isSpacer: #(a b)).
	self deny: (def isSpacer: #+).
	self deny: (def isSpacer: #basic).
	self deny: (def isSpacer: #operators)