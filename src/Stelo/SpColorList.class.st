Class {
	#name : #SpColorList,
	#superclass : #SpPresenter,
	#instVars : [
		'tableColors'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #layout }
SpColorList class >> defaultLayout [
	^ SpBoxLayout newVertical
		add: #tableColors;
		yourself
]

{ #category : #visiting }
SpColorList >> accept [
	self window triggerOkAction
]

{ #category : #private }
SpColorList >> colorMorphFor: aString [
	| cno |
	cno := SColorList colorOf: aString asSymbol.
	^ Morph new
		extent: 20 @ 20;
		color: (SColorList default realColorAt: cno);
		yourself
]

{ #category : #private }
SpColorList >> colorNameFor: anObject [
	^ anObject
]

{ #category : #initialization }
SpColorList >> connectPresenters [
	tableColors whenActivatedDo: [ self accept ]
]

{ #category : #initialization }
SpColorList >> initializePresenters [
	tableColors := self newTable.
	tableColors
		activateOnDoubleClick;
		addColumn:
			((SpImageTableColumn evaluated: [ :item | self colorMorphFor: item ])
				width: 30;
				yourself);
		addColumn:
			(SpStringTableColumn
				title: 'Name'
				evaluated: [ :o | self colorNameFor: o ]);
		items: SColorList colorNames
]

{ #category : #operations }
SpColorList >> selectedColor [
	^ SColorList colorOf: tableColors selection selectedItem
]
