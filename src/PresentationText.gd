extends Label

var currHChars = 0
var currVChars = 0
const MODFIER = 1.75
const MINFONTSIZE = 20

func set_char_bounds():
	var lines = text.split("\n")
	currHChars = 0
	currVChars = lines.size()
	for i in range(0, lines.size()):
		if(lines[i].length() > currHChars):
			currHChars = lines[i].length()
			for j in range(0, currHChars - 1):
				if(lines[i][j].to_utf8().size() > 1):
					# Wide characters
					currHChars = currHChars + 1

func fit_text_to_screen():
	if(currHChars <= 0):
		return
	
	var current_size = OS.get_window_size()
	
	var newFontSizeByWidth = int(ceil(current_size.x / currHChars) * MODFIER)

	var newFontSizeByHeight = int(ceil(current_size.y / currVChars) * MODFIER)
	var newFontSize = max(min(newFontSizeByHeight, newFontSizeByWidth), MINFONTSIZE)

	#print("{0}Chars: {1} -> Font: {2}".format([modfiedType, currHChars, newFontSize]))
	print("V:{0} H:{1} F:{2}".format([newFontSizeByHeight, newFontSizeByWidth, newFontSize]))
	get("custom_fonts/font").set_size(newFontSize)

func _on_PresentationText_resized():
	fit_text_to_screen()
