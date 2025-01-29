"
I am used as the title for a named event hat. I have a popup list of events that includes a way to type in a new event name.

Unlike other kind of ArgMorph, I can't be replaced with a reporter.


"
Class {
	#name : 'EventTitleMorph',
	#superclass : 'ArgMorph',
	#instVars : [
		'menuIconMorph'
	],
	#category : 'FromScratch-Blocks',
	#package : 'FromScratch',
	#tag : 'Blocks'
}

{ #category : 'queries' }
EventTitleMorph >> acceptsDroppedReporters [
	"Accept reporter blocks in broadcast blocks but not in 'when I receive' hat block."

	^ owner notNil and: [ owner isCommandBlock ]
]

{ #category : 'queries' }
EventTitleMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not

]

{ #category : 'code generation' }
EventTitleMorph >> argString: aGenerator [
	^ aGenerator eventTitleArgString: self
]

{ #category : 'accessing' }
EventTitleMorph >> defaultValue: aString [

	self eventName: aString.

]

{ #category : 'accessing' }
EventTitleMorph >> evaluate [

	^ self eventName

]

{ #category : 'accessing' }
EventTitleMorph >> eventName [

	^ labelMorph contents

]

{ #category : 'accessing' }
EventTitleMorph >> eventName: aString [
	| block |
	labelMorph contents: aString asString.
	labelMorph position: self position + borderWidth + (3 @ -1).
	self extent: labelMorph extent + (16 @ 2) + borderWidth.
	menuIconMorph
		position: (self right - borderWidth - 10) @ (self top + borderWidth + 4).
	(block := self meOrOwnerThatIsA: HatBlockMorph)
		ifNotNil: [ block fixBlockLayout ]
]

{ #category : 'accessing' }
EventTitleMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.75 with: (Color gray: 0.4)).

]

{ #category : 'event handling' }
EventTitleMorph >> handlesMouseDown: evt [
	^ (self topRight - (14 @ 0) corner: self bottomRight)
		containsPoint: evt cursorPoint
]

{ #category : 'initialization' }
EventTitleMorph >> initialize [
	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.
	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.
	labelMorph := StringMorph new
		font: ScratchTranslator argFont;
		color: Color white.
	self addMorph: labelMorph.
	self eventName: ''
]

{ #category : 'event handling' }
EventTitleMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : 'event handling' }
EventTitleMorph >> presentMenu [

	"Pop up a menu of choices."

	| eventNames list choice |
	eventNames := { ('new' localized , ScratchTranslator ellipsesSuffix) }.
	self project ifNotNil: [ :project | 
		eventNames := eventNames , project allEventNames ].
	list := eventNames withIndexCollect: [ :each :i | 
		        Array with: each with: i ].
	choice := SpSelectDialog new
		          label: 'Select Message name' localized;
		          items: list;
		          display: [ :each | each first ];
		          openModal.
	choice ifNil: [ ^ self ].
	choice second = 1
		ifTrue: [ 
			choice := SpScratchPresenter request: 'Message name:' localized.
			(choice isNil or: [ choice isEmpty ]) ifTrue: [ ^ self ] ]
		ifFalse: [ choice := choice first ].
	self eventName: choice
]

{ #category : 'event handling' }
EventTitleMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]
