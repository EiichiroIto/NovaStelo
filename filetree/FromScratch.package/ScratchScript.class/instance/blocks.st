block specs
blocks
	"Answer a collection of block specifications for the blocks that are common to all objects. Block specificatons (Arrays) are interspersed with category names (Strings). A block specification is an Array of the form: (<block spec string> <block type> <selector> [optional initial argument values]).

	Explanation of flags:
		-	no flags
		b	boolean reporter
		c	c-shaped block containing a sequence of commands (always special form)
		r	reporter
		s	special form command with its own evaluation rule
		t	timed command, like wait or glide
		E	message event hat
		K	key event hat
		M	mouse-click event hat
		S	start event hat
		W	when <condition> hat (obsolete)"

	| blocks |
	blocks := #(
		'control'
			('when loop'					L	-)
			('when I receive %e'		E	-)
			-
			('repeat %n'					c	doRepeat 10)
			-
			('broadcast %e'				-	broadcast:)
			('call %S'						-	callSub: '')
			-
			('if %b'							c	doIf)
			('if %b'							c	doIfElse)
			('repeat until %b'			c	doUntil)
			-
			('return %n'					-	return: 0)
			('stop script'					-	stopThread)
			('stop all'						-	stopAll)
		'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)
			('%n * %n'						r	* - -)
			('%n / %n'						r	/ - -)
			('- %n'								r	negated: 1)
			-
			('pick random %n to %n'		r	randomFrom:to: 1 10)
			-
			('%s < %s'						b	< '' '')
			('%s = %s'						b	= '' '')
			('%s > %s'						b	> '' '')
			('%n between %n and %n'	b is:between:and: 50 0 100)
			-
			('%b and %b'					b	&)
			('%b or %b'						b	|)
			('not %b'							b	not:)
			-
			('%n mod %n'					r	\\ - -)
			('round %n'						r	rounded: -)
			('truncate %n'					r	truncated: -)
			-
			('%f of %n'						r	computeFunction:of: 'sqrt' 10)
		'sensing'
			('return value'				r	returnValue)
	).

	^ blocks