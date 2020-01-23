Class {
	#name : #SpSteloTitle,
	#superclass : #SpPresenter,
	#instVars : [
		'labelName',
		'toolBar'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #private }
SpSteloTitle class >> buttonWidth [
	^ 28 + 5
]

{ #category : #specs }
SpSteloTitle class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #labelName;
		add: #toolBar;
		yourself
]

{ #category : #private }
SpSteloTitle >> buttonNamed: aString [
	^ toolBar items detect: [ :each | each label = aString ]
]

{ #category : #accessing }
SpSteloTitle >> clearPatchesAction: aBlock [
	(self buttonNamed: 'ClearP') action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> clearTurtlesAction: aBlock [
	(self buttonNamed: 'ClearT') action: aBlock
]

{ #category : #initialization }
SpSteloTitle >> initializePresenters [
	labelName := self newLabel.
	toolBar := self newToolBar.
	labelName label: 'new project'.
	self setupButtons.
	self focusOrder add: toolBar
]

{ #category : #accessing }
SpSteloTitle >> projectName [
	^ labelName label asString
]

{ #category : #accessing }
SpSteloTitle >> projectName: aString [
	labelName label: aString asString
]

{ #category : #private }
SpSteloTitle >> setupButtons [
	toolBar
		addItem:
			(SpToolBarButton new
				label: 'ClearT';
				icon: (ScratchTheme formAt: #clearTurtlesButtonGray);
				help: 'Clear turtles');
		addItem:
			(SpToolBarButton new
				label: 'ClearP';
				icon: (ScratchTheme formAt: #clearGraphicsButtonGray);
				help: 'Clear patches');
		addItem:
			(SpToolBarButton new
				label: 'Setup';
				icon: (ScratchTheme formAt: #setupButtonGray);
				help: 'Setup');
		addItem:
			(SpToolBarButton new
				label: 'Stop';
				icon: (ScratchTheme formAt: #stopButtonGray);
				help: 'Stop');
		addItem:
			(SpToolBarButton new
				label: 'Step';
				icon: (ScratchTheme formAt: #stepButtonGray);
				help: 'Step');
		addItem:
			(SpToolBarButton new
				label: 'Slowly';
				icon: (ScratchTheme formAt: #loopSlowButtonGray);
				help: 'Loop slowly');
		addItem:
			(SpToolBarButton new
				label: 'Loop';
				icon: (ScratchTheme formAt: #loopButtonGray);
				help: 'Loop')
]

{ #category : #accessing }
SpSteloTitle >> startLoopAction: aBlock [
	(self buttonNamed: 'Loop') action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> startLoopSlowAction: aBlock [
	(self buttonNamed: 'Slowly') action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> startSetupAction: aBlock [
	(self buttonNamed: 'Setup') action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> stepLoopAction: aBlock [
	(self buttonNamed: 'Step') action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> stopAllAction: aBlock [
	(self buttonNamed: 'Stop') action: aBlock
]
