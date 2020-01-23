Unicode rendering
stringExtent: aString font: aStrikeFont
	"Answer the extent of the given string using my font under the current font rendering system."
	"self stringExtent: 'Hello, Scratch!' font: (StrikeFont fontName: 'Verdana' size: 18)"

	^ (aStrikeFont widthOfString: aString asString) @ aStrikeFont height