*FromScratch
rootForGrabOf: aMorph
	"Answer the root of the morph structure to be picked up when the given morph is grabbed."

	self isSticky
		ifTrue: [ ^ nil ].
	(owner isNil or: [ owner isWorldOrHandMorph ])
		ifTrue: [ ^ self ].
	owner allowSubmorphExtraction
		ifTrue: [ ^ self ].
	^ owner rootForGrabOf: aMorph