object i/o
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		scriptNameMorph
		indicatorMorph
		scriptOwner
		parameters
		isClickable
	) from: anObjStream.
	parameters := nil.  "procedures with parameters are no longer supported"

	"remove the indicator morph when reading in an older project"
	indicatorMorph ifNotNil: [
		submorphs := submorphs copyWithout: indicatorMorph.
		indicatorMorph := nil].
