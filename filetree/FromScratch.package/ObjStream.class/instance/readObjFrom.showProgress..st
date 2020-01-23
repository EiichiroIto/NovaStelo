entry points
readObjFrom: aStream showProgress: showProgress
	"Read the root object from the given binary stream. If showProgress is true, display a progress bar."

	| objCount tenPercent |
	objects := OrderedCollection new.
	stream := aStream.
	self readFileHeader.

	firstPass := true.
	objCount := stream uint32.
	showProgress
		ifTrue: [
			tenPercent := objCount // 10.
			('Reading' localized, ScratchTranslator ellipsesSuffix)
				displayProgressFrom: 0 to: objCount + tenPercent
				during: [:progressBar |
					1 to: objCount do: [:i |
						objects addLast: self readObjectRecord.
						progressBar value: i].

					firstPass := false.
					objects do: [:rec | self fixReferencesForObjectRecord: rec].
					progressBar value: objCount + (tenPercent // 2).
					objects do: [:rec | self initializeUserDefinedFields: rec].
					progressBar value: objCount + tenPercent.
					(Delay forMilliseconds: 200) wait]]
		ifFalse: [
			objCount timesRepeat: [objects addLast: self readObjectRecord].
			firstPass := false.
			objects do: [:rec | self fixReferencesForObjectRecord: rec].
			objects do: [:rec | self initializeUserDefinedFields: rec]].

	^ objects first first
