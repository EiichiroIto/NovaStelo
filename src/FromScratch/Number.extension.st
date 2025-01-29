Extension { #name : 'Number' }

{ #category : '*FromScratch' }
Number >> asNumberNoError [

	^ self
]

{ #category : '*FromScratch' }
Number >> hhmmss [
	^ self rounded hhmmss
]
