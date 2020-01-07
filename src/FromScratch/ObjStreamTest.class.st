Class {
	#name : #ObjStreamTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #private }
ObjStreamTest >> equalityTest: inObj [
	"For testing. Serialize and deserialize the given object and compare the result for equality with the original object."

	| outObj |
	outObj := self serializeAndDeserialize: inObj.
	outObj class == inObj class
		ifFalse: [ self error: 'output class is not equal to input class' ].
	outObj = inObj
		ifFalse: [ self error: 'output is not equal to input' ]
]

{ #category : #private }
ObjStreamTest >> formEqualityTest: inForm [
	"For testing. Serialize and deserialize the given form and compare the result for equality with the original."

	| outForm |
	outForm := self serializeAndDeserialize: inForm.
	outForm class == inForm class
		ifFalse: [ self error: 'output class is not equal to input class' ].
	outForm extent = inForm extent & (outForm depth = inForm depth)
		& (outForm bits = inForm bits) & (outForm offset = inForm offset)
		ifFalse: [ self error: 'output Form is not equal to input Form' ].
	(inForm isKindOf: ColorForm)
		ifTrue: [ inForm colors = outForm colors
				ifFalse: [ self error: 'output colors are not equal to input colors' ] ]
]

{ #category : #'instance creation' }
ObjStreamTest >> newObjStream [
	^ ObjStream new
]

{ #category : #private }
ObjStreamTest >> serializeAndDeserialize: anObject [
	"For testing. Serialize and de-serialize the given object and answer the result."

	| stream |
	stream := WriteStream on: ByteArray new.
	self newObjStream storeObj: anObject on: stream showProgress: false.
	^ self newObjStream readObjFrom: (ReadStream on: stream contents)
]

{ #category : #tests }
ObjStreamTest >> testFixedFormatClasses [
	| shared |
	self equalityTest: #().
	self equalityTest: #(1 2 3).
	self equalityTest: (Array with: nil with: true with: false).
	self equalityTest: #(123 -123 123456 -123456 1234567890 -1234567890 3.14159).
	self equalityTest: 'hello'.
	self equalityTest: 'hello' asSymbol.
	self equalityTest: #(1 2 3) asByteArray.
	"self equalityTest: (UTF8 withAll: 'hello')."

	"self equalityTest: (SoundBuffer fromArray: #(1 2 3 4))."
	self equalityTest: (Bitmap withAll: #(0 1 2 2147483647 2147483648 4294967295)).

	self equalityTest: #(1 2 3) asOrderedCollection.
	self equalityTest: #(1 2 3) asSet.
	self equalityTest: (IdentitySet new addAll: #(1 2 3); yourself).
	self equalityTest: (Dictionary new at: 1 put: 'a'; at: 'b' put: 2; yourself).
	"self equalityTest: (IdentityDictionary new at: 1 put: 'a'; at: 'b' put: 2; yourself)."

	self equalityTest: (Color gray: 0.3).
	self equalityTest: (Color red alpha: 0.5).
	self equalityTest: 2 @ 3.14159.
	self equalityTest: (0@0 extent: 2.5 @ 2.5).
	self formEqualityTest: (Form fromDisplay: (0@0 extent: 10@10)).
	"self formEqualityTest: ((Form fromDisplay: (0@0 extent: 10@10)) colorReduced)."

	shared := #Shared.
	self equalityTest: (Point x: shared y: shared).
	"self equalityTest: ((Point x: shared y: shared) corner: (Point x: shared y: shared))."
	self equalityTest: (OrderedCollection with: shared with: shared).
	self equalityTest: (Array with: shared with: (Set new add: shared; yourself)).
	self equalityTest: (Dictionary new at: shared put: shared; at: 'b' put: shared; yourself).
	"self equalityTest: (IdentityDictionary new at: shared put: shared; at: 'b' put: shared; yourself)."

	self inform: 'Fixed-format tests passed.'.

]

{ #category : #tests }
ObjStreamTest >> testUserClasses [
	"Test conversions for fixed-format objects."

	| userClassList suspectClasses |
	userClassList := self newObjStream class userClasses
		collect: [ :rec | Smalltalk at: rec second ].
	userClassList := userClassList
		reject: [ :cl | (cl inheritsFrom: BlockMorph) | (cl inheritsFrom: ArgMorph) ].
	userClassList do: [ :cl | self serializeAndDeserialize: cl new ].
	suspectClasses := userClassList
		select: [ :cl | 
			(cl includesSelector: #fieldsVersion) not
				and: [ cl instVarNames notEmpty ] ].
	self assert: suspectClasses isEmpty
]

{ #category : #tests }
ObjStreamTest >> testWriteFile [
	| all objects s file |
	all := OrderedCollection new.
	all add: true.
	all add: false.
	all add: 12345.
	all add: 123.
	all add: 1234567891.
	all add: -1234567891.
	all add: 123.546.
	all add: 'This is a string.'.
	all add: #thisIsASymbol.
	all add: #(100 101 102 253 254 255) asByteArray.
	"all add: ScriptableScratchMorph popSound samples."
	all add: (ImageMorph defaultForm asFormOfDepth: 32) bits.
	all add: (Array with: 1 with: 2 with: 3).
	all add: (Array with: 1 with: 2 with: 3) asOrderedCollection.
	all add: (Array with: 1 with: 2 with: 3) asSet.
	all add: (IdentitySet withAll: (Array with: 1 with: 2 with: 3)).
	all add: (Dictionary new at: 'John' put: 'Maloney'; at: 'Lise' put: 'Kreps'; yourself).
	all add: (IdentityDictionary new at: #John put: 'Maloney'; at: #Lise put: 'Kreps'; yourself).
	all add: (Color gray: 0.5).
	all add: (Color red alpha: 0.5).
	all add: 1@2.0.
	all add: (9.5@20 extent: 30@40).
	all add: (ImageMorph defaultForm asFormOfDepth: 32).
	all add: ImageMorph defaultForm.

	objects := (Array with: nil), all asArray.
	file := 'test.obj' asFileReference.
	file isFile ifTrue: [ file delete ].
	s := file binaryWriteStream.
	self newObjStream storeObj: objects on: s.
	s close.
]
