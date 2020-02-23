accessing
closestAttachTargetIn: newOwner
	"Answer the closest block attachment point among the blocks and stack submorphs of the given morph. Answer nil if there are no blocks close enough to attach myself to."

	| xThresh yThresh attachPoints best bestDist targetP dist ref topUsed bottomUsed |
	xThresh := 65.
	yThresh := (self isCBlock
		and: [ (self nestedBlockAt: self top + self topBarHeight) isNil ])
		ifTrue: [ 25 ]
		ifFalse: [ 14 ].
	topUsed := false.
	bottomUsed := false.
	attachPoints := OrderedCollection new: 100.
	newOwner
		submorphsDo: [ :m | 
			(m ~~ self
				and: [ m ~~ self bottomBlock
						and: [ m ~~ self topBlock
								and: [ m ~~ self owner and: [ m isBlockMorph and: [ m isReporter not ] ] ] ] ])
				ifTrue: [ m blockAttachPoints: attachPoints ] ].
	(self isHatBlock
		or: [ (self meOrOwnerThatIsA: HatBlockMorph) notNil ])
		ifTrue:
			[ "if I am a HatBlock or the bottom block of a HatBlock stack, I can only attach to the top block of a stack"
			attachPoints := attachPoints
				select:
					[ :assoc | assoc value owner = newOwner and: [ assoc key y = assoc value top ] ] ].
	(self isStop or: [ self bottomBlock isStop ])
		ifTrue: [ "I am a stop block; I can't attach to the top of a stack"
			attachPoints := attachPoints
				select: [ :assoc | assoc key y ~= assoc value top ] ].
	(self topBlock isForever not and: [ self bottomBlock isForever ])
		ifTrue: [ "My bottom block is a forever; I can't attach to the top of a stack"
			attachPoints := attachPoints
				select: [ :assoc | assoc key y ~= assoc value top ] ].
	best := nil.
	bestDist := 10000.
	attachPoints
		do: [ :assoc | 
			targetP := assoc key.
			ref := self left.
			(ref - targetP x) abs < xThresh
				ifTrue: [ ((self top - targetP y) abs < yThresh
						or: [ self nextBlock isNil
								and: [ (self bottom - targetP y) abs < yThresh ] ])
						ifTrue: [ "targetP is within sticking range"
							dist := (self position - targetP) r.
							dist < bestDist
								ifTrue: [ (self top - targetP y) abs < yThresh
										ifTrue: [ topUsed := true.
											bottomUsed := false ].
									(self nextBlock isNil
										and: [ (self bottom - targetP y) abs < yThresh ])
										ifTrue: [ topUsed := false.
											bottomUsed := true ].
									best := assoc.
									bestDist := dist ] ] ] ].

	"special case for the auto-wrapping of c-shaped/if-else blocks"
	self isCBlock
		ifTrue: [ best
				ifNotNil: [ bottomUsed
						ifTrue: [ best value owner isBlockMorph
								ifTrue: [ self stretchHeight: 0.
									^ best := nil ] ].
					(self isStopOrForever or: [ self bottomBlock isStopOrForever ])
						ifTrue: [ bottomUsed
								ifTrue: [ self stretchHeight: 0.
									^ best := nil ] ].
					(best key y = best value top
						and: [ (self isForever or: [ self bottomBlock isForever ])
								and: [ (self nestedBlockAt: best key y) isNil not ] ])
						ifTrue: [ self stretchHeight: 0.
							^ best := nil ].
					(self nestedBlockAt: best key y)
						ifNil: [ bottomUsed
								ifTrue: [ self stretchHeight: 0.
									best key y = best value bottom
										ifTrue: [ ^ best := nil ].
									(best key y = best value top
										and: [ best value owner isBlockMorph ])
										ifTrue: [ ^ best := nil ].
									(best key y = best value bottom
										and: [ best value owner isBlockMorph not ])
										ifTrue: [ ^ best := nil ] ].
							topUsed
								ifTrue: [ (best key y = best value bottom
										and: [ best value nextBlock isNil not ])
										ifTrue: [ self stretchHeight: 0.
											^ best := nil ].
									"((best key y = best value top) and: [(best value owner isKindOf: BlockMorph)]) ifTrue: [self stretchHeight: 0. ^ best := nil]."
									best key y = best value top
										ifTrue: [ self stretchHeight: best value fullBounds height - 17.
											^ best ] ].
							self stretchHeight: 0 ] ].
			best ifNil: [ self stretchHeight: 0 ] ].
	^ best