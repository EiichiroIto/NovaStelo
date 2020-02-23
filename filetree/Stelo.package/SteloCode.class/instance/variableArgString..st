private
variableArgString: aString
	| v |
	v := [ script varId varNoFor: aString ] ifError: [ nil ].
	v ifNil: [ ^ 0 ].
	^ generator getVar: v