Class {
	#name : #BaseId,
	#superclass : #Object,
	#instVars : [
		'nextNo'
	],
	#category : #'Microworld-Core'
}

{ #category : #private }
BaseId class >> defaultUserNo [
	^ self reservedNo + 1
]

{ #category : #private }
BaseId class >> reservedNo [
	^ 0
]

{ #category : #'object i/o' }
BaseId >> fieldsVersion [
	^ 1
]

{ #category : #'object i/o' }
BaseId >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(nextNo) from: anObjStream.
]

{ #category : #initialization }
BaseId >> initialize [
	super initialize.
	self rewind.
]

{ #category : #accessing }
BaseId >> newNo [
	| v |
	v := nextNo.
	nextNo := nextNo + 1.
	^ v
]

{ #category : #private }
BaseId >> privNextNo [
	^ nextNo
]

{ #category : #private }
BaseId >> privNextNo: anInteger [
	nextNo := anInteger
]

{ #category : #accessing }
BaseId >> rewind [
	nextNo := self class defaultUserNo.
]

{ #category : #accessing }
BaseId >> size [
	^ nextNo - 1
]

{ #category : #'object i/o' }
BaseId >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(nextNo) on: anObjStream.
]

{ #category : #accessing }
BaseId >> userDefinedVarNos [
	^ (self class defaultUserNo to: self size) asArray
]
