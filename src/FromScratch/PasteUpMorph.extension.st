Extension { #name : #PasteUpMorph }

{ #category : #'*FromScratch' }
PasteUpMorph >> rootForGrabOf: aMorph [
	"If open to drag-n-drop, allow the given submorph to be extracted. If I am a parts bin answer a new copy of it."

	| root |
	root := aMorph.
	[root = self] whileFalse: [
		root owner == self ifTrue: [
			self isBlockPalette ifTrue: [^ root fullCopy].
			self dragNDropEnabled ifTrue: [^ root]].
		root := root owner].

	^ super rootForGrabOf: aMorph
]
