evaluation
evaluateFunction: aSymbol withArgs: anArgs
	"Evalue this block with the given argument list."

	"special case for unary operators"

	"(#(abs not rounded sqrt truncated) includes: aSymbol)
		ifTrue: [ ^ anArgs first perform: aSymbol ]."
	^ self evaluator perform: aSymbol withArguments: anArgs