private
fixedFormatClasses
	"Answer an array of records for fixed-format classes."

	^ #(
		"id	class					read selector		write selector"
		(1	UndefinedObject			getConst:id:			putConst:id:)
		(2	True					getConst:id:			putConst:id:)
		(3	False					getConst:id:			putConst:id:)
		(4	SmallInteger			getSmallInt:id:		putSmallInt:id:)
		(5	SmallInteger16			getSmallInt:id:		putSmallInt:id:)  "optimization for ints that fit into 16 bits"
		(6	LargePositiveInteger		getBigInt:id:			putBigInt:id:)
		(7	LargeNegativeInteger	getBigInt:id:			putBigInt:id:)
		"(8	Float					getFloat:id:			putFloat:id:)"
		(8		SmallFloat64					getFloat:id:			putFloat:id:)
		(9		String					getBytes:id:			putBytes:id:)
		(10	Symbol					getBytes:id:			putBytes:id:)
		(11	ByteArray				getBytes:id:			putBytes:id:)
		(12	BoxedFloat64					getFloat:id:			putFloat:id:)
		(13	Bitmap					getBitmap:id:		putBitmap:id:)
		(14	ByteString				getBytes:id:			putBytes:id:)
		(15	FloatArray					getArray:id:			putArray:id:)
		(16	ColorArray					getArray:id:			putArray:id:)
		(17	WideString				getBytes:id:			putBytes:id:)
		(18	IntegerArray				getArray:id:			putArray:id:)
	"12-19 reserved for additional non-pointer objects"
		(20	Array					getArray:id:			putArray:id:)
		(21	OrderedCollection		getCollection:id:		putCollection:id:)
		(22	Set						getCollection:id:		putCollection:id:)
		(23	IdentitySet				getCollection:id:		putCollection:id:)
		(24	Dictionary				getDict:id:			putDict:id:)
		(25	IdentityDictionary		getDict:id:			putDict:id:)
	"26-29 reserved for additional collections"
		(30	Color					getColor:id:			putColor:id:)
		"(31	TranslucentColor		getColor:id:			putColor:id:)"
		(32	Point					getPoint:id:			putPoint:id:)
		(33	Rectangle				getRect:id:			putRect:id:)
		(34	Form					getForm:id:			putForm:id:)
		(35	ColorForm				getForm:id:			putForm:id:)
	"99 reserved for object references"
	"100-255 reserved for user-defined classes"
	)
