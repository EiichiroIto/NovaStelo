accessing
icon: aForm
	"Add an icon to this button."

	iconMorph ifNotNil: [iconMorph delete].  "delete old icon"
	iconMorph := ImageMorph new form: aForm.
	self addMorph: iconMorph.
	self extent: (iconMorph extent + 10).

