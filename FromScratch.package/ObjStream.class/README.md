I can serialize a collection of inter-connected objects onto a binary stream or reconstruct the original object network from its serialized form. This allows object structures to be saved in files, transmitted over a network, etc.

I support user class evolution via class version numbers, making it possible to detect and, if so desired, convert old object formats.

The format consists of a table of serialized objects. The first object in this table is the "root" object that was serialized; the rest of the objects in the table are objects reachable from this root object. Inter-object references are stored as indices into this table. These indices are mapped to actual object references when the structure is deserialized.

Object storage formats fall into one of these categories:
  a. immediate values: the constants nil, true, false, integers, and floats
  b. fixed-format objects whose serialization is handled by this class
  c. objects that handle their own serialization and whose formats may change over time

Objects in the first category are encoded in-line; they do not appear in the object table and thus cannot be shared. Integers that small enough to be represented in 16 bits have their own format. Objects in the second catetory are assumed to have stable storage formats, so they do not have a class version number. In the unlikely event that the storage format of any of these classes changes, the file format version must be incremented.

Objects in the last category support user-defined serialization. They are expected to implement the three instance methods storeFieldsOnXX:, initializeFromFieldsXX:, and objStreamVersion, where XX is the class version number. In general, any change to the serialization format of an object requires adding new versions of the methods storeFieldsOnXX: and initializeFromFieldsXX:, then incrementing the version number returned by objStreamVersion.

The class of every object in this category must appear in the class ID table. To ensure that old object files can be read, once an object has been assigned an ID that ID can't be changed and even if the class is deleted, it's ID must not used for another class.

Maximums:
  Object types (i.e., classes): 255
  User-defined class fields: 255
  Number of objects: 2^24 - 1
  Indexable object size: 2^32 - 1
