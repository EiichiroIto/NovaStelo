Class {
	#name : #SpSteloViewer,
	#superclass : #SpScratchViewer,
	#instVars : [
		'buttonBasic',
		'buttonControl',
		'buttonColor',
		'buttonPatch',
		'buttonOperators',
		'buttonVariables',
		'buttonSensing',
		'buttonPen'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #accessing }
SpSteloViewer class >> buttons [
	^ #(#(buttonBasic basic) #(buttonControl control) #(buttonColor color) #(buttonSensing sensing) #(buttonPatch patch) #(buttonOperators operators) #(buttonPen pen) #(buttonVariables variables))
]

{ #category : #initialization }
SpSteloViewer >> connectPresenters [
	buttonBasic action: [ self currentCategory: #basic ].
	buttonControl action: [ self currentCategory: #control ].
	buttonColor action: [ self currentCategory: #color ].
	buttonPatch action: [ self currentCategory: #patch ].
	buttonOperators action: [ self currentCategory: #operators ].
	buttonPen action: [ self currentCategory: #pen ].
	buttonVariables action: [ self currentCategory: #variables ].
	buttonSensing action: [ self currentCategory: #sensing ]
]

{ #category : #initialization }
SpSteloViewer >> setupButtons [
	buttonBasic := self newButton
		label: 'Basic';
		yourself.
	buttonControl := self newButton
		label: 'Control';
		yourself.
	buttonColor := self newButton
		label: 'Color';
		yourself.
	buttonSensing := self newButton
		label: 'Sensing';
		yourself.
	buttonPatch := self newButton
		label: 'Patch';
		yourself.
	buttonOperators := self newButton
		label: 'Operators';
		yourself.
	buttonPen := self newButton
		label: 'Pen';
		yourself.
	buttonVariables := self newButton
		label: 'Variables';
		yourself
]
