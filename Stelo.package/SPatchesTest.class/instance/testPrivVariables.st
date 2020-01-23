tests-private
testPrivVariables
	| ps |
	ps := SPatches new.
	self assert: ps privVariables class equals: Variables