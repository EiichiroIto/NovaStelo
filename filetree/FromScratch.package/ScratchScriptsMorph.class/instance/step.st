stepping
step
	"Give feedback about possible drop targets."

	| feedbackColor h b targetArg targetAssoc targetP targetBlock |
	feedbackMorph
		ifNil: [ feedbackMorph := BorderedMorph new borderWidth: 3 ]
		ifNotNil: [ feedbackMorph delete ].
	feedbackColor := Color white.
	feedbackMorph useSquareCorners.
	h := self activeHand.
	"h toolType = 'CutTool' ifTrue: [^ self showDeleteFeedback]."
	(self bounds containsPoint: h position)
		ifFalse: [ ^ self ].
	h submorphCount = 1
		ifFalse: [ ^ self ].
	b := h firstSubmorph.
	b isBlockMorph
		ifFalse: [ ^ self ].

	b isReporter
		ifTrue: [ "reporter block"
			(targetArg := self topArgMorphAt: b bounds exclude: nil)
				ifNil: [ ^ self ].
			(targetArg acceptsTypeOf: b)
				ifFalse: [ ^ self ].
			feedbackMorph
				bounds: (targetArg bounds expandBy: 5);
				color: (feedbackColor alpha: 0.4);
				borderColor: feedbackColor;
				useRoundedCorners.
			^ self addMorphFront: feedbackMorph ].

	"non-reporter (i.e. command block or hat block)"
	targetAssoc := b closestAttachTargetIn: self.
	targetAssoc
		ifNil: [ b bottomBlock isCBlock
				ifFalse: [ targetAssoc := b bottomBlock closestAttachTargetIn: self.
					targetAssoc
						ifNotNil: [ targetAssoc value owner isBlockMorph
								ifTrue: [ targetAssoc := nil ] ] ] ].
	targetAssoc ifNil: [ ^ self ].
	targetP := targetAssoc key.
	targetBlock := targetAssoc value.
	feedbackMorph
		borderColor: feedbackColor;
		color: feedbackColor.

	"subtract the attachment point x from the width so that the feedback in CBlock won't stick out"
	feedbackMorph extent: (targetBlock right - targetP x) @ 5.
	self addMorphFront: (feedbackMorph position: targetP)