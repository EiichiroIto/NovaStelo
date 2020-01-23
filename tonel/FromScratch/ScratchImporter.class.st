Class {
	#name : #ScratchImporter,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'FromScratch-Converter'
}

{ #category : #acccessing }
ScratchImporter >> import: aString to: anApplication [
	self subclassResponsibility.
]
