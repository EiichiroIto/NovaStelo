Class {
	#name : #AbstractBlockSpec,
	#superclass : #Object,
	#category : #'FromScratch-Project'
}

{ #category : #'instance creation' }
AbstractBlockSpec class >> blockCategory: aString [

	^ ScratchBlockCategory new
		  categoryName: aString;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> booleanReporter: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #b;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> cBlock: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #c;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> command: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #-;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> hatBlock: aString type: aString2 arguments: aCollection [

	self assert: [ aString2 isString ].
	^ ScratchBlockSpec new
		  label: aString;
		  type: aString2;
		  selector: nil;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> reporter: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #r;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> separator [

	^ ScratchBlockSeparator new
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> special: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #s;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> timed: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #t;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #testing }
AbstractBlockSpec >> isBlockMorph [

	^ false
]

{ #category : #testing }
AbstractBlockSpec >> isBlockSpec [

	^ false
]

{ #category : #testing }
AbstractBlockSpec >> isCategory [

	^ false
]

{ #category : #testing }
AbstractBlockSpec >> isChoiceArg [

	^ false
]

{ #category : #testing }
AbstractBlockSpec >> isSeparator [

	^ false
]
