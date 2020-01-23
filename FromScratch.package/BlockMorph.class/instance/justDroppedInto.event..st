dropping/grabbing
justDroppedInto: newOwner event: evt
	"Handle being dropped into a new situation."

	| project targetAssoc targetP targetBlock bottomBlockUsed upperBlock |
	bottomBlockUsed := false.

	"blocks cannot be dropped onto the stage"
	owner isWorldMorph
		ifTrue: [ self delete.
			self receiver blocksBin changed.
			^ self ].
	(project := newOwner project) ifNotNil: [ project modified: true ].
	"delete myself when dropped in the blocks palette area"
	self isInBlockPalette
		ifTrue: [ self delete.
			self receiver blocksBin changed.
			^ self ].
	"okay to drop blocks into the world during development"
	"((owner == World) and: [Preferences noviceMode not]) ifTrue: [^ self]."
	(owner isScriptEditor
		or: [ owner isBlockMorph or: [ self isReporter ] ])
		ifFalse: [ ^ self rejectDropEvent: evt ].
	self isReporter
		ifTrue: [ ^ self handleReporterDrop ].
	targetAssoc := self closestAttachTargetIn: newOwner.
	targetAssoc
		ifNil: [ self bottomBlock isCBlock
				ifFalse: [ targetAssoc := self bottomBlock closestAttachTargetIn: newOwner.
					targetAssoc
						ifNotNil: [ bottomBlockUsed := true.
							targetAssoc value owner isBlockMorph
								ifTrue: [ targetAssoc := nil ] ] ] ].
	targetAssoc ifNil: [ ^ self ].

	"make sure no processes are running"
	self = self topBlock
		ifTrue: [ self stopProcess ].
	targetP := targetAssoc key.
	targetBlock := targetAssoc value.
	targetP y = targetBlock top
		ifTrue: [ "c-shaped block should nest the target block"
			"((bottomBlockUsed not) and: [((targetBlock owner isKindOf: BlockMorph) not) and: [(self isKindOf: CBlockMorph)]]) ifTrue:["
			(bottomBlockUsed not and: [ self isCBlock ])
				ifTrue: [ targetBlock owner isBlockMorph
						ifTrue: [ targetBlock owner attachBlock: self ]
						ifFalse: [ self
								position:
									(targetP x - self bracketThickness)
										@ (targetP y - self topBarHeight - 3) ].
					self attachBlockNested: targetBlock.
					^ self ].
			"for all other non-c-shaped blocks"
			(bottomBlockUsed
				or: [ targetBlock owner isBlockMorph not and: [ self isCBlock not ] ])
				ifTrue: [ self bottomBlock
						position: targetP x @ (targetP y - (self bottomBlock height - 4)).
					upperBlock := self bottomBlock owner.
					[ upperBlock isBlockMorph ]
						whileTrue: [ upperBlock nextBlock
								ifNotNil: [ upperBlock
										position:
											targetP x
												@ (upperBlock nextBlock position y - (upperBlock height - 4)).
									upperBlock := upperBlock owner ] ] ].
			(bottomBlockUsed not and: [ targetBlock owner isBlockMorph ])
				ifTrue: [ self position: targetP x @ (targetP y - (self height - 4)) ].
			targetBlock owner isBlockMorph
				ifTrue: [ self topBlock position: targetP x @ targetP y.
					targetBlock owner attachBlock: self topBlock ].
			targetBlock
				position:
					targetP x
						@ (self bottomBlock position y + self bottomBlock height + 4).
			(bottomBlockUsed not
				and: [ targetBlock owner isBlockMorph not and: [ self isCBlock ] ])
				ifFalse: [ self bottomBlock attachBlock: targetBlock ] ]
		ifFalse: [ self assert: [ self isHatBlock not ].	"I am not a HatBlockMorph"
			self position: targetP.
			targetBlock attachBlock: self ]