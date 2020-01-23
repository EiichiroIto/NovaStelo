accessing
commandSpec: aString
	"Set my command spec string. See my class comment."
	"CommandBlockMorph new commandSpec: 'forward %n'"

	commandSpec := aString.
	numberArgFlags := nil.
	self addLabel.
	self addCommandIcons.
