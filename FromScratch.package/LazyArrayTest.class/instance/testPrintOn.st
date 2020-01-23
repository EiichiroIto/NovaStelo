test
testPrintOn
	| a st |
	a := self newArray: #FloatArray.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,0)'.
	a at: 3 put: 10.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,100)'.
	a forceSize: 10.
	st := WriteStream on: ''.
	a printOn: st.
	self assert: st contents equals: 'LazyArray(FloatArray,*10)'.