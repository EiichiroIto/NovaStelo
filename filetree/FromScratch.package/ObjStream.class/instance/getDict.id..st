fixed format-reading
getDict: anObject id: classID

	| sz result key value newContents |
	firstPass ifTrue: [
		sz := stream uint32.
		result := (self classForID: classID) new: sz.
		sz timesRepeat: [
			key := self readField.
			value := self readField.
			result at: key put: value].
		^ result].

	"fix references"
	newContents := OrderedCollection new: anObject size.
	anObject copy associationsDo: [:assoc |
		newContents add: ((self targetObjectFor: assoc key) -> (self targetObjectFor: assoc value)).
		anObject removeKey: assoc key].
	anObject size = 0 ifFalse: [self error: 'should be empty!'].
	anObject addAll: newContents asDictionary.
