private
evaluateSpecialForm
	"Evaluates the current special form expression.  Requires that no arguments have been evaluated, and that the current expression be a special form."

	self perform: stackFrame expression selector