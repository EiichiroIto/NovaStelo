Class {
	#name : 'STurtlesVarDef',
	#superclass : 'VarDef',
	#category : 'Stelo-Model',
	#package : 'Stelo',
	#tag : 'Model'
}

{ #category : 'accessing' }
STurtlesVarDef class >> aliveFlagNo [
	^ 0
]

{ #category : 'accessing' }
STurtlesVarDef class >> colorVarNo [
	^ 1
]

{ #category : 'accessing' }
STurtlesVarDef class >> flagVarNo [
	^ 2
]

{ #category : 'accessing' }
STurtlesVarDef class >> headingVarNo [
	^ 5
]

{ #category : 'accessing' }
STurtlesVarDef class >> penDownFlagNo [
	^ 1
]

{ #category : 'accessing' }
STurtlesVarDef class >> xVarNo [
	^ 3
]

{ #category : 'accessing' }
STurtlesVarDef class >> yVarNo [
	^ 4
]

{ #category : 'private' }
STurtlesVarDef >> setupReservedVarNames [
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
