initialization
offForm: offForm onForm: onForm overForm: overForm

	self offForm: offForm onForm: onForm.
	overForm ifNotNil: [over := ImageFrameMorph new initFromForm: overForm].

