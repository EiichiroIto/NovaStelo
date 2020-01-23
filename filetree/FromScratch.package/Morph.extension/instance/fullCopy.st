*FromScratch
fullCopy
	"Produce a copy of me with my entire tree of submorphs. Morphs mentioned more than once are all directed to a single new copy. Simple
inst vars are not copied, so you must override to copy Arrays, Forms, editable text, etc."

	| copier new |
	copier := DeepCopier new initialize: 4096.
	new := self copyRecordingIn: copier.
	new allMorphsDo: [:m | m updateReferencesUsing: copier].
	^ new