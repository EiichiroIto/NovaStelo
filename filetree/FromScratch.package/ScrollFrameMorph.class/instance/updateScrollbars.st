private
updateScrollbars
	"Update my scrollbars based on my current contents."

	| visibleExtent currentScroll maxScroll |
	contents ifNil: [^ self].  "not fully initialized yet"

	visibleExtent := self visibleExtent.
	"hScrollbar percentVisible: (visibleExtent x asFloat / contents width).
	vScrollbar percentVisible: (visibleExtent y asFloat / contents height)."

	currentScroll := (self topLeft + borderWidth) - contents position.
	contents width > visibleExtent x
		ifTrue: [
			maxScroll := contents width - visibleExtent x.
			self showHorizontalScrollbar: true.
			hScrollbar
				scrollDelta: 4 / maxScroll asFloat 
				pageDelta: (visibleExtent x - 40) / maxScroll asFloat.
			hScrollbar value: currentScroll x / maxScroll]
		ifFalse: [
			self showHorizontalScrollbar: false.
			hScrollbar value: 0].

	contents height > visibleExtent y
		ifTrue: [
			maxScroll := contents height - visibleExtent y.
			self showVerticalScrollbar: true.
			vScrollbar
				scrollDelta: 4.0 / maxScroll asFloat 
				pageDelta: (visibleExtent y - 40) / maxScroll asFloat.
			vScrollbar value: currentScroll y / maxScroll]
		ifFalse: [
			self showVerticalScrollbar: false.
			vScrollbar value: 0].
