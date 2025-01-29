Class {
	#name : 'SteloPlotsImporter',
	#superclass : 'ScratchImporter',
	#category : 'Stelo-Converter',
	#package : 'Stelo',
	#tag : 'Converter'
}

{ #category : 'acccessing' }
SteloPlotsImporter >> import: aString to: anApplication [
	| plotter arr x |
	plotter := anApplication plotter.
	x := plotter numData.
	arr := self plotsFrom: aString.
	arr
		withIndexDo: [ :each :index | plotter plot: x + index list: each ].
	plotter updateCache
]

{ #category : 'private' }
SteloPlotsImporter >> plotsFrom: aString [
	| result |
	result := Array new.
	aString
		linesDo: [ :line | 
			(line splitOn: $,)
				withIndexDo: [ :each :index | 
					index > result size
						ifTrue: [ result := result grownBy: index - result size.
							result at: index put: OrderedCollection new ].
					each isEmpty
						ifFalse: [ (result at: index) add: each asNumberNoError ] ] ].
	^ result
]
