tests
testFixedFormatClasses
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
