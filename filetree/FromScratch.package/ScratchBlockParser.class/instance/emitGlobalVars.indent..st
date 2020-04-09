code generator
emitGlobalVars: aCollection indent: indent
	aCollection isEmpty
		ifTrue: [ ^ self ].
	indent = 0
		ifTrue: [ ^ self ].
	codeGenerator
		generateIndent: indent;
		generateGlobalVars: aCollection