accessing
listNames
	^ varClasses keys
		select: [ :each | (varClasses at: each) = #Array ]