Class {
	#name : #SPluginDiffuser,
	#superclass : #SDiffuser,
	#category : #'Stelo-Plugins2'
}

{ #category : #api }
SPluginDiffuser >> diffuse4: aFloatArray cols: anInteger rows: anInteger4 percent: aFloat [
	| buf |
	buf := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	[ buf fillFrom: aFloatArray with: [ :v | v ].
	self plugin
		extDiffuse4: buf
		percent: aFloat
		cols: anInteger
		rows: anInteger4.
	aFloatArray fillFrom: buf with: [ :v | v ] ]
		ensure: [ buf free ]
]

{ #category : #api }
SPluginDiffuser >> diffuse8: aFloatArray cols: anInteger rows: anInteger4 percent: aFloat [
	| buf |
	buf := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	[ buf fillFrom: aFloatArray with: [ :v | v ].
	self plugin
		extDiffuse8: buf
		percent: aFloat
		cols: anInteger
		rows: anInteger4.
	aFloatArray fillFrom: buf with: [ :v | v ] ]
		ensure: [ buf free ]
]

{ #category : #accessing }
SPluginDiffuser >> diffuserName [
	^ 'plugin diffuser'
]

{ #category : #api }
SPluginDiffuser >> nsum4: aFloatArray dst: aFloatArray2 cols: anInteger rows: anInteger4 [
	| src dst |
	src := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	dst := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	[ src fillFrom: aFloatArray with: [ :v | v ].
	self plugin
		extNsum4Src: src
		dst: dst
		cols: anInteger
		rows: anInteger4.
	aFloatArray2 fillFrom: dst with: [ :v | v ] ]
		ensure: [ src free.
			dst free ]
]

{ #category : #api }
SPluginDiffuser >> nsum8: aFloatArray dst: aFloatArray2 cols: anInteger rows: anInteger4 [
	| src dst |
	src := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	dst := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	[ src fillFrom: aFloatArray with: [ :v | v ].
	self plugin
		extNsum8Src: src
		dst: dst
		cols: anInteger
		rows: anInteger4.
	aFloatArray2 fillFrom: dst with: [ :v | v ] ]
		ensure: [ src free.
			dst free ]
]

{ #category : #private }
SPluginDiffuser >> plugin [
	^ SteloPlugin2 default
]

{ #category : #api }
SPluginDiffuser >> scale: aFloatArray dst: aByteArray color: baseColor from: anInteger to: anInteger5 [
	| src dst |
	src := FFIExternalArray
		externalNewType: 'float'
		size: aFloatArray size.
	dst := FFIExternalArray
		externalNewType: FFIUInt8
		size: aByteArray size.
	[ src fillFrom: aFloatArray with: [ :v | v ].
	self plugin
		extScaleColor: src
		dst: dst
		size: src size
		from: anInteger
		to: anInteger5
		baseColor: baseColor.
	aByteArray fillFrom: dst with: [ :v | v ] ]
		ensure: [ src free.
			dst free ]
]
