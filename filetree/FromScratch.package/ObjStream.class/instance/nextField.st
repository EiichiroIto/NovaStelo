entry points
nextField
	"Answer the next field and advance to the next field. This method should only be called from initFieldsFrom:version: during deserialization."
	"Note: If class versions are managed correctly, it should not be necessary to check that fieldIndex is in bounds. However, sometimes during development, we store a project that has objects with an extra field that is later removed. The check on fields size allows us to fail more gracefully in such cases."

	fieldIndex := fieldIndex + 1.
	fieldIndex > fields size ifTrue: [^ nil]. "fail gracefully"
	^ fields at: fieldIndex
