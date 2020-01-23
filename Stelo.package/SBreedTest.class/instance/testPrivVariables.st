tests-private
testPrivVariables
	| obj |
	obj := STurtles new.
	self assert: obj privVariables class equals: Variables.
	obj := SPatches new.
	self assert: obj privVariables class equals: Variables