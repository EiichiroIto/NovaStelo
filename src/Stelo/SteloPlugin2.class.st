Class {
	#name : #SteloPlugin2,
	#superclass : #Object,
	#classInstVars : [
		'default'
	],
	#category : #'Stelo-Plugins2'
}

{ #category : #accessing }
SteloPlugin2 class >> default [
	^ default ifNil: [ default := self new ]
]

{ #category : #resources }
SteloPlugin2 class >> ffiLibrary [
	^ SteloPlugin2Library
]

{ #category : #testing }
SteloPlugin2 class >> isAvailable [
	^ [ self default getErrorMessage.
	true ] ifError: [ false ]
]

{ #category : #accessing }
SteloPlugin2 class >> reset [
	default := nil
]

{ #category : #private }
SteloPlugin2 >> extDiffuse4: buf percent: percent cols: cols rows: rows [
	self ffiCall: #(void diffuse4(FFIExternalArray buf, float percent, int cols, int rows))
]

{ #category : #private }
SteloPlugin2 >> extDiffuse8: buf percent: percent cols: cols rows: rows [
	self ffiCall: #(void diffuse8(FFIExternalArray buf, float percent, int cols, int rows))
]

{ #category : #private }
SteloPlugin2 >> extNsum4Src: src dst: dst cols: cols rows: rows [
	self ffiCall: #(void nsum4(FFIExternalArray src, FFIExternalArray dst, int cols, int rows))
]

{ #category : #private }
SteloPlugin2 >> extNsum8Src: src dst: dst cols: cols rows: rows [
	self ffiCall: #(void nsum8(FFIExternalArray src, FFIExternalArray dst, int cols, int rows))
]

{ #category : #resources }
SteloPlugin2 >> ffiLibrary [
	^ self class ffiLibrary
]

{ #category : #accessing }
SteloPlugin2 >> getErrorMessage [
	^ self ffiCall: #(String getError())
]
