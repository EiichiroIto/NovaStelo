*FromScratch
copyRecordingIn: deepCopier
	"Recursively copy this entire composite morph, recording the correspondence between old and new morphs in the given dictionary. This dictionary will be used to update intra-composite references in the copy. See updateReferencesUsing:.
	Note: This default implementation copies ONLY morphs in the submorph hierarchy. If a subclass stores morphs in instance variables that it wants to copy, then it should override this method to do so. The same goes for subclasses that contain other data that should be copied when the morph is duplicated."

	| new |
	new := self copyWithoutSubmorphs.
	deepCopier references at: self put: new.
	submorphs size > 0 ifTrue: [
		new privateSubmorphs:
			(submorphs collect: [:m |
				(m copyRecordingIn: deepCopier) privateOwner: new])].

	extension ifNotNil: [new privateExtension: (extension veryDeepCopyWith: deepCopier)].
	^ new