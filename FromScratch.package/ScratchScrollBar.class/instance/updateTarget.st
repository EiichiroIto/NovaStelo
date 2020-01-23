scroll bar protocol
updateTarget
	"Update my target object with my current value, a number between 0.0 and 1.0. Do nothing if either my target or my selector is nil."

	target notNil & selector notNil
		ifTrue: [target perform: selector with: self scrollFraction].
