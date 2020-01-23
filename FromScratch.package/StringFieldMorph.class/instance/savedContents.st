accessing
savedContents
	"If the user is editing, return the last contents before editing. Otherwise, return my contents."

	(isKeyboardFocus and: [lastContents notNil]) ifTrue: [^ lastContents].
	^ stringMorph contents
