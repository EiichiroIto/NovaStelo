Class {
	#name : #BlockMorphBuilder,
	#superclass : #Object,
	#instVars : [
		'script',
		'categoryColors',
		'lastCategory',
		'blockSpecsInCategory',
		'blockSpecDictionary',
		'compatibilityDictionary'
	],
	#category : #'FromScratch-Project'
}

{ #category : #utilities }
BlockMorphBuilder class >> compatibleFile [

	^ FileSystem workingDirectory / 'compat.ston'
]

{ #category : #api }
BlockMorphBuilder >> addBlockSpec: aBlockSpec [

	aBlockSpec isBlockSpec ifTrue: [ 
		^ self registerBlockSpec: aBlockSpec asCategory: lastCategory ].
	aBlockSpec isCategory ifTrue: [ 
		^ lastCategory := aBlockSpec categoryName ].
	aBlockSpec isSeparator ifTrue: [ 
		^ self appendBlockSpec: aBlockSpec into: lastCategory ].
	aBlockSpec isChoiceArg ifTrue: [ ^ self ].
	self error
]

{ #category : #api }
BlockMorphBuilder >> addBooleanReporter: aString selector: aSymbol [

	self addBooleanReporter: aString selector: aSymbol arguments: #(  )
]

{ #category : #api }
BlockMorphBuilder >> addBooleanReporter: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             booleanReporter: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addCBlock: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             cBlock: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addCategory: aString [

	lastCategory := aString
]

{ #category : #api }
BlockMorphBuilder >> addCommand: aString selector: aSymbol [

	self addCommand: aString selector: aSymbol arguments: #(  )
]

{ #category : #api }
BlockMorphBuilder >> addCommand: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             command: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addHatBlock: aString type: aString2 arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             hatBlock: aString
		             type: aString2
		             arguments: aCollection.
	self assert: [ blockSpec isHatBlock ].
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addReporter: aString selector: aSymbol [

	self addReporter: aString selector: aSymbol arguments: #(  )
]

{ #category : #api }
BlockMorphBuilder >> addReporter: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             reporter: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addSeparator [

	self appendBlockSpec: AbstractBlockSpec separator into: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addSpecial: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             special: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #api }
BlockMorphBuilder >> addTimed: aString selector: aSymbol arguments: aCollection [

	| blockSpec |
	blockSpec := AbstractBlockSpec
		             timed: aString
		             selector: aSymbol
		             arguments: aCollection.
	self registerBlockSpec: blockSpec asCategory: lastCategory
]

{ #category : #private }
BlockMorphBuilder >> appendBlockSpec: aBlockSpec into: aCategoryString [

	| list |
	list := blockSpecsInCategory
		        at: aCategoryString
		        ifAbsentPut: [ OrderedCollection new ].
	list add: aBlockSpec
]

{ #category : #private }
BlockMorphBuilder >> assureLoadCompatibilityDictionary [

	| file |
	compatibilityDictionary ifNotNil: [ ^ self ].
	file := self class compatibleFile.
	compatibilityDictionary := file isFile
		                           ifTrue: [ 
		                           file readStreamDo: [ :s | 
			                           STON fromStream: s ] ]
		                           ifFalse: [ Dictionary new ]
]

{ #category : #api }
BlockMorphBuilder >> blockCategories [

	^ categoryColors keys copyWithout: 'list'
]

{ #category : #api }
BlockMorphBuilder >> blockColorAt: aSymbol [

	| spec |
	spec := blockSpecDictionary at: aSymbol ifAbsent: [ ^ Color red ].
	^ spec color
]

{ #category : #api }
BlockMorphBuilder >> blockColorFor: aCategory [

	^ categoryColors
		at: aCategory
		ifAbsent: [ self unknownCategoryColor ]
]

{ #category : #private }
BlockMorphBuilder >> blockFromSpec: aBlockSpec [

	| blockLabelSpec selector block argPermutation c defaultArgs |
	c := aBlockSpec color.
	blockLabelSpec := aBlockSpec label localized.
	argPermutation := CommandBlockMorph
		                  argPermutationForSpec: aBlockSpec label
		                  withTranslation: blockLabelSpec.
	aBlockSpec isHatBlock ifTrue: [ 
		^ (script hatBlockFromSpec: aBlockSpec) color: c ].
	selector := aBlockSpec selector asSymbol.
	aBlockSpec isCBlock
		ifTrue: [ 
			block := selector = #doIfElse
				         ifTrue: [ IfElseBlockMorph new isSpecialForm: true ]
				         ifFalse: [ CBlockMorph new isSpecialForm: true ] ]
		ifFalse: [ 
			aBlockSpec isReporterBlock
				ifTrue: [ 
					block := ReporterBlockMorph new.
					c := c darker ]
				ifFalse: [ block := CommandBlockMorph new ] ].
	aBlockSpec isBooleanReporter ifTrue: [ block isBoolean: true ].
	aBlockSpec isSpecialForm ifTrue: [ block isSpecialForm: true ].
	aBlockSpec isTimedBlock ifTrue: [ block isTimed: true ].
	defaultArgs := script defaultArgsFor: aBlockSpec.
	^ block
		  argPermutation: argPermutation;
		  color: c;
		  selector: selector;
		  receiver: script;
		  commandSpec: blockLabelSpec;
		  defaultArgs: defaultArgs;
		  yourself
]

{ #category : #api }
BlockMorphBuilder >> blockFromTuple: tuple [

	"Answer a new block for the given tuple."

	| k spec block argCount arg argBlock |
	k := tuple first.
	k = #localVar ifTrue: [ 
		^ self localVarBlockFor: tuple second ].
	(#( readVariable changeVariable ) includes: k) ifTrue: [ 
		^ self variableBlockFromTuple: tuple ].
	(#( EventHatMorph SubHatMorph ) includes: k) ifTrue: [ 
		^ script hatBlockFromTuple: tuple ].
	"#scratchComment = k
		ifTrue: [ block := ScratchCommentMorph new.
			tuple size > 1
				ifTrue: [ block commentMorph contents: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			tuple size > 3
				ifTrue: [ block width: (tuple at: 4) ].
			tuple size > 4
				ifTrue: [ block anchor: (self blockWithID: (tuple at: 5)) ].
			^ block ].
	#comment: = k
		ifTrue: [ block := CommentBlockMorph new.
			tuple size > 1
				ifTrue: [ block comment: (tuple at: 2) ].
			tuple size > 2
				ifTrue: [ (tuple at: 3)
						ifFalse: [ block toggleShowing ] ].
			block color: (Color r: 0.8 g: 0 b: 0).
			^ block ]."
	spec := self blockSpecAt: k.
	spec ifNil: [ 
		^ self unknownBlockFor: k ].
	block := self blockFromSpec: spec.
	block isCommandBlock ifTrue: [ 
		argCount := block argumentCount min: tuple size - 1.
		1 to: argCount do: [ :i | 
			arg := tuple at: i + 1.
			arg isArray
				ifTrue: [ "argument is a block"
					(arg size = 1 and: [ arg first isArray ]) ifTrue: [ 
						arg := arg first ].
					argBlock := self blockFromTuple: arg.
					block replaceArgMorph: (block argumentAt: i) by: argBlock ]
				ifFalse: [ "argument is a value" 
				(block argumentAt: i) defaultValue: arg ] ].
		block isCBlock ifTrue: [ 
			tuple last isArray ifTrue: [ 
				block firstBlockList:
					(self stackFromTupleList: tuple last) ] ].
		block isIfElseBlock ifTrue: [ 
			arg := tuple at: tuple size - 1.
			arg isArray ifTrue: [ 
				block trueBlock: (self stackFromTupleList: arg) ].
			arg := tuple last.
			arg isArray ifTrue: [ 
				block falseBlock: (self stackFromTupleList: arg) ] ].
		block isReporter ifTrue: [ 
			(spec type includes: $b) ifTrue: [ block isBoolean: true ] ] ].
	^ block
]

{ #category : #api }
BlockMorphBuilder >> blockSelectorOf: aString [

	blockSpecDictionary keysAndValuesDo: [ :key :value | 
		aString = value label ifTrue: [ ^ key ] ].
	^ nil
]

{ #category : #api }
BlockMorphBuilder >> blockSpecAt: aSymbol [

	| selector |
	blockSpecDictionary at: aSymbol ifPresent: [ :obj | ^ obj ].
	selector := self compatibleSelectorOf: aSymbol.
	selector ifNil: [ ^ nil ].
	^ blockSpecDictionary at: selector
]

{ #category : #accessing }
BlockMorphBuilder >> blockSpecDictionary [

	^ blockSpecDictionary
]

{ #category : #accessing }
BlockMorphBuilder >> blockSpecDictionary: anObject [

	blockSpecDictionary := anObject
]

{ #category : #api }
BlockMorphBuilder >> blockSpecs [

	^ blockSpecDictionary values
]

{ #category : #accessing }
BlockMorphBuilder >> blockSpecsInCategory [

	^ blockSpecsInCategory
]

{ #category : #accessing }
BlockMorphBuilder >> blockSpecsInCategory: anObject [

	blockSpecsInCategory := anObject
]

{ #category : #api }
BlockMorphBuilder >> blocksFor: aCategory [

	| list |
	list := blockSpecsInCategory at: aCategory ifAbsent: [ ^ Array new ].
	^ list collect: [ :each | 
		  each isBlockSpec
			  ifTrue: [ self blockFromSpec: each ]
			  ifFalse: [ each ] ]
]

{ #category : #accessing }
BlockMorphBuilder >> categoryColors [

	^ categoryColors
]

{ #category : #accessing }
BlockMorphBuilder >> categoryColors: anObject [

	categoryColors := anObject
]

{ #category : #api }
BlockMorphBuilder >> changeVarBlockFor: aString [

	^ SetterBlockMorph new
		  receiver: script;
		  initChangerForVar: aString;
		  color: (self blockColorFor: 'variables');
		  yourself
]

{ #category : #accessing }
BlockMorphBuilder >> compatibilityDictionary [

	^ compatibilityDictionary
]

{ #category : #accessing }
BlockMorphBuilder >> compatibilityDictionary: anObject [

	^ compatibilityDictionary := anObject
]

{ #category : #private }
BlockMorphBuilder >> compatibleSelectorOf: aSymbol [

	| block |
	self assureLoadCompatibilityDictionary.
	block := compatibilityDictionary at: aSymbol ifAbsent: [ ^ nil ].
	^ self blockSelectorOf: block
]

{ #category : #api }
BlockMorphBuilder >> eventHatBlockFor: aString [

	^ EventHatMorph new
		  scriptOwner: script;
		  eventName: aString
]

{ #category : #initialization }
BlockMorphBuilder >> initialize [

	categoryColors := Dictionary new.
	blockSpecsInCategory := Dictionary new.
	blockSpecDictionary := Dictionary new
]

{ #category : #accessing }
BlockMorphBuilder >> lastCategory [

	^ lastCategory
]

{ #category : #accessing }
BlockMorphBuilder >> lastCategory: anObject [

	lastCategory := anObject
]

{ #category : #api }
BlockMorphBuilder >> localVarBlockFor: aString [

	^ LocalVarBlockMorph new
		  commandSpec: aString;
		  receiver: script
]

{ #category : #api }
BlockMorphBuilder >> loopHatBlock [

	^ EventHatMorph new
		  for: 'when loop' event: #loop;
		  scriptOwner: script;
		  yourself
]

{ #category : #printing }
BlockMorphBuilder >> printOn: aStream [

	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: blockSpecsInCategory keys size asString;
		nextPutAll: ' categories,';
		nextPutAll: blockSpecDictionary size asString;
		nextPutAll: ' blocks)'
]

{ #category : #private }
BlockMorphBuilder >> project [

	^ script project
]

{ #category : #private }
BlockMorphBuilder >> registerBlockSpec: aBlockSpec asCategory: aCategoryString [

	| color |
	self assert: [ 
		(blockSpecDictionary includesKey: aBlockSpec selector) not ].
	aBlockSpec selector ifNotNil: [ :selector | 
		blockSpecDictionary at: selector put: aBlockSpec ].
	aCategoryString ifNotNil: [ 
		self appendBlockSpec: aBlockSpec into: aCategoryString.
		color := categoryColors
			         at: aCategoryString
			         ifAbsentPut: [ self unknownCategoryColor ].
		aBlockSpec color: color ]
]

{ #category : #accessing }
BlockMorphBuilder >> script [

	^ script
]

{ #category : #accessing }
BlockMorphBuilder >> script: anObject [

	script := anObject
]

{ #category : #api }
BlockMorphBuilder >> setCategory: aString color: aColor [

	categoryColors at: aString asLowercase put: aColor
]

{ #category : #api }
BlockMorphBuilder >> setVarBlockFor: aString [

	^ SetterBlockMorph new
		  receiver: script;
		  initSetterForVar: aString;
		  color: (self blockColorFor: 'variables');
		  yourself
]

{ #category : #api }
BlockMorphBuilder >> setupHatBlock [

	^ EventHatMorph new
		  for: 'when setup' event: #setup;
		  scriptOwner: script;
		  yourself
]

{ #category : #private }
BlockMorphBuilder >> stackFromTupleList: tupleList [

	| stackTop previousBlock block |
	stackTop := previousBlock := nil.
	tupleList do: [ :tuple | 
		block := self blockFromTuple: tuple.
		previousBlock
			ifNil: [ stackTop := block ]
			ifNotNil: [ previousBlock nextBlock: block ].
		previousBlock := block ].
	^ stackTop
]

{ #category : #api }
BlockMorphBuilder >> startHatBlock [

	^ EventHatMorph new
		  for: 'when start' event: #start;
		  scriptOwner: script;
		  yourself
]

{ #category : #api }
BlockMorphBuilder >> startupHatBlock [

	^ EventHatMorph new
		  for: 'when setup' event: #startup;
		  scriptOwner: script;
		  yourself
]

{ #category : #api }
BlockMorphBuilder >> subHatBlockFor: aString [

	^ SubHatMorph new
		  scriptOwner: script;
		  subName: aString;
		  yourself
]

{ #category : #api }
BlockMorphBuilder >> unknownBlockFor: aSymbol [

	^ CommandBlockMorph new
		  argPermutation: #( 1 );
		  color: Color red;
		  selector: #unknown:;
		  receiver: script;
		  commandSpec: 'unknown %s' localized;
		  defaultArgs: { aSymbol };
		  yourself
]

{ #category : #private }
BlockMorphBuilder >> unknownCategoryColor [

	"Color h: 0 s: 0.81 v: 0.83"
	^ Color gray
]

{ #category : #api }
BlockMorphBuilder >> variableBlockFor: aString [

	^ VariableBlockMorph new
		  commandSpec: aString;
		  receiver: script;
		  yourself
]

{ #category : #private }
BlockMorphBuilder >> variableBlockFromTuple: tuple [

	| varName selector block arg argBlock |
	varName := tuple at: 2.
	(script varNames includes: varName) ifFalse: [ 
		script addVariable: varName ].
	tuple first = #readVariable ifTrue: [ 
		^ self variableBlockFor: varName ].
	tuple first = #changeVariable ifTrue: [ 
		selector := tuple at: 3.
		selector = #set:to: ifTrue: [ selector := #setVar:to: ].
		block := selector = #setVar:to:
			         ifTrue: [ self setVarBlockFor: varName ]
			         ifFalse: [ self changeVarBlockFor: varName ].
		arg := tuple at: 4.
		arg isArray
			ifTrue: [ 
				(arg size = 1 and: [ arg first isArray ]) ifTrue: [ 
					arg := arg first ].
				argBlock := self blockFromTuple: arg.
				block replaceArgMorph: block expressionArg by: argBlock ]
			ifFalse: [ block expressionArg defaultValue: arg ].
		^ block ].
	self error: 'unknown variable spec!'
]
