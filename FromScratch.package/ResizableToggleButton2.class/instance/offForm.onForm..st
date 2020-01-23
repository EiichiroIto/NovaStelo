initialization
offForm: offForm onForm: onForm

	normal := ImageFrameMorph new initFromForm: offForm.
	pressed := ImageFrameMorph new initFromForm: onForm.
	over := nil.
	current := normal.
	padding := normal minExtent - (0@5).

	toggleMode := false.
	self off.

