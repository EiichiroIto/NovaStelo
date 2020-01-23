drawing
drawPoint: aPoint color: c on: aCanvas

	aCanvas fillRectangle: (self topLeft + aPoint extent: (1@1)) color: c.
