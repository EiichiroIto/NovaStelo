accessing
selectorAndArg
	"Answer an array containing my selector and argument (if any)."

	| args |
	args := self args.
	^ Array with: selector with: (args size = 0 ifTrue: [nil] ifFalse: [args first])
