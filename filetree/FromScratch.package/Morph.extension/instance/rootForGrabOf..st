*FromScratch
rootForGrabOf: aMorph
	"Answer the root of the morph structure to be picked up when the given morph is grabbed."

	(self isSticky and: [self isPartsDonor not])
		ifTrue: [^ nil]
		ifFalse: [
			(owner isNil or: [owner isWorldOrHandMorph])
				ifTrue: [^ self]
				ifFalse: [
					owner allowSubmorphExtraction
						ifTrue: [^ self]
						ifFalse: [^ owner rootForGrabOf: aMorph]]].