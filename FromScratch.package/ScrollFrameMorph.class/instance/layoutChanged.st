geometry
layoutChanged
	"If my contents morph's layout has changed, record that fact."

	super layoutChanged.
	contents mayNeedLayout ifTrue: [contentsChanged := true].
