Class {
	#name : #SpSteloStage,
	#superclass : #SpPresenter,
	#instVars : [
		'display'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #specs }
SpSteloStage class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #display;
		yourself
]

{ #category : #accessing }
SpSteloStage >> display [
	^ display morph
]

{ #category : #initialization }
SpSteloStage >> initializePresenters [
	display := self newMorph.
	display morph: SDisplay new.
	"self focusOrder
		add: buttonZoomIn;
		add: buttonZoomFit;
		add: buttonZoomOut"
]

{ #category : #accessing }
SpSteloStage >> startStepping [
	self display startStepping
]
