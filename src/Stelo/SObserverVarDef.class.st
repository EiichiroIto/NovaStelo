Class {
	#name : #SObserverVarDef,
	#superclass : #VarDef,
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SObserverVarDef class >> colorVarNo [

	^ 1
]

{ #category : #accessing }
SObserverVarDef class >> countAliveVarNo [
	^ 5
]

{ #category : #accessing }
SObserverVarDef class >> heightVarNo [
	^ 2
]

{ #category : #accessing }
SObserverVarDef class >> maxBreedNoVarNo [
	^ 3
]

{ #category : #accessing }
SObserverVarDef class >> maxVarVarNo [
	^ 7
]

{ #category : #accessing }
SObserverVarDef class >> sizeVarNo [
	^ 6
]

{ #category : #accessing }
SObserverVarDef class >> ticksVarNo [
	^ 4
]

{ #category : #accessing }
SObserverVarDef class >> widthVarNo [
	^ 1
]

{ #category : #private }
SObserverVarDef >> setupReservedVarNames [
	#(width height maxBreedNo ticks countAlive size maxVar)
		do: [ :each | 
			self
				addComputedVariable: each
				varNo: (self class perform: each , 'VarNo') ].
	self setupVarNames
]
