arg generator
generateReporter: aSymbol morph: aReporterMorph
	| out |
	out := WriteStream on: String new.
	out nextPut: $(.
	out nextPutAll: aSymbol.
	aReporterMorph blockArgs
		do: [ :each | 
			out nextPut: Character space.
			out nextPutAll: (each argString: parser) asString ].
	out nextPut: $).
	^ out contents