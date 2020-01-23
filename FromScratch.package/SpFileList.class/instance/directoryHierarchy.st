private
directoryHierarchy
	^ directory path segments
		withIndexCollect: [ :each :index | (String new: index withAll: Character space) , each ]