private
argString: anArgMorph 
	| v |
	^ anArgMorph labelMorph
		ifNil: [0]
		ifNotNil: 
			[v := anArgMorph evaluate.
			self literalStringFrom: v]