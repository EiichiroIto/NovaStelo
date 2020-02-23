accessing
parseReporter: aMorph
	| str |
	str := self reporterArgString: aMorph.
	codeGenerator generateReporter: str