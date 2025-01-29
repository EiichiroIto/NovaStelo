Class {
	#name : 'SPatchesVarDef',
	#superclass : 'VarDef',
	#category : 'Stelo-Model',
	#package : 'Stelo',
	#tag : 'Model'
}

{ #category : 'accessing' }
SPatchesVarDef class >> colorVarNo [
	^ 1
]

{ #category : 'accessing' }
SPatchesVarDef class >> screenVarNo [
	^ 2
]

{ #category : 'accessing' }
SPatchesVarDef class >> xVarNo [
	^ 3
]

{ #category : 'accessing' }
SPatchesVarDef class >> yVarNo [
	^ 4
]

{ #category : 'private' }
SPatchesVarDef >> setupReservedVarNames [
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
