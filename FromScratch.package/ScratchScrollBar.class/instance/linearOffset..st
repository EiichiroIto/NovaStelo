event handling
linearOffset: evt
	"Answer the linear position of the given event's cursor point along my slider's range. For example, this will be zero at the leftmost/topmost edge of the slider's range."

	bounds isWide
		ifTrue: [^ evt cursorPoint x - (self left + sliderInsets left)]  "horizontal"
		ifFalse: [^ evt cursorPoint y - (self top + sliderInsets top)].  "vertical"

