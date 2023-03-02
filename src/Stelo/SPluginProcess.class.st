Class {
	#name : #SPluginProcess,
	#superclass : #SteloProcess,
	#category : #'Stelo-Plugins'
}

{ #category : #testing }
SPluginProcess >> isRunning [
	^ sworld plugin isRunning
]

{ #category : #api }
SPluginProcess >> loop [
	sworld plugin loop.
]

{ #category : #api }
SPluginProcess >> program: aProgram [
	super program: aProgram.
	sworld setProgram: program.
]

{ #category : #api }
SPluginProcess >> single [
	sworld plugin single.
]

{ #category : #api }
SPluginProcess >> startup [
	sworld plugin startup.
]

{ #category : #api }
SPluginProcess >> step [
	sworld plugin step.
]

{ #category : #api }
SPluginProcess >> stop [
	sworld plugin stop.
]
