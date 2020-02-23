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

	^ super blocks, #(
		'basic'
			('kill %n of %m'				-	kill:breed: 0 '')
		'sensing'
			('x %n y %n'					r	patchAtX:y:	0 0)
			-
			('turtles %m count'		r turtlesCount: '')
			('screen width'				r 	screenWidth)
			('screen height'				r 	screenHeight)
			('ticks'							r 	ticks)
	)