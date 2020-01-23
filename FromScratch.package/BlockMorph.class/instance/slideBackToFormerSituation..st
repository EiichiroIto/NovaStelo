dropping/grabbing
slideBackToFormerSituation: evt

	| wasEmbedded o pane oldP slideForm startPoint |
	wasEmbedded := false.
	(o := evt hand formerOwner) ifNil: [^ self].
	(o isKindOf: BlockMorph) ifTrue: [
		wasEmbedded := true.
		(pane := o meOrOwnerThatIsA: ScratchScriptsMorph) ifNotNil: [
			o := pane]].
	oldP := evt hand formerPosition.
	slideForm := self imageForm offset: 0@0.
	startPoint := evt hand fullBounds origin.
	owner privateRemoveMorph: self.
	self world displayWorld.
	slideForm slideFrom: startPoint to: oldP nSteps: 12 delay: 15.
	self position: oldP.
	o addMorph: self.
	wasEmbedded ifTrue: [self justDroppedInto: o event: evt].

