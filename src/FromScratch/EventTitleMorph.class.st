"
I am used as the title for a named event hat. I have a popup list of events that includes a way to type in a new event name.

Unlike other kind of ArgMorph, I can't be replaced with a reporter.


"
Class {
	#name : #EventTitleMorph,
	#superclass : #ArgMorph,
	#instVars : [
		'menuIconMorph'
	],
	#category : #'FromScratch-Blocks'
}

{ #category : #queries }
EventTitleMorph >> acceptsDroppedReporters [
	"Accept reporter blocks in broadcast blocks but not in 'when I receive' hat block."

	^ owner isKindOf: CommandBlockMorph

]

{ #category : #queries }
EventTitleMorph >> acceptsTypeOf: aBlockMorph [
	"Answer true if I can accept a dropped reporter of the given type."

	aBlockMorph isReporter ifFalse: [^ false].
	^ aBlockMorph isBooleanReporter not

]

{ #category : #'code generation' }
EventTitleMorph >> argString: aGenerator [
	^ aGenerator eventTitleArgString: self
]

{ #category : #accessing }
EventTitleMorph >> defaultValue: aString [

	self eventName: aString.

]

{ #category : #accessing }
EventTitleMorph >> evaluate [

	^ self eventName

]

{ #category : #accessing }
EventTitleMorph >> eventName [

	^ labelMorph contents

]

{ #category : #accessing }
EventTitleMorph >> eventName: aString [

	| block |
	labelMorph contents: aString asString.
	labelMorph position: self position + borderWidth + (3 @ -1).
	self extent: (labelMorph extent + (16@2) + borderWidth).
	menuIconMorph position: (self right - borderWidth - 10)@(self top + borderWidth + 4).

	(block := self meOrOwnerThatIsA: HatBlockMorph) ifNotNil: [
		block fixBlockLayout].

]

{ #category : #'object i/o' }
EventTitleMorph >> fieldsVersion [

	^ super fieldsVersion

]

{ #category : #accessing }
EventTitleMorph >> fixArgLayout [
	"Set my color to my owner's color."

	self color: (owner color mixed: 0.75 with: (Color gray: 0.4)).

]

{ #category : #'event handling' }
EventTitleMorph >> handlesMouseDown: evt [

	^ "evt hand toolType isNil and:
		["
		(self topRight - (14@0) corner: self bottomRight) containsPoint: evt cursorPoint
		"]"

]

{ #category : #initialization }
EventTitleMorph >> initialize [

	super initialize.
	self borderInset.
	self borderWidth: 1.
	self color: Color brown.

	menuIconMorph := ImageMorph new form: DropDownMenuForm.
	self addMorphFront: menuIconMorph.

	labelMorph := StringMorph new
		font: (ScratchTheme argFont);
		color: Color white.
	self addMorph: labelMorph.
	self eventName: ''.

]

{ #category : #'event handling' }
EventTitleMorph >> mouseDown: evt [

	self presentMenu.

]

{ #category : #'event handling' }
EventTitleMorph >> presentMenu [
	"Pop up a menu of choices."

	| eventNames project menu choice s |
	eventNames := #().
	(project := self project)
		ifNotNil: [ eventNames := project allEventNames ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	eventNames
		do: [ :n | menu add: n selector: #value: argument: n asString ].
	menu addLine.
	menu
		add: 'new' localized , ScratchTranslator ellipsesSuffix
		selector: #value:
		argument: #newEvent.
	menu invokeAt: ActiveHand position in: self world.
	choice ifNil: [ ^ self ].
	choice == #newEvent
		ifTrue: [ s := UIManager default request: 'Message name:'.
			(s isNil or: [ s isEmpty ])
				ifTrue: [ ^ self ].
			^ self eventName: s ].
	self eventName: choice
]

{ #category : #accessing }
EventTitleMorph >> printArgOn: aStream [
	"Print this argument morph on the given stream."

	aStream nextPut: $".
	aStream nextPutAll: self labelMorph contents.
	aStream nextPut: $".

]

{ #category : #'event handling' }
EventTitleMorph >> wantsKeyboardFocusFor: aSubmorph [
	"Don't allow shift-click editing of block labels."

	^ false

]
