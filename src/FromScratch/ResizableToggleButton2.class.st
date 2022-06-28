Class {
	#name : #ResizableToggleButton2,
	#superclass : #SimpleButtonMorph,
	#instVars : [
		'label2',
		'iconMorph',
		'current',
		'normal',
		'pressed',
		'over',
		'labelColorOff',
		'labelColorOn',
		'labelColorOver',
		'isOn',
		'wasOn',
		'toggleMode',
		'toggleButtonMode',
		'justification',
		'padding',
		'hOffset',
		'vOffset'
	],
	#category : #'FromScratch-Morphic'
}

{ #category : #accessing }
ResizableToggleButton2 >> action [

	^ actionSelector

]

{ #category : #accessing }
ResizableToggleButton2 >> color [

	current ifNil: [^ Color white].
	^ current color

]

{ #category : #'event handling' }
ResizableToggleButton2 >> copyRecordingIn: dict [
	"Copy frame morphs for all states."

	| result |
	result := super copyRecordingIn: dict.
	normal ifNotNil: [result normal: (normal copyRecordingIn: dict)].
	pressed ifNotNil: [result pressed: (pressed copyRecordingIn: dict)].
	over ifNotNil: [result over: (over copyRecordingIn: dict)].
	^ result
]

{ #category : #geometry }
ResizableToggleButton2 >> extent: aPoint [

	super extent: aPoint.
	current ifNotNil: [current extent: aPoint].
	self updateLayout.
	iconMorph ifNotNil: [
		iconMorph position: self position + ((self extent - iconMorph extent) // 2)].

]

{ #category : #'event handling' }
ResizableToggleButton2 >> handlesMouseOver: evt [
	
	^ true

]

{ #category : #accessing }
ResizableToggleButton2 >> icon: aForm [
	"Add an icon to this button."

	iconMorph ifNotNil: [iconMorph delete].  "delete old icon"
	iconMorph := ImageMorph new form: aForm.
	self addMorph: iconMorph.
	self extent: (iconMorph extent + 10).


]

{ #category : #initialization }
ResizableToggleButton2 >> initialize [

	super initialize.
	self cornerStyle: #square.
	color := Color transparent.
	borderWidth := 0.
	isOn := false.
	toggleButtonMode := false.
	toggleMode := true.
	justification := #center.
	hOffset := 0.
	vOffset := 5.
	padding := 8@8.

	label2 := StringMorph new.
	labelColorOff := Color r: (78/255) g: (82/255) b: (82/255).
	labelColorOn := Color black.
	labelColorOver := labelColorOff.

]

{ #category : #accessing }
ResizableToggleButton2 >> isOn [

	^ isOn

]

{ #category : #'event handling' }
ResizableToggleButton2 >> keyStroke: evt [

	| ch m |
	ch := evt unicodeChar.
	ch = 0 ifTrue: [ch := evt keyValue].

	ch = 9 ifTrue: [  "tab"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m tabToNextField: evt]."
		^ self].

	ch = 27 ifTrue: [  "escape key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [m escapeKeyPressed: evt]."
		^ self].

	(ch = 10) | (ch = 13) ifTrue: [  "cr, lf, or enter key"
		"(m := self meOrOwnerThatIsA: DialogBoxMorph) ifNotNil: [^ m enterKeyPressed: evt]."
		evt hand newKeyboardFocus: nil.
		^ self].


]

{ #category : #'event handling' }
ResizableToggleButton2 >> keyboardFocusChange: aBoolean [

	aBoolean
		ifTrue: [self on]
		ifFalse: [self off].


]

{ #category : #accessing }
ResizableToggleButton2 >> label [

	^ label2

]

{ #category : #initialization }
ResizableToggleButton2 >> label: aString font: font [

	label2 delete.
	label2
		contents: aString;
		font: font;
		color: (isOn ifTrue: [labelColorOn] ifFalse: [labelColorOff]).
	self addMorphFront: label2.
	self updateSize.

]

{ #category : #private }
ResizableToggleButton2 >> labelColorOn: onColor labelColorOff: offColor labelColorOver: overColor [
	
	labelColorOn := onColor.
	labelColorOff := offColor.
	labelColorOver := overColor.
	isOn ifTrue: [ label2 color: onColor ] ifFalse: [ label2 color: offColor ].

]

{ #category : #'event handling' }
ResizableToggleButton2 >> mouseDown: evt [

	"evt hand toolType: nil."
	wasOn := isOn.

	evt hand newKeyboardFocus: nil.

	"evt yellowButtonPressed ifTrue: [
		Sensor waitNoButton.
		^ self rightButtonMenu]."

	toggleButtonMode
		ifTrue: [
			toggleMode
				ifTrue: [
					isOn
						ifTrue: [isOn := false. self over]
						ifFalse: [self on]]

				ifFalse: [
					isOn
						ifTrue: [^ self]
						ifFalse: [self on]]]
		ifFalse: [self on].

	actWhen = #buttonDown ifTrue: [
		self doButtonAction.
		self off].

]

{ #category : #'event handling' }
ResizableToggleButton2 >> mouseEnter: evt [

	self over.

]

{ #category : #'event handling' }
ResizableToggleButton2 >> mouseLeave: evt [

	isOn ifFalse: [ over ifNotNil: [self off] ].

]

{ #category : #'event handling' }
ResizableToggleButton2 >> mouseMove: evt [
 
	| containsPoint |
	actWhen = #buttonDown ifTrue: [^ self].

	containsPoint := self containsPoint: evt cursorPoint.
	toggleButtonMode
		ifFalse: [
			containsPoint
				ifTrue: [isOn ifFalse: [self on]]
				ifFalse: [isOn ifTrue: [self off]]]
		ifTrue: [
			toggleMode
				ifTrue: [
					containsPoint
						ifTrue: [
							wasOn
								ifTrue: [isOn ifTrue: [isOn := false. self over]]
								ifFalse: [isOn ifTrue: [^ self] ifFalse: [self on]]]
						ifFalse: [
							wasOn
								ifTrue: [isOn ifFalse: [self on]]
								ifFalse: [isOn ifTrue: [self off]]]]
				ifFalse: [
					containsPoint
						ifTrue: [
							wasOn
								ifTrue: [^ self]
								ifFalse: [isOn ifFalse: [self on]]]
						ifFalse: [
							wasOn
								ifTrue: [^ self]
								ifFalse: [isOn ifTrue: [isOn := false. self over]]]]].

]

{ #category : #'event handling' }
ResizableToggleButton2 >> mouseUp: evt [
	
	(actWhen = #buttonUp and:
	 [self containsPoint: evt cursorPoint])
		ifTrue: [self doButtonAction].

	toggleButtonMode ifFalse: [ self off ].

]

{ #category : #private }
ResizableToggleButton2 >> normal: aMorph [

	normal := aMorph.

]

{ #category : #accessing }
ResizableToggleButton2 >> off [
	"Turn myself off."

	isOn := false.
	self setCurrent: normal.
	label2 color: labelColorOff.


]

{ #category : #initialization }
ResizableToggleButton2 >> offForm: offForm onForm: onForm [

	normal := ImageFrameMorph new initFromForm: offForm.
	pressed := ImageFrameMorph new initFromForm: onForm.
	over := nil.
	current := normal.
	padding := normal minExtent - (0@5).

	toggleMode := false.
	self off.


]

{ #category : #accessing }
ResizableToggleButton2 >> on [
	"Turn myself on."

	isOn := true.
	self setCurrent: pressed.
	label2 color: labelColorOn.


]

{ #category : #accessing }
ResizableToggleButton2 >> over [
	"Show my over skin."

	"toggleButtonMode ifFalse: [^ self]."
	isOn ifTrue: [^ self].
	over ifNil: [^ self].

	self setCurrent: over.
	label2 color: labelColorOver.

]

{ #category : #private }
ResizableToggleButton2 >> over: aMorph [

	over := aMorph.

]

{ #category : #accessing }
ResizableToggleButton2 >> padding: aPoint [

	padding := aPoint.

]

{ #category : #private }
ResizableToggleButton2 >> pressed: aMorph [

	pressed := aMorph.

]

{ #category : #private }
ResizableToggleButton2 >> setCurrent: aMorph [
	"Make the given morph be the one currently displayed."

	aMorph ifNil: [^ self].  "should not happen"
	aMorph
		position: self position;
		extent: self extent.

	current delete.
	current := aMorph.
	self addMorphBack: current.


]

{ #category : #initialization }
ResizableToggleButton2 >> setDefaultLabel [
	"Overridden to do nothing. I have no label by default, although a label can be added."

]

{ #category : #accessing }
ResizableToggleButton2 >> toggleMode: mode [
	"The same as ToggleButton's toggleMode. If set to true, clicking the button when turns it from on to off. If false, clicking the button when on does nothing."

	toggleMode := mode.

]

{ #category : #private }
ResizableToggleButton2 >> updateLayout [
	"Update the label position within the button."

	| x y top |
	x := ((self width - label2 width) // 2) + hOffset.  "center by default"
	justification = #left ifTrue: [x := hOffset].
	justification = #right ifTrue: [x := self width - hOffset - label2 width].

	y := ((self height / 2) - vOffset) rounded.

	top := self top + 10.
	(self submorphs size = 2)
		ifTrue: [label2 position: self position + (x@y)]
		ifFalse: [self submorphs reversed do: [:m |
			(m isKindOf: ImageFrameMorph) ifFalse: [
				m left: self left + ((self width - m width) // 2).
				m top: top.
				top := m bottom + 6]]].

]

{ #category : #private }
ResizableToggleButton2 >> updateSize [
	"Set this button size based on the label size. Assume the label has already been set."

	| trim contentsExtent |
	trim := ScratchTranslator verticalTrimForFont: label2 font.
	contentsExtent := 0@0.
	self submorphsDo: [: m |
		(m isKindOf: ImageFrameMorph) ifFalse: [
			contentsExtent := (contentsExtent x max: m width)@(contentsExtent y + m height)]].
	self extent: contentsExtent + padding - (0@trim).
	vOffset := ScratchTranslator centerOffsetForButtonWithFont: label2 font.
	self updateLayout.

]
