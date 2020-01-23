Class {
	#name : #SteloLibrary,
	#superclass : #FFILibrary,
	#category : #'Stelo-Plugins'
}

{ #category : #'accessing platform' }
SteloLibrary >> macModuleName [
	^ 'stelo.so'
]

{ #category : #'accessing platform' }
SteloLibrary >> unixModuleName [
	^ 'stelo.so'
]

{ #category : #'accessing platform' }
SteloLibrary >> win32ModuleName [
	^ 'stelo64.dll'
]

{ #category : #'accessing platform' }
SteloLibrary >> winModuleName [
	^ 'stelo64.dll'
]
