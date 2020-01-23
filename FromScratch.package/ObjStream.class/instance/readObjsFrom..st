entry points
readObjsFrom: aStream
	"For testing. Answer the entire objects table from the given stream."

	| objCount |
	objects := OrderedCollection new.
	stream := aStream.
	self readFileHeader.

	firstPass := true.
	objCount := stream uint32.
	objCount timesRepeat: [objects addLast: self readObjectRecord].
	firstPass := false.
	objects do: [:rec | self fixReferencesForObjectRecord: rec].
	objects do: [:rec | self initializeUserDefinedFields: rec].

	^ objects

