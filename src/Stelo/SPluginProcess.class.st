Class {
	#name : #SPluginProcess,
	#superclass : #SteloProcess,
	#category : #'Stelo-Plugins'
}

{ #category : #testing }
SPluginProcess >> isRunning [
	^ sworld plugin isRunning
]

{ #category : #accessing }
SPluginProcess >> loop [
	sworld plugin loop.
]

{ #category : #accessing }
SPluginProcess >> program: aProgram [
	super program: aProgram.
	sworld setProgram: program.
]

{ #category : #accessing }
SPluginProcess >> single [
	sworld plugin single.
]

{ #category : #accessing }
SPluginProcess >> startup [
	sworld plugin startup.
]

{ #category : #accessing }
SPluginProcess >> step [
	sworld plugin step.
]

{ #category : #accessing }
SPluginProcess >> stop [
	sworld plugin stop.
]
