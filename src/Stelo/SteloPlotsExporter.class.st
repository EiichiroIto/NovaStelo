Class {
	#name : #SteloPlotsExporter,
	#superclass : #ScratchExporter,
	#category : #'Stelo-Converter'
}

{ #category : #private }
SteloPlotsExporter >> writeFooter: aProject [
	"do nothing"
]

{ #category : #private }
SteloPlotsExporter >> writeHeader: aProject [
	| plotter size |
	plotter := aProject application plotter.
	size := plotter pens size.
	plotter data
		do: [ :each | 
			(each forceTo: size paddingWith: nil)
				do: [ :each2 | each2 ifNotNil: [ stream nextPutAll: each2 asString ] ]
				separatedBy: [ stream nextPut: $, ].
			stream crlf ]
]

{ #category : #private }
SteloPlotsExporter >> writeScript: aScript [
	"do nothing"
]
