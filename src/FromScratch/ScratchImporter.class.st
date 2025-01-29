Class {
	#name : 'ScratchImporter',
	#superclass : 'Object',
	#instVars : [
		'project'
	],
	#category : 'FromScratch-Converter',
	#package : 'FromScratch',
	#tag : 'Converter'
}

{ #category : 'accessing' }
ScratchImporter >> import: aString to: anApplication [
	self subclassResponsibility.
]
