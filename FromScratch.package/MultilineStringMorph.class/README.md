An editable, multiple-line string in a single font with line wrapping.

Best for small amounts of text; for longer texts or texts with multiple type styles, see TextMorph.

My contents are stored in an array of strings ('lines') with all non-printing characters except cr's and spaces stripped out and tabs are replaced by a sequence of spaces.

Selection start and end points are represented as points where y holds the line number and x holds the index in the line of the character immediately after the selection point. The range of x for line L is thus 1 to (L size + 1), where the last selection point within the line is just before the line break.

Possible improvements:
  a. handle tabs correctly
  b. preserve non-printing characters (could be useful for editing files)
