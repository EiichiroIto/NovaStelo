drawing-optimization
fullBounds
	"This is the hook that triggers lazy re-layout. It works because layoutChanged clears the fullBounds cache. Once per cycle, the fullBounds is requested from every morph in the world, and that request gets propagated through the entire submorph hierarchy, causing re-layout where needed. Note that multiple layoutChanges to the same morph can be done with little cost, since the layout is only done when the morph needs to be displayed."
	"Detail: Expands by 3 pixels if I have a process to allow for the running/error feedback."

	fullBounds ifNil: [
		"do layout here"
		blockLayoutNeeded ifTrue: [
			super fullBounds.
			self fixBlockLayout.
			fullBounds := nil.
			super fullBounds.  "recompute after layout"
			self changed].
		blockLayoutNeeded := false].

	scratchProc ifNotNil: [^ super fullBounds expandBy: 3].  "allow for running/error feedback"

	^ super fullBounds
