entry points
storeObj: anObject on: aStream
	"Write the given object and all the objects that can be reached from it on the given binary stream. Do not display a progress bar."

	self storeObj: anObject on: aStream showProgress: false.
