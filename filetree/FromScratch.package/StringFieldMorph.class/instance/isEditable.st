accessing
isEditable
	"Answer true if I am editable."

	isEditable ifNil: [isEditable := true].
	^ isEditable
