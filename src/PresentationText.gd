extends Label

# Font size 50
# 984 pixels 
# 38 characters wide
# 8 characters height

var baseWidth = 1024; # 984
var baseHeight = 600;
var baseFontSize = 50;
var baseHChars = 38; # 38
var baseVChars = 8;

var masterFontWidth = baseWidth * baseFontSize
var masterFontHeight = baseHeight * baseFontSize

var currHChars = baseHChars;
var currVChars = baseVChars;


# 1920 * 16font * 38 characters / 2560 * characters = 12font

# Called when the node enters the scene tree for the first time.
func _ready():	
	var lines = text.split("\n")	
	currHChars = lines[0].length()
	currVChars = lines.size()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

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
	var hCharsModifier = float(baseHChars) / float(currHChars)
	var vCharsModifier = float(baseVChars) / float(currVChars)
	
	var newFontSizeByWidth = ((baseFontSize * 2) - (int((float(masterFontWidth) / float(current_size.x))))) * hCharsModifier
	
	var newFontSizeByHeight = ((baseFontSize * 2) - (int((float(masterFontHeight) / float(current_size.y))))) * vCharsModifier
	var newFontSize = newFontSizeByHeight
	if (newFontSize > newFontSizeByWidth):
		newFontSize = newFontSizeByWidth
		# print("Width adjust font")
	else:
		# print("Height adjust font")
		pass
	if (newFontSize < 20):
		newFontSize = 20
	get("custom_fonts/font").set_size(newFontSize)

func _on_PresentationText_resized():
	fit_text_to_screen()
