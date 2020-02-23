private
addUnknownCategories
	blocks keys \ categoryColors keys
		do:
			[ :each | self addCategory: each color: self unknownCategoryColor ]