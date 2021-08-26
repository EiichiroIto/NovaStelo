Class {
	#name : #SpSteloTitle,
	#superclass : #SpPresenter,
	#instVars : [
		'labelName',
		'clearTurtleButton',
		'setupButton',
		'stopButton',
		'stepButton',
		'eventButton',
		'loopSlowButton',
		'loopButton',
		'clearPatchesButton'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #private }
SpSteloTitle class >> buttonWidth [
	^ 28 + 5
]

{ #category : #specs }
SpSteloTitle class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #labelName;
		add:
			(SpBoxLayout newHorizontal
				add: #clearTurtleButton;
				add: #clearPatchesButton;
				add: #setupButton;
				add: #stepButton;
				add: #stopButton;
				add: #eventButton;
				add: #loopSlowButton;
				add: #loopButton;
				yourself);
		yourself
]

{ #category : #accessing }
SpSteloTitle >> clearPatchesAction: aBlock [
	clearPatchesButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> clearTurtlesAction: aBlock [
	clearTurtleButton action: aBlock
]

{ #category : #initialization }
SpSteloTitle >> initializePresenters [
	labelName := self newLabel.
	labelName label: 'new project'.
	clearTurtleButton := self newButton.
	clearPatchesButton := self newButton.
	setupButton := self newButton.
	stopButton := self newButton.
	stepButton := self newButton.
	eventButton := self newButton.
	loopSlowButton := self newButton.
	loopButton := self newButton.
	self setupButtons.
	self focusOrder
		add: clearTurtleButton;
		add: clearPatchesButton;
		add: setupButton;
		add: stopButton;
		add: stepButton;
		add: eventButton;
		add: loopSlowButton;
		add: loopButton
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
	clearTurtleButton
		label: 'ClearT';
		icon: (ScratchTheme formAt: #clearTurtlesButtonGray);
		help: 'Clear turtles'.
	clearPatchesButton
		label: 'ClearP';
		icon: (ScratchTheme formAt: #clearGraphicsButtonGray);
		help: 'Clear patches'.
	setupButton
		label: 'Setup';
		icon: (ScratchTheme formAt: #setupButtonGray);
		help: 'Setup'.
	stopButton
		label: 'Stop';
		icon: (ScratchTheme formAt: #stopButtonGray);
		help: 'Stop'.
	stepButton
		label: 'Step';
		icon: (ScratchTheme formAt: #stepButtonGray);
		help: 'Step'.
	eventButton
		label: 'Event';
		icon: (ScratchTheme formAt: #eventButtonGray);
		help: 'Event'.
	loopSlowButton
		label: 'Slowly';
		icon: (ScratchTheme formAt: #loopSlowButtonGray);
		help: 'Loop slowly'.
	loopButton
		label: 'Loop';
		icon: (ScratchTheme formAt: #loopButtonGray);
		help: 'Loop'
]

{ #category : #accessing }
SpSteloTitle >> startEventAction: aBlock [
	eventButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> startLoopAction: aBlock [
	loopButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> startLoopSlowAction: aBlock [
	loopSlowButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> startSetupAction: aBlock [
	setupButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> stepLoopAction: aBlock [
	stepButton action: aBlock
]

{ #category : #accessing }
SpSteloTitle >> stopAllAction: aBlock [
	stopButton action: aBlock
]
