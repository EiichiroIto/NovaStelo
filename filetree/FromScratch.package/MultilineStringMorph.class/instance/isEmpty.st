accessing
isEmpty
	"Answer true if my contents is empty."

	^ lines size = 0 or: [lines size = 1 and: [lines first size = 0]]
