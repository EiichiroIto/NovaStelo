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
		  type: #isBooleanReporter;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> cBlock: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #isCBlock;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> command: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #isCommandBlock;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> eventHatBlock: aString selector: aSymbol eventName: aString2 [

	self assert: [ aSymbol isSymbol ].
	^ ScratchBlockSpec new
		  label: aString;
		  type: #isEventHatBlock;
		  selector: aSymbol;
		  arguments: { aString2 };
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> reporter: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #isReporterBlock;
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
		  type: #isSpecialForm;
		  selector: aSymbol;
		  arguments: aCollection copy;
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> startHatBlock: aString selector: aSymbol [

	self assert: [ aSymbol isSymbol ].
	^ ScratchBlockSpec new
		  label: aString;
		  type: #isStartHatBlock;
		  selector: aSymbol;
		  arguments: #(  );
		  yourself
]

{ #category : #'instance creation' }
AbstractBlockSpec class >> timed: aString selector: aSymbol arguments: aCollection [

	^ ScratchBlockSpec new
		  label: aString;
		  type: #isTimedBlock;
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
