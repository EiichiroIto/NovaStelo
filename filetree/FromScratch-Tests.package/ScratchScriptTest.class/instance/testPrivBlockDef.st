test
testPrivBlockDef
	| script |
	script := self newScript.
	self assert: script privBlockDef isNil.
	script blockDef.
	self assert: script privBlockDef class equals: ScratchBlockDef