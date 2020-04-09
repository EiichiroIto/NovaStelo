private
applyTimedCommand
	"Applies the current command to the already evaluated list of arguments over a particular time interval."

	| block arguments currentTime startTime args totalMSecs elapsedMSecs |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"Do we still need to evaluate more arguments?"
	arguments size < block argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].
	arguments := block coerceArgs: arguments.

	"Record or get the time when command was first invoked."
	currentTime := Time millisecondClockValue.
	startTime := stackFrame startTime.
	startTime
		ifNil: [ "first call; just set starting time and value"
			args := arguments asArray , (Array with: 0 with: nil).
			stackFrame
				startValue: (block receiver perform: block selector withArguments: args).
			stackFrame startTime: currentTime.
			readyToYield := true.
			^ self ].

	"Call primitive time command with its arguments and the elapsed time in seconds"
	totalMSecs := arguments last * 1000.
	block selector = #mwait:elapsed:from:
		ifTrue: [ totalMSecs := arguments last ].
	elapsedMSecs := currentTime - startTime.
	currentTime < startTime
		ifTrue: [ elapsedMSecs := totalMSecs ].	"clock wrap"
	args := arguments asArray
		, (Array with: elapsedMSecs with: stackFrame startValue).
	block receiver perform: block selector withArguments: args.

	"If not done, then we leave stack as is and yield."
	elapsedMSecs < totalMSecs
		ifTrue: [ readyToYield := true.
			^ self ].

	"Pop this command off the stack and return."
	self popStackFrame