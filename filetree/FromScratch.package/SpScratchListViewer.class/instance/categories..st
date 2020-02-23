accessing
categories: aCollection
	categories items: (aCollection collect: [ :each | each asLowercase ]) sort