Class {
	#name : #ScTestBlock,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'FromScratch-Tests'
}

{ #category : #accessing }
ScTestBlock >> project [

	^ project
]

{ #category : #accessing }
ScTestBlock >> project: anObject [

	project := anObject
]