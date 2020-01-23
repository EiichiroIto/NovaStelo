tests-private
testProgram
	| pr p |
	pr := SProgram new.
	p := SteloProcess new program: pr.
	self assert: p program equals: pr.