drawing
drawSubmorphsOn: aCanvas
	"Clip submorph drawing to my bounds."

	"stringMorph suppressAntiAliasing: isKeyboardFocus."
	super drawSubmorphsOn: (aCanvas copyClipRect: self innerBounds).
