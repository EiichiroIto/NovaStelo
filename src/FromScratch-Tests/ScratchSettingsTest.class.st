"
A ScratchSettingsTest is a test class for testing the behavior of ScratchSettings
"
Class {
	#name : #ScratchSettingsTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchSettingsTest >> newObj [

	^ ScratchSettings new
]

{ #category : #test }
ScratchSettingsTest >> testAt [

	| obj |
	obj := self newObj.
	self deny: (obj at: #dontClose).
	obj dontClose: true.
	self assert: (obj at: #dontClose)
]

{ #category : #test }
ScratchSettingsTest >> testAtPut [

	| obj |
	obj := self newObj.
	obj at: #dontClose put: false.
	self deny: obj dontClose.
	obj at: #dontClose put: true.
	self assert: obj dontClose
]

{ #category : #test }
ScratchSettingsTest >> testDictionary [

	| obj d |
	obj := self newObj.
	self assert: obj dictionary isDictionary.
	d := Dictionary new.
	obj dictionary: d.
	self assert: obj dictionary identicalTo: d
]

{ #category : #test }
ScratchSettingsTest >> testDontClose [

	| obj |
	obj := self newObj.
	self deny: obj dontClose.
	obj dontClose: true.
	self assert: obj dontClose.
	obj dontClose: false.
	self deny: obj dontClose
]

{ #category : #test }
ScratchSettingsTest >> testFullscreen [

	| obj |
	obj := self newObj.
	self deny: obj fullscreen.
	obj fullscreen: true.
	self assert: obj fullscreen.
	obj fullscreen: false.
	self deny: obj fullscreen
]

{ #category : #test }
ScratchSettingsTest >> testHideDebugMenu [

	| obj |
	obj := self newObj.
	self deny: obj hideDebugMenu.
	obj hideDebugMenu: true.
	self assert: obj hideDebugMenu.
	obj hideDebugMenu: false.
	self deny: obj hideDebugMenu
]

{ #category : #test }
ScratchSettingsTest >> testInitialize [

	| obj |
	obj := self newObj.
	self deny: obj dontClose.
	self deny: obj keepMaximize.
	self deny: obj hideDebugMenu.
	self deny: obj stickyWindow.
	self deny: obj useErrorCatcher.
	self deny: obj fullscreen.
	self assert: obj resizable.
	self assert: obj projectDir isEmpty.
	self deny: obj useSingleClick
]

{ #category : #test }
ScratchSettingsTest >> testKeepMaximize [

	| obj |
	obj := self newObj.
	self deny: obj keepMaximize.
	obj keepMaximize: true.
	self assert: obj keepMaximize.
	obj keepMaximize: false.
	self deny: obj keepMaximize
]

{ #category : #test }
ScratchSettingsTest >> testKeys [

	| obj |
	obj := self newObj.
	self
		assertCollection: obj keys
		equals:
			#( dontClose fullscreen hideDebugMenu keepMaximize projectDir
			   resizable stickyWindow useErrorCatcher useSingleClick )
]

{ #category : #test }
ScratchSettingsTest >> testLanguage [

	| obj |
	obj := self newObj.
	self assert: obj language isEmpty.
	obj language: 'abc'.
	self assert: obj language equals: 'abc'
]

{ #category : #test }
ScratchSettingsTest >> testOptionsFor [

	| obj |
	obj := self newObj.
	self
		assertCollection: (obj optionsFor: #dontClose)
		equals: { true. false }
]

{ #category : #test }
ScratchSettingsTest >> testProjectDir [

	| obj |
	obj := self newObj.
	self assert: obj projectDir isEmpty.
	obj projectDir: 'abc'.
	self assert: obj projectDir equals: 'abc'
]

{ #category : #test }
ScratchSettingsTest >> testResizable [

	| obj |
	obj := self newObj.
	self assert: obj resizable.
	obj resizable: true.
	self assert: obj resizable.
	obj resizable: false.
	self deny: obj resizable
]

{ #category : #test }
ScratchSettingsTest >> testStickyWindow [

	| obj |
	obj := self newObj.
	self deny: obj stickyWindow.
	obj stickyWindow: true.
	self assert: obj stickyWindow.
	obj stickyWindow: false.
	self deny: obj stickyWindow
]

{ #category : #test }
ScratchSettingsTest >> testUseErrorCatcher [

	| obj |
	obj := self newObj.
	self deny: obj useErrorCatcher.
	obj useErrorCatcher: true.
	self assert: obj useErrorCatcher.
	obj useErrorCatcher: false.
	self deny: obj useErrorCatcher
]

{ #category : #test }
ScratchSettingsTest >> testUseSingleClick [

	| obj |
	obj := self newObj.
	self deny: obj useSingleClick.
	obj useSingleClick: true.
	self assert: obj useSingleClick.
	obj useSingleClick: false.
	self deny: obj useSingleClick
]
