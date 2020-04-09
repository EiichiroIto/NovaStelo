private
evaluateSelfEvaluating
	"The easiest case. Evaluate a number, color, or any self-evaluating expression."

	| value |
	value := stackFrame expression evaluate.
	self returnValueToParentFrame: value.
	self popStackFrame