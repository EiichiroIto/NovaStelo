private
yield
	"Sets a flag indicating that we're ready to yield to another process."

	readyToYield := true.
	self popStackFrame