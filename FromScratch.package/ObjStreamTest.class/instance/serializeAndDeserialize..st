private
serializeAndDeserialize: anObject
	"For testing. Serialize and de-serialize the given object and answer the result."

	| stream |
	stream := WriteStream on: ByteArray new.
	self newObjStream storeObj: anObject on: stream showProgress: false.
	^ self newObjStream readObjFrom: (ReadStream on: stream contents)