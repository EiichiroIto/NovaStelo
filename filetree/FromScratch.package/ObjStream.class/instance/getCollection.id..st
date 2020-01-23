fixed format-reading
getCollection: anObject id: classID

	| sz result newContents |
	firstPass ifTrue: [
		sz := stream uint32.
		result := (self classForID: classID) new: sz.
		sz timesRepeat: [result add: self readField].
		^ result].

	"fix references"
	newContents := anObject asArray.
	self fixRefsInArray: newContents.
	anObject removeAll: anObject copy; addAll: newContents.
