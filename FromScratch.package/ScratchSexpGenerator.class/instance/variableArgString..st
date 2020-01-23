arg generator
variableArgString: aString
	^ '(getVar ' , (SexpLexer quotedString: aString) , ')'