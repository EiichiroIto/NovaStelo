"
A BlockMorphBuilderTest is a test class for testing the behavior of BlockMorphBuilder
"
Class {
	#name : #BlockMorphBuilderTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
BlockMorphBuilderTest >> newArgMorphBuilder [

	^ ArgMorphBuilder new
]

{ #category : #private }
BlockMorphBuilderTest >> newBlockMorphBuilder [

	^ BlockMorphBuilder new
]

{ #category : #private }
BlockMorphBuilderTest >> newProject [

	^ ScratchProject new
]

{ #category : #private }
BlockMorphBuilderTest >> newScript [

	^ ScTestScript new
]

{ #category : #test }
BlockMorphBuilderTest >> testAppendBlockSpecInto [

	| obj spec1 spec2 spec3 list |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	spec1 := AbstractBlockSpec
		         command: 'ghi'
		         selector: #jkl
		         arguments: #( 1 2 ).
	obj appendBlockSpec: spec1 into: 'abc'.
	spec2 := AbstractBlockSpec separator.
	obj appendBlockSpec: spec2 into: 'abc'.
	spec3 := AbstractBlockSpec
		         command: 'mno'
		         selector: #pqr
		         arguments: #(  ).
	obj appendBlockSpec: spec3 into: 'abc'.
	list := obj blockSpecsInCategory at: 'abc'.
	self assert: list isCollection.
	self assert: list size equals: 3.
	self assert: list first identicalTo: spec1.
	self assert: list second identicalTo: spec2.
	self assert: list third identicalTo: spec3
]

{ #category : #test }
BlockMorphBuilderTest >> testAssureLoadCompatibilityDictionary [

	| obj |
	obj := self newBlockMorphBuilder.
	self assert: obj compatibilityDictionary isNil.
	obj assureLoadCompatibilityDictionary.
	self assert: obj compatibilityDictionary isDictionary
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockCategories [

	| obj |
	obj := self newBlockMorphBuilder.
	self assert: obj blockCategories isEmpty.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'list' color: Color pink.
	obj setCategory: 'def' color: Color black.
	self
		assertCollection: obj blockCategories
		hasSameElements: #( abc def )
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockColorAt [

	| obj spec |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec := AbstractBlockSpec
		        command: 'ghi'
		        selector: #jkl
		        arguments: #( 1 2 ).
	obj registerBlockSpec: spec asCategory: 'def'.
	spec := AbstractBlockSpec
		        command: 'mno'
		        selector: #pqr
		        arguments: #(  ).
	obj registerBlockSpec: spec asCategory: 'stu'.
	self assert: (obj blockColorAt: #jkl) equals: Color black.
	self assert: (obj blockColorAt: #pqr) equals: Color gray.
	self assert: (obj blockColorAt: #zzz) equals: Color red
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockColorFor [

	| obj |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	self assert: (obj blockColorFor: 'abc') equals: Color white.
	self assert: (obj blockColorFor: 'def') equals: Color black.
	self assert: (obj blockColorFor: 'ghi') equals: Color gray
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockSelectorOf [

	| obj spec |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec := AbstractBlockSpec
		        command: 'ghi'
		        selector: #jkl
		        arguments: #( 1 2 ).
	obj registerBlockSpec: spec asCategory: 'def'.
	spec := AbstractBlockSpec
		        command: 'mno'
		        selector: #pqr
		        arguments: #(  ).
	obj registerBlockSpec: spec asCategory: 'stu'.
	self assert: (obj blockSelectorOf: #'ghi') equals: 'jkl'.
	self assert: (obj blockSelectorOf: #'mno') equals: 'pqr'
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockSpecAt [

	| obj spec1 spec2 dict |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec1 := AbstractBlockSpec
		         command: 'ghi'
		         selector: #jkl
		         arguments: #( 1 2 ).
	obj registerBlockSpec: spec1 asCategory: 'def'.
	spec2 := AbstractBlockSpec
		         command: 'mno'
		         selector: #pqr
		         arguments: #(  ).
	obj registerBlockSpec: spec2 asCategory: 'stu'.
	self assert: (obj blockSpecAt: #jkl) identicalTo: spec1.
	self assert: (obj blockSpecAt: #pqr) identicalTo: spec2.
	self assert: (obj blockSpecAt: #zzz) isNil.
	dict := Dictionary new
		        at: #pqr put: 'ghi';
		        at: #zzz put: 'ghi';
		        yourself.
	obj compatibilityDictionary: dict.
	self assert: (obj blockSpecAt: #jkl) identicalTo: spec1.
	self assert: (obj blockSpecAt: #pqr) identicalTo: spec2.
	self assert: (obj blockSpecAt: #zzz) identicalTo: spec1.
	self assert: (obj blockSpecAt: #yyy) isNil
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockSpecDictionary [

	| obj a |
	obj := self newBlockMorphBuilder.
	self assert: obj blockSpecDictionary isDictionary.
	self assert: obj blockSpecDictionary isEmpty.
	a := Dictionary new.
	obj blockSpecDictionary: a.
	self assert: obj blockSpecDictionary identicalTo: a
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockSpecs [

	| obj spec1 spec2 |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec1 := AbstractBlockSpec
		         command: 'ghi'
		         selector: #jkl
		         arguments: #( 1 2 ).
	obj registerBlockSpec: spec1 asCategory: 'def'.
	spec2 := AbstractBlockSpec
		         command: 'mno'
		         selector: #pqr
		         arguments: #(  ).
	obj registerBlockSpec: spec2 asCategory: 'stu'.
	self assertCollection: obj blockSpecs hasSameElements: { 
			spec1.
			spec2 }
]

{ #category : #test }
BlockMorphBuilderTest >> testBlockSpecsInCategory [

	| obj a |
	obj := self newBlockMorphBuilder.
	self assert: obj blockSpecsInCategory isDictionary.
	self assert: obj blockSpecsInCategory isEmpty.
	a := Dictionary new.
	obj blockSpecsInCategory: a.
	self assert: obj blockSpecsInCategory identicalTo: a
]

{ #category : #test }
BlockMorphBuilderTest >> testCategoryColors [

	| obj a |
	obj := self newBlockMorphBuilder.
	self assert: obj categoryColors isDictionary.
	self assert: obj categoryColors isEmpty.
	a := Dictionary new.
	obj categoryColors: a.
	self assert: obj categoryColors identicalTo: a
]

{ #category : #test }
BlockMorphBuilderTest >> testChangeVarBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj changeVarBlockFor: 'abc'.
	self assert: (block isKindOf: SetterBlockMorph).
	self assert: block selector equals: #changeVar:by:.
	self assert: block receiver identicalTo: script.
	self assert: block variable equals: 'abc'.
	self assert: block color equals: obj unknownCategoryColor
]

{ #category : #test }
BlockMorphBuilderTest >> testCompatibilityDictionary [

	| obj a |
	obj := self newBlockMorphBuilder.
	self assert: obj compatibilityDictionary isNil.
	a := Dictionary new.
	obj compatibilityDictionary: a.
	self assert: obj compatibilityDictionary identicalTo: a
]

{ #category : #test }
BlockMorphBuilderTest >> testCompatibleSelectorOf [

	| obj spec1 spec2 dict |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec1 := AbstractBlockSpec
		         command: 'ghi'
		         selector: #jkl
		         arguments: #( 1 2 ).
	obj registerBlockSpec: spec1 asCategory: 'def'.
	spec2 := AbstractBlockSpec
		         command: 'mno'
		         selector: #pqr
		         arguments: #(  ).
	obj registerBlockSpec: spec2 asCategory: 'stu'.
	dict := Dictionary new
		        at: #xxx put: 'mno';
		        at: #zzz put: 'ghi';
		        yourself.
	obj compatibilityDictionary: dict.
	self assert: (obj compatibleSelectorOf: #xxx) identicalTo: #pqr.
	self assert: (obj compatibleSelectorOf: #zzz) identicalTo: #jkl.
	self assert: (obj compatibleSelectorOf: #yyy) isNil
]

{ #category : #test }
BlockMorphBuilderTest >> testEventHatBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj eventHatBlockFor: 'abc'.
	self assert: (block isKindOf: EventHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block eventName equals: 'abc'
]

{ #category : #test }
BlockMorphBuilderTest >> testLastCategory [

	| obj a |
	obj := self newBlockMorphBuilder.
	self assert: obj lastCategory isNil.
	obj lastCategory: 'abc'.
	self assert: obj lastCategory equals: 'abc'.
	obj lastCategory: 'def'.
	self assert: obj lastCategory equals: 'def'
]

{ #category : #test }
BlockMorphBuilderTest >> testLocalVarBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj localVarBlockFor: 'abc'.
	self assert: (block isKindOf: LocalVarBlockMorph).
	self assert: block receiver identicalTo: script.
	self assert: block variable equals: 'abc'
]

{ #category : #test }
BlockMorphBuilderTest >> testLoopHatBlock [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj loopHatBlock.
	self assert: (block isKindOf: EventHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block eventName equals: 'loop'
]

{ #category : #test }
BlockMorphBuilderTest >> testProject [

	| obj s p |
	obj := self newBlockMorphBuilder.
	s := self newScript.
	obj script: s.
	self assert: obj project isNil.
	p := self newProject.
	s project: p.
	self assert: obj project identicalTo: p
]

{ #category : #test }
BlockMorphBuilderTest >> testRegisterBlockSpecAsCategory [

	| obj spec |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	spec := AbstractBlockSpec
		        command: 'ghi'
		        selector: #jkl
		        arguments: #( 1 2 ).
	self assert: obj blockSpecsInCategory isEmpty.
	self assert: obj blockSpecDictionary isEmpty.
	obj registerBlockSpec: spec asCategory: 'def'.
	self assert: (obj blockSpecsInCategory at: 'def') isCollection.
	self assert: (obj blockSpecsInCategory at: 'def') first identicalTo: spec.
	self assert: (obj blockSpecDictionary at: #jkl) identicalTo: spec.
	self assert: spec color equals: Color black.
	spec := AbstractBlockSpec
		        command: 'mno'
		        selector: #pqr
		        arguments: #(  ).
	obj registerBlockSpec: spec asCategory: 'stu'.
	self assert: (obj blockSpecsInCategory at: 'stu') isCollection.
	self assert: (obj blockSpecsInCategory at: 'stu') first identicalTo: spec.
	self assert: (obj blockSpecDictionary at: #pqr) identicalTo: spec.
	self assert: spec color equals: Color gray
]

{ #category : #test }
BlockMorphBuilderTest >> testScript [

	| obj s |
	obj := self newBlockMorphBuilder.
	self assert: obj script isNil.
	s := self newScript.
	obj script: s.
	self assert: obj script identicalTo: s
]

{ #category : #test }
BlockMorphBuilderTest >> testSetCategoryColor [

	| obj |
	obj := self newBlockMorphBuilder.
	obj setCategory: 'abc' color: Color white.
	obj setCategory: 'def' color: Color black.
	self assert: obj categoryColors size equals: 2.
	self assert: (obj categoryColors at: 'abc') equals: Color white.
	self assert: (obj categoryColors at: 'def') equals: Color black
]

{ #category : #test }
BlockMorphBuilderTest >> testSetVarBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj setVarBlockFor: 'abc'.
	self assert: (block isKindOf: SetterBlockMorph).
	self assert: block selector equals: #setVar:to:.
	self assert: block receiver identicalTo: script.
	self assert: block variable equals: 'abc'.
	self assert: block color equals: obj unknownCategoryColor
]

{ #category : #test }
BlockMorphBuilderTest >> testSetupHatBlock [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj setupHatBlock.
	self assert: (block isKindOf: EventHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block eventName equals: 'setup'
]

{ #category : #test }
BlockMorphBuilderTest >> testStartHatBlock [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj startHatBlock.
	self assert: (block isKindOf: EventHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block eventName equals: 'start'
]

{ #category : #test }
BlockMorphBuilderTest >> testStartupHatBlock [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj startupHatBlock.
	self assert: (block isKindOf: EventHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block eventName equals: 'startup'
]

{ #category : #test }
BlockMorphBuilderTest >> testSubHatBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj subHatBlockFor: 'abc'.
	self assert: (block isKindOf: SubHatMorph).
	self assert: block scriptOwner identicalTo: script.
	self assert: block subName equals: 'abc'
]

{ #category : #test }
BlockMorphBuilderTest >> testUnknownBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj unknownBlockFor: 'abc'.
	self assert: (block isKindOf: CommandBlockMorph).
	self assert: block receiver identicalTo: script.
	self assert: block selector equals: #unknown:.
	self assert: block args size equals: 1.
	self assert: block args first equals: 'abc'.
	self assert: block color equals: Color red
]

{ #category : #test }
BlockMorphBuilderTest >> testUnknownCategoryColor [

	self assert: self newBlockMorphBuilder unknownCategoryColor isColor
]

{ #category : #test }
BlockMorphBuilderTest >> testVariableBlockFor [

	| obj block script |
	script := self newScript.
	script setupBlockSpecs.
	obj := self newBlockMorphBuilder.
	obj script: script.
	block := obj variableBlockFor: 'abc'.
	self assert: (block isKindOf: VariableBlockMorph).
	self assert: block receiver identicalTo: script.
	self assert: block variable equals: 'abc'
]
