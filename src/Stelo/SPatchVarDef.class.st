Class {
	#name : #SPatchVarDef,
	#superclass : #SBreedVarDef,
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SPatchVarDef class >> colorVarNo [
	^ 1
]

{ #category : #accessing }
SPatchVarDef class >> screenVarNo [
	^ 2
]

{ #category : #accessing }
SPatchVarDef class >> xVarNo [
	^ 3
]

{ #category : #accessing }
SPatchVarDef class >> yVarNo [
	^ 4
]

{ #category : #private }
SPatchVarDef >> setupReservedVarNames [
	self
		addReserved: 'color'
		varNo: self class colorVarNo
		className: #ByteArray.
	self
		addReserved: 'screen'
		varNo: self class screenVarNo
		className: #ByteArray.
	self addReservedVariable: 'x' varNo: self class xVarNo.
	self addReservedVariable: 'y' varNo: self class yVarNo.
	self setupVarNames
]
