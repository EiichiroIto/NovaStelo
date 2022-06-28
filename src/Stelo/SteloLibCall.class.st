Class {
	#name : #SteloLibCall,
	#superclass : #Object,
	#category : #'Stelo-Plugins'
}

{ #category : #constants }
SteloLibCall class >> byte [
	^ 2
]

{ #category : #constants }
SteloLibCall class >> computedFloat [
	^ 4
]

{ #category : #resources }
SteloLibCall class >> ffiLibrary [
	^ SteloLibrary
]

{ #category : #constants }
SteloLibCall class >> float [
	^ 1
]

{ #category : #constants }
SteloLibCall class >> none [
	^ 0
]

{ #category : #constants }
SteloLibCall class >> word [
	^ 3
]

{ #category : #'stelo funcs' }
SteloLibCall >> addEntryPoint: address eventNo: eno breedNo: bno [
	^ self ffiCall: #(bool addEntryPoint(int eno, int bno, int address))
]

{ #category : #'stelo funcs' }
SteloLibCall >> addVariable: vno breed: bno [
	^ self ffiCall: #(bool addVariable(int bno, int vno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> clearBreed: anInteger [
	^ self ffiCall: #(void clearBreed(int anInteger))
]

{ #category : #'stelo funcs' }
SteloLibCall >> clearErrorMessage [
	self ffiCall: #(void clearError()).
]

{ #category : #'stelo funcs' }
SteloLibCall >> create: bno turtles: size [
	self ffiCall: #(void createTurtles(int bno, int size)).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> createPatch: anInteger [
	self ffiCall: #(void createPatch(int anInteger)).
	self primitiveFailed
]

{ #category : #resources }
SteloLibCall >> ffiLibrary [
	^ self class ffiLibrary
]

{ #category : #'stelo funcs' }
SteloLibCall >> forward: step breed: bno id: index [
	self ffiCall: #(void forward(int bno, int index, float step))
]

{ #category : #'stelo funcs' }
SteloLibCall >> getByte: vno breed: bno id: tno [
	^ self ffiCall: #(byte getByte(int bno, int vno, int tno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> getByteAll: vno breed: bno [
	^ self ffiCall: #(byte *getByteAll(int bno, int vno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> getErrorMessage [
	^ self ffiCall: #(String getError())
]

{ #category : #'stelo funcs' }
SteloLibCall >> getFloat: vno breed: bno id: tno [
	^ self ffiCall: #(float getFloat(int bno, int vno, int tno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> getFloatAll: vno breed: bno [
	^ self ffiCall: #(ExternalAddress getFloatAll(int bno, int vno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> getScreen [
	^ self ffiCall: #(byte *getScreen())
]

{ #category : #'stelo funcs' }
SteloLibCall >> getType: vno breed: bno [
	^ self ffiCall: #(int getType(int bno, int vno))
]

{ #category : #'stelo funcs' }
SteloLibCall >> isRunning [
	^ self ffiCall: #(bool isRunning())
]

{ #category : #'stelo funcs' }
SteloLibCall >> loop [
	self ffiCall: #(void loop()).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> parseProgram: aString [
	self ffiCall: #(void parseProgram(String aString)).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> patchIndexAtX: x y: y [
	^ self ffiCall: #(int patchIndex(float x, float y))
]

{ #category : #'stelo funcs' }
SteloLibCall >> reset [
	self ffiCall: #(void reset()).
	self error: 'primitive not found'
]

{ #category : #'stelo funcs' }
SteloLibCall >> setByte: vno breed: bno id: tno value: value [
	^ self ffiCall: #(void setByte(int bno, int vno, int tno, byte value))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setByteAll: vno breed: bno extArray: list size: size [
	^ self ffiCall: #(void setByteAll(int bno, int vno, FFIExternalArray list, int size))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setDefaultTurtle: bno x: x y: y [
	self ffiCall: #(void setDefaultTurtleXY(int bno, float x, float y)).
]

{ #category : #'stelo funcs' }
SteloLibCall >> setFloat: vno breed: bno id: tno value: value [
	^ self ffiCall: #(void setFloat(int bno, int vno, int tno, float value))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setFloatAll: vno breed: bno extArray: list size: size [
	^ self ffiCall: #(void setFloatAll(int bno, int vno, FFIExternalArray list, int size))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setProgram: list size: size [
	self ffiCall: #(void setProgram(FFIExternalArray list, int size))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setWord: vno breed: bno id: tno value: value [
	^ self ffiCall: #(void setWord(int bno, int vno, int tno, uint32 value))
]

{ #category : #'stelo funcs' }
SteloLibCall >> setupBreed: anInteger [
	self ffiCall: #(void setupBreed(int anInteger))
]

{ #category : #'stelo funcs' }
SteloLibCall >> single [
	self ffiCall: #(void single()).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> startup [
	self ffiCall: #(void startup()).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> step [
	self ffiCall: #(void step()).
	self primitiveFailed.
]

{ #category : #'stelo funcs' }
SteloLibCall >> stop [
	self ffiCall: #(void stop()).
	self primitiveFailed.
]
