Class {
	#name : #SteloPlugin2Library,
	#superclass : #FFILibrary,
	#category : #'Stelo-Plugins2'
}

{ #category : #'accessing platform' }
SteloPlugin2Library >> macModuleName [
	^ 'SteloPlugin2.so'
]

{ #category : #'accessing platform' }
SteloPlugin2Library >> unixModuleName [
	^ 'SteloPlugin2.so'
]

{ #category : #'accessing platform' }
SteloPlugin2Library >> win32ModuleName [
	^ 'SteloPlugin2.dll'
]
