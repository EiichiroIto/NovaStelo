Class {
	#name : 'SNativeDiffuser2',
	#superclass : 'Object',
	#category : 'Stelo-Model',
	#package : 'Stelo',
	#tag : 'Model'
}

{ #category : 'api' }
SNativeDiffuser2 >> diffuse4: anArray cols: anInteger rows: anInteger2 percent: aNumber [
	| result tmp sz |
	sz := anArray size.
	tmp := anArray class ofSize: sz.
	result := anArray copy.
	result *= ((100 - aNumber) / 100.0).
	anArray *= (aNumber / 400.0).
	self rolledLeft: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledRight: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledUp: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledDown: anArray to: tmp cols: anInteger.
	result += tmp.
	anArray
		replaceFrom: 1
		to: anArray size
		with: result
		startingAt: 1
]

{ #category : 'api' }
SNativeDiffuser2 >> diffuse8: anArray cols: anInteger rows: anInteger2 percent: aNumber [
	| result tmp tmp3 sz |
	sz := anArray size.
	tmp := anArray class ofSize: sz.
	tmp3 := anArray class ofSize: sz.
	result := anArray copy.
	result *= ((100 - aNumber) / 100.0).
	anArray *= (aNumber / 800.0).
	self rolledLeft: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledUp: tmp to: tmp3 cols: anInteger.
	result += tmp3.
	self rolledUp: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledRight: tmp to: tmp3 cols: anInteger.
	result += tmp3.
	self rolledRight: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledDown: tmp to: tmp3 cols: anInteger.
	result += tmp3.
	self rolledDown: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledLeft: tmp to: tmp3 cols: anInteger.
	result += tmp3.
	anArray
		replaceFrom: 1
		to: anArray size
		with: result
		startingAt: 1
]

{ #category : 'api' }
SNativeDiffuser2 >> nsum4: anArray dst: anArray2 cols: anInteger rows: anInteger2 [
	| result tmp sz |
	sz := anArray size.
	tmp := anArray class ofSize: sz.
	result := anArray class ofSize: sz.
	self rolledLeft: anArray to: result cols: anInteger.
	self rolledRight: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledUp: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledDown: anArray to: tmp cols: anInteger.
	result += tmp.
	anArray2
		replaceFrom: 1
		to: anArray size
		with: result
		startingAt: 1
]

{ #category : 'api' }
SNativeDiffuser2 >> nsum8: anArray dst: anArray2 cols: anInteger rows: anInteger4 [
	| result tmp tmp2 sz |
	sz := anArray size.
	tmp := anArray class ofSize: sz.
	tmp2 := anArray class ofSize: sz.
	result := anArray class ofSize: sz.
	self rolledLeft: anArray to: result cols: anInteger.
	self rolledUp: result to: tmp cols: anInteger.
	result += tmp.
	self rolledUp: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledRight: tmp to: tmp2 cols: anInteger.
	result += tmp2.
	self rolledRight: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledDown: tmp to: tmp2 cols: anInteger.
	result += tmp2.
	self rolledDown: anArray to: tmp cols: anInteger.
	result += tmp.
	self rolledLeft: tmp to: tmp2 cols: anInteger.
	result += tmp2.
	anArray2
		replaceFrom: 1
		to: anArray size
		with: result
		startingAt: 1
]

{ #category : 'private' }
SNativeDiffuser2 >> rolledDown: anArray to: anArray2 cols: anInteger [
	| sz |
	sz := anArray size.
	anArray2
		replaceFrom: anInteger + 1
		to: sz
		with: anArray
		startingAt: 1.
	anArray2
		replaceFrom: 1
		to: anInteger
		with: anArray
		startingAt: sz - anInteger + 1
]

{ #category : 'private' }
SNativeDiffuser2 >> rolledLeft: anArray to: anArray2 cols: anInteger [
	| sz src dst |
	sz := anArray size.
	anArray2
		replaceFrom: 1
		to: sz - 1
		with: anArray
		startingAt: 2.
	src := 1.
	dst := anInteger.
	sz // anInteger
		timesRepeat: [ anArray2 at: dst put: (anArray at: src).
			src := src + anInteger.
			dst := dst + anInteger ]
]

{ #category : 'private' }
SNativeDiffuser2 >> rolledRight: anArray to: anArray2 cols: anInteger [
	| sz src dst |
	sz := anArray size.
	anArray2
		replaceFrom: 2
		to: sz
		with: anArray
		startingAt: 1.
	src := anInteger.
	dst := 1.
	sz // anInteger
		timesRepeat: [ anArray2 at: dst put: (anArray at: src).
			src := src + anInteger.
			dst := dst + anInteger ]
]

{ #category : 'private' }
SNativeDiffuser2 >> rolledUp: anArray to: anArray2 cols: anInteger [
	| sz |
	sz := anArray size.
	anArray2
		replaceFrom: 1
		to: sz - anInteger
		with: anArray
		startingAt: anInteger + 1.
	anArray2
		replaceFrom: sz - anInteger + 1
		to: sz
		with: anArray
		startingAt: 1
]

{ #category : 'api' }
SNativeDiffuser2 >> scale: aFloatArray dst: aByteArray color: baseColor from: anInteger to: anInteger5 [
	| c |
	aFloatArray
		withIndexDo: [ :each :index | 
			c := ColorList
				scaleValue: each
				color: baseColor
				from: anInteger
				to: anInteger5.
			aByteArray at: index put: c ]
]
