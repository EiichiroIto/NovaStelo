Class {
	#name : #STurtleVarDef,
	#superclass : #SBreedVarDef,
	#category : #'Stelo-Model'
}

{ #category : #accessing }
STurtleVarDef class >> aliveFlagNo [
	^ 0
]

{ #category : #accessing }
STurtleVarDef class >> colorVarNo [
	^ 1
]

{ #category : #accessing }
STurtleVarDef class >> flagVarNo [
	^ 2
]

{ #category : #accessing }
STurtleVarDef class >> headingVarNo [
	^ 5
]

{ #category : #accessing }
STurtleVarDef class >> penDownFlagNo [
	^ 1
]

{ #category : #accessing }
STurtleVarDef class >> xVarNo [
	^ 3
]

{ #category : #accessing }
STurtleVarDef class >> yVarNo [
	^ 4
]

{ #category : #private }
STurtleVarDef >> setupReservedVarNames [
	self
		addReserved: 'color'
		varNo: self class colorVarNo
		className: #ByteArray.
	self
		addReserved: 'flag'
		varNo: self class flagVarNo
		className: #ByteArray.
	self addReservedVariable: 'x' varNo: self class xVarNo.
	self addReservedVariable: 'y' varNo: self class yVarNo.
	self addReservedVariable: 'heading' varNo: self class headingVarNo.
	self setupVarNames
]
