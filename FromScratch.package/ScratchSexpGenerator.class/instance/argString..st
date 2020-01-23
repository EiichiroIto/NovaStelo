arg generator
argString: anArgMorph 
	| v |
	^ anArgMorph labelMorph
		ifNil: [self error: 'nil arg']
		ifNotNil: 
			[v := anArgMorph evaluate.
			self literalStringFrom: v]