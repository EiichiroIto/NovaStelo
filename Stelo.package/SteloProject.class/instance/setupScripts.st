private
setupScripts
	observerScript
		ifNil: [ observerScript := self newObserverScript.
			self addScript: observerScript ].
	patchesScript
		ifNil: [ patchesScript := self newPatchesScript.
			self addScript: patchesScript ].
	self breeds size < 3
		ifTrue: [ self addNewTurtleScript ]