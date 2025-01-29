Extension { #name : 'Morph' }

{ #category : '*FromScratch' }
Morph >> allowSubmorphExtraction [
	"Return true if this morph allows its submorphs to be extracted just by grabbing them."

	self isBlockPalette ifTrue: [^ false].
	^ self dragNDropEnabled or: [self dragEnabled]
]

{ #category : '*FromScratch' }
Morph >> beep [
	"do nothing"
]

{ #category : '*FromScratch' }
Morph >> copyRecordingIn: deepCopier [
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
]

{ #category : '*FromScratch' }
Morph >> copyWithoutSubmorphs [

	^ self shallowCopy
		privateOwner: nil;
		privateSubmorphs: Array empty;
		privateBounds: (bounds origin corner: bounds corner)  "deep-copy bounds"

]

{ #category : '*FromScratch' }
Morph >> fieldsVersion [
	^ 1
]

{ #category : '*FromScratch' }
Morph >> fullCopy [
	"Produce a copy of me with my entire tree of submorphs. Morphs mentioned more than once are all directed to a single new copy. Simple
inst vars are not copied, so you must override to copy Arrays, Forms, editable text, etc."

	| copier new |
	copier := DeepCopier new initialize: 4096.
	new := self copyRecordingIn: copier.
	new allMorphsDo: [:m | m updateReferencesUsing: copier].
	^ new
]

{ #category : '*FromScratch' }
Morph >> initFieldsFrom: anObjStream version: classVersion [
	"Set my instance variables from the given object stream."

	self initFieldsNamed: #(
		bounds
		owner
		submorphs
		color
		flags
	) from: anObjStream.
	anObjStream nextField.  "placeholder for properties"
	fullBounds := nil.

]

{ #category : '*FromScratch' }
Morph >> isArgMorph [
	"True only for ArgMorphs."

	^ false

]

{ #category : '*FromScratch' }
Morph >> isBlockMorph [
	"True only for BlockMorphs."

	^ false

]

{ #category : '*FromScratch' }
Morph >> isBlockPalette [
	^ false
]

{ #category : '*FromScratch' }
Morph >> isCommandBlock [
	^ false
]

{ #category : '*FromScratch' }
Morph >> isCommentMorph [
	^ false
]

{ #category : '*FromScratch' }
Morph >> isScriptEditor [
	^ false
]

{ #category : '*FromScratch' }
Morph >> isStageMorph [
	^ false
]

{ #category : '*FromScratch' }
Morph >> mayNeedLayout [
	"Answer true if something has occured that might require my layout to change That is, if layoutChanged has been sent to me or any of my submorphs."

	^ fullBounds isNil

]

{ #category : '*FromScratch' }
Morph >> meOrOwnerThatIsA: aClass [
	"Answer this the first morph in the owner chain of the given class, or nil if there isn't one."

	| current |
	current := self.
	[ current == nil ]
		whileFalse: [ 
			(current isKindOf: aClass)
				ifTrue: [ ^ current ].
			current := current owner ].
	^ current
]

{ #category : '*FromScratch' }
Morph >> project [
	^ nil
]

{ #category : '*FromScratch' }
Morph >> rootForGrabOf: aMorph [
	"Answer the root of the morph structure to be picked up when the given morph is grabbed."

	self isSticky
		ifTrue: [ ^ nil ].
	(owner isNil or: [ owner isWorldOrHandMorph ])
		ifTrue: [ ^ self ].
	owner allowSubmorphExtraction
		ifTrue: [ ^ self ].
	^ owner rootForGrabOf: aMorph
]

{ #category : '*FromScratch' }
Morph >> storeFieldsOn: anObjStream [

	self storeFieldsNamed: #(
		bounds
		owner
		submorphs
		color
		flags
	) on: anObjStream.
	anObjStream putField: nil.  "placeholder for properties"
]

{ #category : '*FromScratch' }
Morph >> updateReferencesUsing: deepCopier [
	"Update intra-morph references within a composite morph that has
been copied. For example, if a button refers to morph X in the orginal
composite then the copy of that button in the new composite should refer to
the copy of X in new composite, not the original X. This default
implementation updates the contents of any morph-bearing slot. It may be
overridden to avoid this behavior if so desired."

	| old |
	Morph instSize + 1 to: self class instSize do: [:i |
		old := self instVarAt: i.
		old isMorph ifTrue:
			[self instVarAt: i put: (deepCopier references at: old ifAbsent: [old])]].

	"map morph values in my properties list"
	self privateExtension: (extension veryDeepCopyWith: deepCopier)
]
