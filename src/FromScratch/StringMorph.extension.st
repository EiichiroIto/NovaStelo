Extension { #name : #StringMorph }

{ #category : #'*FromScratch' }
StringMorph >> drawOn: aCanvas [
	| bnd gap |
	bnd := self bounds.
	gap := self layoutInset.
	bnd := (bnd topLeft + gap) corner: (bnd bottomRight + gap).
	aCanvas drawString: contents in: bnd font: self fontToUse color: color.
]

{ #category : #'*FromScratch' }
StringMorph >> fieldsVersion [
	^ 1
]

{ #category : #'*FromScratch' }
StringMorph >> initFieldsFrom: anObjStream version: classVersion [

	| fontSpec |
	super initFieldsFrom: anObjStream version: classVersion.
	fontSpec := anObjStream nextField.
	fontSpec ifNotNil: [
		font := StrikeFont fontName: fontSpec first size: fontSpec second].

	self initFieldsNamed: #(
		emphasis
		contents
	) from: anObjStream.

]

{ #category : #'*FromScratch' }
StringMorph >> isArgMorph [
	^ false
]

{ #category : #'*FromScratch' }
StringMorph >> isBlockMorph [
	^ false
]

{ #category : #'*FromScratch' }
StringMorph >> leftMargin [
	"Answer the left edge of this StringMorph. For a left-justified string, this the left edge of its bounding box, but for a right-justified string it may be inset."

	^ self left "+ (self justificationOffsetFor: contents)"
]

{ #category : #'*FromScratch' }
StringMorph >> storeFieldsOn: anObjStream [

	"self closeEditor."
	super storeFieldsOn: anObjStream.
	font
		ifNil: [anObjStream putField: nil]
		ifNotNil: [anObjStream putField: (Array with: font familyName with: font pointSize)].
	self storeFieldsNamed: #(
		emphasis
		contents
	) on: anObjStream.

]

{ #category : #'*FromScratch' }
StringMorph >> stringHeight: aString [
	^ (font ifNil: [ TextStyle defaultFont ]) height ceiling
]

{ #category : #'*FromScratch' }
StringMorph >> stringToDisplay [
	"Answer the string that is displayed. In password mode, this will be all asterisks."

	^ contents
]

{ #category : #'*FromScratch' }
StringMorph >> stringWidth: aString [
	^(((self fontToUse widthOfString: aString) max: self minimumWidth) + (self layoutInset * 2)) ceiling
]

{ #category : #'*FromScratch' }
StringMorph >> xRangesFor: s [
	"Anwer an array of (leftX, rightX) pairs for the given string. For Unicode, there will be an entry in the resulting array for each UTF character in the input string, even when characters combine, so the x ranges for characters may overlap."
	"StringMorph new xRangesFor: 'Hello' asUTF8"

	^ self font xRangesFor: s

]
