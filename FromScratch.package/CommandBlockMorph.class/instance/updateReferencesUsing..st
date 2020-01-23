private
updateReferencesUsing: deepCopier
	"Update my arg morphs."

	super updateReferencesUsing: deepCopier.
	argMorphs := argMorphs collect: [:m | deepCopier references at: m ifAbsent: [m]].
