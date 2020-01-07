Class {
	#name : #ScTestScript,
	#superclass : #ScratchScript,
	#category : #'FromScratch-Tests'
}

{ #category : #accessing }
ScTestScript >> objName [
	^ 'test'
]

{ #category : #'argument menus' }
ScTestScript >> varNames [
	^ #(a 'b c')
]
