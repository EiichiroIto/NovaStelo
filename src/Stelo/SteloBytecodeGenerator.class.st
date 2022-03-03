Class {
	#name : #SteloBytecodeGenerator,
	#superclass : #ScratchBytecodeGenerator,
	#category : #'Stelo-Process'
}

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> aimHighVar: v [
	^ self unaryCommand: #aimHigh arg: v
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> append: aNumber toList: vno [
	self binaryCommand: #appendToList arg1: vno arg2: aNumber
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> broadcast: anInteger [
	self unaryCommand: #broadcast arg: anInteger.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> changeBreed: bid var: v by: aNumber [
	self appendValue: aNumber.
	self appendValue: v.
	self appendValue: bid.
	self appendSymbol: #changeBreedVarBy
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> changeObserverVar: v by: aNumber [
	self appendValue: 1.
	self appendValue: 1.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #setBreedVarTo
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> changePatchVar: v at: pno by: aNumber [
	self appendValue: pno.
	self appendSymbol: #dup.
	self appendValue: v.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #getBreedVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendValue: v.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #setBreedVarTo.
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> changeVar: id by: aNumber [
	self appendValue: id.
	self appendSymbol: #dup.
	self appendSymbol: #getVar.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setVarTo.
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> changeXposBy: aNumber [
	self appendSymbol: #getX.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setX
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> changeYposBy: aNumber [
	self appendSymbol: #getY.
	self appendValue: aNumber.
	self appendSymbol: #plus.
	self appendSymbol: #setY
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> clearAll [
	self unaryCommand: #clearBreed arg: SBreedId patchBreedNo.
	self nullaryCommand: #clearTurtles.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> clearGraphics [
	self unaryCommand: #clearBreed arg: SBreedId patchBreedNo.
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> clearList: vno [
	^ self unaryCommand: #clearList arg: vno
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> clearPlots [
	self nullaryCommand: #clearPlots
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> clearTurtle: bno [
	self unaryCommand: #clearBreed arg: bno.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> clearTurtles [
	self nullaryCommand: #clearTurtles.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> copyBreed: bid var: var to: var2 [
	self appendValue: var2.
	self appendValue: var.
	self appendValue: bid.
	self appendSymbol: #copyBreedVarTo
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> createPatchesSize: anInteger [
	self unaryCommand: #createPatch arg: anInteger.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> createTurtleSize: size breedId: id [
	self binaryCommand: #createTurtles arg1: size arg2: id.
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> deleteLine: anInteger ofList: vno [
	self binaryCommand: #deleteLineOfList arg1: vno arg2: anInteger
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> die [
	self appendSymbol: #getBreedId.
	self appendSymbol: #getId.
	self appendSymbol: #kill.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> diffuse4Var: v percentage: aNumber [
	self binaryCommand: #diffuse4 arg1: v arg2: aNumber.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> diffuseVar: v percentage: aNumber [
	self binaryCommand: #diffuse arg1: v arg2: aNumber.
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> directionTo: pno [
	self appendValue: pno.
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #direction.
	^ nil
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> distanceTo: pno [
	self appendValue: pno.
	self appendSymbol: #xyOf.
	self appendSymbol: #swap.
	self appendSymbol: #getX.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #swap.
	self appendSymbol: #getY.
	self appendSymbol: #minus.
	self appendSymbol: #dup.
	self appendSymbol: #mul.
	self appendSymbol: #plus.
	self appendSymbol: #sqrt.
	^ nil
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> dx [
	^ self nullaryCommand: #dx
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> dy [
	^ self nullaryCommand: #dy
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> forward: aNumber [
	self unaryCommand: #forward arg: aNumber.
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> front [
	self appendSymbol: #getX.
	self appendSymbol: #dx.
	self appendSymbol: #plus.
	self appendSymbol: #getY.
	self appendSymbol: #dy.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> getBreedId [
	^ self nullaryCommand: #getBreedId.
]

{ #category : #'color ops' }
SteloBytecodeGenerator >> getColor [
	^ self getVar: STurtleVarDef colorVarNo
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> getLine: anInteger ofList: vno [
	^ self binaryCommand: #getLineOfList arg1: vno arg2: anInteger
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> getObserverVar: vid [
	^ self getObserverVar: vid arg: 1
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> getObserverVar: vid arg: anInteger [
	self appendValue: anInteger.
	self appendValue: vid.
	self appendValue: SBreedId observerBreedNo.
	self appendSymbol: #getBreedVar.
	^ nil
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> getPatchColorAt: pno [
	^ self getPatchVar: SPatchVarDef colorVarNo at: pno
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> getPatchVar: vid at: pno [
	self appendValue: pno.
	self appendValue: vid.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #getBreedVar.
	^ nil
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> getVar: id [
	^ self unaryCommand: #getVar arg: id
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> getVar: aBlock1 breedNo: aBlock2 index: index [
	| bno |
	self appendValue: index.
	bno := aBlock2 value.
	self appendValue: (aBlock1 value: bno).
	self appendValue: bno.
	self appendSymbol: #getBreedVar.
	^ nil
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> getXpos [
	^ self nullaryCommand: #getX
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> getYpos [
	^ self nullaryCommand: #getY
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> hatch [
	^ self nullaryCommand: #hatch.
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> here [
	self appendSymbol: #getX.
	self appendSymbol: #getY.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> isPenDown [
	self appendValue: 0.
	self getVar: STurtleVarDef flagVarNo.
	self appendValue: 1 << STurtleVarDef penDownFlagNo.
	self appendSymbol: #and.
	self appendSymbol: #less.
	^ nil
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> kill: id breed: bid [
	self binaryCommand: #kill arg1: bid arg2: id.
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> lineCountOfList: vno [
	^ self unaryCommand: #lineCountOfList arg: vno
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> list: vno contains: anInteger [
	self binaryCommand: #listContains arg1: vno arg2: anInteger
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> multiplyBreed: bid var: v by: aNumber [
	self appendValue: aNumber.
	self appendValue: v.
	self appendValue: bid.
	self appendSymbol: #multiplyBreedVarBy
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> nsum4Var: v1 to: v2 [
	self binaryCommand: #nsum4 arg1: v1 arg2: v2.
]

{ #category : #'observer ops' }
SteloBytecodeGenerator >> nsumVar: v1 to: v2 [
	self binaryCommand: #nsum arg1: v1 arg2: v2.
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> patchAtX: x y: y [
	^ self binaryCommand: #patchAt arg1: x arg2: y
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> penDown: aBoolean [
	self appendValue: STurtleVarDef flagVarNo.
	self getVar: STurtleVarDef flagVarNo.
	self appendValue: 1 << STurtleVarDef penDownFlagNo.
	aBoolean
		ifTrue: [ self appendSymbol: #or ]
		ifFalse: [ self appendSymbol: #inv.
			self appendSymbol: #and ].
	self appendSymbol: #setVarTo
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> plot: anInteger color: anInteger2 [
	self binaryCommand: #plotColor arg1: anInteger arg2: anInteger2
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> plot: anInteger data: aFloat [
	self binaryCommand: #plotData arg1: anInteger arg2: aFloat
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> relativeToR: r theta: theta [
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #cos.
	self appendSymbol: #mul.
	self appendSymbol: #getX.
	self appendSymbol: #plus.
	self appendValue: r.
	self appendValue: theta.
	self appendSymbol: #sin.
	self appendSymbol: #mul.
	self appendSymbol: #getY.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> relativeToX: x y: y [
	self appendValue: x.
	self appendSymbol: #getX.
	self appendSymbol: #plus.
	self appendValue: y.
	self appendSymbol: #getY.
	self appendSymbol: #plus.
	self appendSymbol: #patchAt.
	^ nil
]

{ #category : #'color ops' }
SteloBytecodeGenerator >> scaleValue: v color: c from: f to: t [
	self appendValue: v.
	self appendValue: c.
	self appendValue: f.
	self appendValue: t.
	self appendSymbol: #scaleColorFromTo.
]

{ #category : #'color ops' }
SteloBytecodeGenerator >> setColorTo: anInteger [
	self unaryCommand: #setColorTo arg: anInteger.
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> setHeading: aNumber [
	self unaryCommand: #setHeading arg: aNumber.
]

{ #category : #'list ops' }
SteloBytecodeGenerator >> setLine: anInteger ofList: vno to: aNumber [
	self appendValue: anInteger.
	self appendValue: aNumber.
	self appendValue: vno.
	self appendSymbol: #setLineOfListTo.
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> setPatchColorAt: pno to: aNumber [
	self setPatchVar: SPatchVarDef colorVarNo at: pno to: aNumber
]

{ #category : #'patch ops' }
SteloBytecodeGenerator >> setPatchVar: var at: pno to: aNumber [
	self appendValue: pno.
	self appendValue: aNumber.
	self appendValue: var.
	self appendValue: SBreedId patchBreedNo.
	self appendSymbol: #setBreedVarTo.
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> setPlotYMax: aNumber [
	self unaryCommand: #setPlotYMax arg: aNumber
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> setPlotYMin: aNumber [
	self unaryCommand: #setPlotYMin arg: aNumber
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> setRandomSeed: num [
	self unaryCommand: #setRandomSeed arg: num
]

{ #category : #'variable ops' }
SteloBytecodeGenerator >> setVar: vid to: aNumber [
	self binaryCommand: #setVarTo arg1: vid arg2: aNumber
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> setXpos: aNumber [
	self unaryCommand: #setX arg: aNumber.
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> setYpos: aNumber [
	self unaryCommand: #setY arg: aNumber.
]

{ #category : #'color ops' }
SteloBytecodeGenerator >> stamp [
	self getVar: STurtleVarDef xVarNo.
	self getVar: STurtleVarDef yVarNo.
	self appendSymbol: #patchAt.
	self getVar: STurtleVarDef colorVarNo.
	self appendSymbol: #setPatchColorTo.
]

{ #category : #'turtle  ops' }
SteloBytecodeGenerator >> turn: aNumber [
	self appendValue: aNumber.
	self getVar: STurtleVarDef headingVarNo.
	self appendSymbol: #plus.
	self appendSymbol: #setHeading.
]

{ #category : #'misc ops' }
SteloBytecodeGenerator >> turtle: bid at: pno [
	self appendValue: pno.
	self appendValue: bid.
	self appendSymbol: #turtleAt.
	^ nil
]
