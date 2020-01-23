arg generator
reporterArgString: aReporterMorph
	| selector |
	selector := aReporterMorph selector.
	(self class isOperator: selector)
		ifTrue: [ selector := self class operatorAt: selector ifAbsent: [ self error ] ].
	^ codeGenerator generateReporter: selector morph: aReporterMorph