Class {
	#name : #SDiffuser,
	#superclass : #Object,
	#category : #'Stelo-Model'
}

{ #category : #benchmarking }
SDiffuser class >> benchmarkDiffuse [
	| a d |
	a := FloatArray new: 10000.
	a at: 50 put: 5000.
	d := self new.
	^ Time
		millisecondsToRun: [ 1000
				timesRepeat: [ d
						diffuse8: a
						cols: 100
						rows: 100
						percent: 80 ] ]
]

{ #category : #benchmarking }
SDiffuser class >> benchmarkNsum [
	| a b d |
	a := FloatArray new: 10000.
	b := FloatArray new: 10000.
	a at: 50 put: 5000.
	d := self new.
	^ Time
		millisecondsToRun: [ 1000
				timesRepeat: [ d
						nsum8: a
						dst: b
						cols: 100
						rows: 100 ] ]
]

{ #category : #accessing }
SDiffuser class >> pluginOrNativeClass [
	^ SteloPlugin2 isAvailable
		ifTrue: [ SPluginDiffuser ]
		ifFalse: [ SNativeDiffuser ]
]

{ #category : #api }
SDiffuser >> diffuse4: anArray cols: anInteger2 rows: anInteger3 percent: aNumber [
	self subclassResponsibility
]

{ #category : #api }
SDiffuser >> diffuse8: anArray cols: anInteger2 rows: anInteger3 percent: aNumber [
	self subclassResponsibility
]

{ #category : #api }
SDiffuser >> nsum4: anArray1 dst: anArray2 cols: anInteger3 rows: anInteger4 [
	self subclassResponsibility
]

{ #category : #api }
SDiffuser >> nsum8: anArray1 dst: anArray2 cols: anInteger3 rows: anInteger4 [
	self subclassResponsibility
]
