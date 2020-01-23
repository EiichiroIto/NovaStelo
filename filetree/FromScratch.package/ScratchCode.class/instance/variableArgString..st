private
variableArgString: aString
	| v |
	v := [ targetMorph varId varNoFor: aString ] ifError: [ nil ].
	v ifNil: [ ^ 0 ].
	^ bcGenerator getVar: v