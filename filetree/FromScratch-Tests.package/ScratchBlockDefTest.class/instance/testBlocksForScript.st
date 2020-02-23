test
testBlocksForScript
	| sc def list ret |
	sc := self newScript.
	def := self newBlockDef.
	list := #(
			'sensing'
			('return value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	def setupFrom: list.
	ret := def blocksFor: 'basic' script: sc.
	self assert: ret isEmpty.
	ret := def blocksFor: 'sensing' script: sc.
	self assert: ret size equals: 1.
	self assert: ret first commandSpec equals: 'return value'