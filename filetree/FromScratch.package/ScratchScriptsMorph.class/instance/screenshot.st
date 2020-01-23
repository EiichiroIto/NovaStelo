screenshot
screenshot
	"answer a Form of myself apt for exporting"

	| saveForm leftX topY rightX bottomY |
	screenshooting := true.
	self changed.
	saveForm := self imageForm.

	"clip"
	submorphs isEmpty
		ifTrue: [ ^ nil ].
	leftX := submorphs anyOne left.
	topY := submorphs anyOne top.
	rightX := submorphs anyOne right.
	bottomY := submorphs anyOne bottom.
	(self allMorphs select: [ :m | m ~= self ])
		do: [ :m | 
			leftX := leftX min: m left.
			topY := topY min: m top.
			rightX := rightX max: m right.
			bottomY := bottomY max: m bottom ].
	saveForm := saveForm
		copy:
			(leftX @ topY - self position
				rectangle: rightX @ bottomY - self position).
	screenshooting := false.
	self changed.
	^ saveForm