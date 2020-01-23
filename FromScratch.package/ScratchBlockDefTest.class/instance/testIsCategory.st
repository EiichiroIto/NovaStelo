test
testIsCategory
	| def |
	def := self newBlockDef.
	self deny: (def isCategory: #-).
	self deny: (def isCategory: #~).
	self deny: (def isCategory: #(a b)).
	self assert: (def isCategory: #+).
	self assert: (def isCategory: #basic).
	self assert: (def isCategory: #operators)