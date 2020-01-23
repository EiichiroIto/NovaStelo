accessing
fontAt: aSymbol name: aString size: anInteger
	| font |
	font := StrikeFont fontName: aString size: anInteger.
	fonts at: aSymbol put: font