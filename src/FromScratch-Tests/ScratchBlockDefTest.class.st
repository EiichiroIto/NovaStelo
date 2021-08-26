"
A ScratchBlockSpecTest is a test class for testing the behavior of ScratchBlockSpec
"
Class {
	#name : #ScratchBlockDefTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ScratchBlockDefTest >> basicNewBlockDef [
	^ ScratchBlockDef basicNew
]

{ #category : #private }
ScratchBlockDefTest >> newBlockDef [
	^ ScratchBlockDef new
]

{ #category : #private }
ScratchBlockDefTest >> newScript [
	^ ScratchScript new
]

{ #category : #test }
ScratchBlockDefTest >> testAddCategoryColor [
	self testBlockColorFor
]

{ #category : #test }
ScratchBlockDefTest >> testAddSpecCategory [
	| sp ret |
	sp := self newBlockDef.
	sp addSpec: #- category: 'basic'.
	sp addSpec: #(a b) category: 'operators'.
	sp addSpec: #(c d) category: 'basic'.
	ret := sp privBlocks at: 'basic'.
	self assert: ret isCollection.
	self assert: ret size equals: 2.
	self assert: ret first equals: #-.
	self assertCollection: ret second equals: #(c d).
	ret := sp privBlocks at: 'operators'.
	self assert: ret isCollection.
	self assert: ret size equals: 1.
	self assertCollection: ret first equals: #(a b)
]

{ #category : #test }
ScratchBlockDefTest >> testAddUnknownCategories [
	| sp |
	sp := self newBlockDef.
	sp addSpec: #- category: 'basic'.
	sp addSpec: #(a b) category: 'operators'.
	sp addSpec: #(c d) category: 'basic'.
	sp addCategory: 'basic' color: Color red.
	self assertCollection: sp blockCategories equals: #(basic).
	sp addUnknownCategories.
	self assertCollection: sp blockCategories equals: #(basic operators).
	self assert: (sp blockColorFor: 'basic') equals: Color red.
	self assert: (sp blockColorFor: 'operators') equals: sp unknownCategoryColor
]

{ #category : #test }
ScratchBlockDefTest >> testBlockCategories [
	| sp ret |
	sp := self newBlockDef.
	sp addCategory: 'basic' color: Color red.
	sp addCategory: 'operators' color: Color blue.
	ret := sp blockCategories.
	self assertCollection: ret equals: #('basic' 'operators')
]

{ #category : #test }
ScratchBlockDefTest >> testBlockColorAt [
	| sp list |
	sp := self newBlockDef.
	sp addCategory: 'operators' color: Color blue.
	list := #(
			'sensing'
			('returned value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assert: (sp blockColorAt: #returnValue) equals: sp unknownCategoryColor.
	self assert: (sp blockColorAt: #+) equals: Color blue.
	self assert: (sp blockColorAt: #-) equals: Color blue
]

{ #category : #test }
ScratchBlockDefTest >> testBlockColorFor [
	| sp |
	sp := self newBlockDef.
	sp addCategory: 'operators' color: Color blue.
	sp addCategory: 'control' color: Color yellow.
	self assert: (sp blockColorFor: 'operators') equals: Color blue.
	self assert: (sp blockColorFor: 'basic') equals: sp unknownCategoryColor.
	self assert: (sp blockColorFor: 'control') equals: Color yellow
]

{ #category : #test }
ScratchBlockDefTest >> testBlockSpecAt [
	| sp list |
	sp := self newBlockDef.
	list := #(
			'sensing'
			('returned value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assertCollection: (sp blockSpecAt: #returnValue) equals: #('returned value' r #returnValue).
	self assertCollection: (sp blockSpecAt: #+) equals: #('%n + %n' r #+ #- #-).
	self assertCollection: (sp blockSpecAt: #-) equals: #('%n - %n' r #- #- #-)
]

{ #category : #test }
ScratchBlockDefTest >> testBlocksForScript [
	| sc def list ret |
	sc := self newScript.
	def := self newBlockDef.
	list := #(
			'sensing'
			('returned value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	def setupFrom: list.
	ret := def blocksFor: 'basic' script: sc.
	self assert: ret isEmpty.
	ret := def blocksFor: 'sensing' script: sc.
	self assert: ret size equals: 1.
	self assert: ret first commandSpec equals: 'returned value' localized
]

{ #category : #test }
ScratchBlockDefTest >> testInitialize [
	| sp |
	sp := self basicNewBlockDef.
	self deny: sp privBlockSpecs isDictionary.
	self deny: sp privBlockColors isDictionary.
	sp initialize.
	self assert: sp privBlockSpecs isDictionary.
	self assert: sp privBlockColors isDictionary
]

{ #category : #test }
ScratchBlockDefTest >> testIsCategory [
	| def |
	def := self newBlockDef.
	self deny: (def isCategory: #-).
	self deny: (def isCategory: #~).
	self deny: (def isCategory: #(a b)).
	self assert: (def isCategory: #+).
	self assert: (def isCategory: #basic).
	self assert: (def isCategory: #operators)
]

{ #category : #test }
ScratchBlockDefTest >> testIsSpacer [
	| def |
	def := self newBlockDef.
	self assert: (def isSpacer: #-).
	self assert: (def isSpacer: #~).
	self deny: (def isSpacer: #(a b)).
	self deny: (def isSpacer: #+).
	self deny: (def isSpacer: #basic).
	self deny: (def isSpacer: #operators)
]

{ #category : #test }
ScratchBlockDefTest >> testPrivBlockColors [
	| sp |
	sp := self newBlockDef.
	self assert: sp privBlockColors isDictionary
]

{ #category : #test }
ScratchBlockDefTest >> testPrivBlockSpecs [
	| sp |
	sp := self newBlockDef.
	self assert: sp privBlockSpecs isDictionary
]

{ #category : #test }
ScratchBlockDefTest >> testPrivBlocks [
	| sp |
	sp := self newBlockDef.
	self assert: sp privBlocks isDictionary
]

{ #category : #test }
ScratchBlockDefTest >> testPrivCategoryColors [
	| sp |
	sp := self newBlockDef.
	self assert: sp privCategoryColors isDictionary
]

{ #category : #test }
ScratchBlockDefTest >> testSetupFrom [
	| sp list |
	sp := self newBlockDef.
	self assert: sp privBlockSpecs isEmpty.
	self assert: sp privBlockColors isEmpty.
	sp addCategory: 'operators' color: Color blue.
	list := #(
			'sensing'
			('returned value'				r	returnValue)
			'operators'
			('%n + %n'						r	+ - -)
			('%n - %n'						r	- - -)).
	sp setupFrom: list.
	self assertCollection: (sp privBlockSpecs at: #returnValue) equals: #('returned value' r #returnValue).
	self assertCollection: (sp privBlockSpecs at: #+) equals: #('%n + %n' r #+ #- #-).
	self assertCollection: (sp privBlockSpecs at: #-) equals: #('%n - %n' r #- #- #-).
	self assert: (sp privBlockColors at: #returnValue) equals: sp unknownCategoryColor.
	self assert: (sp privBlockColors at: #+) equals: Color blue.
	self assert: (sp privBlockColors at: #-) equals: Color blue
]

{ #category : #test }
ScratchBlockDefTest >> testUnknownCategoryColor [
	| sp |
	sp := self newBlockDef.
	self assert: sp unknownCategoryColor equals: Color gray
]
