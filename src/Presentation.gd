extends Control

onready var presentation_background = get_node("Background")
onready var presentation_text = get_node("Background/PresentationText")
onready var presentation_image = get_node("Background/PresentationImage")
onready var filedialogue = get_node("FileDialog")
onready var darkmode = get_node("CenterContainer/MainMenu/MenuContainer/DarkMode")
onready var mainmenu = get_node("CenterContainer/MainMenu")
onready var window_button = get_node("CenterContainer/MainMenu/MenuContainer/WindowButton")
const ICON_IMAGE = "🖼"
const ICON_EOF = "📄"

var currentSlideIndex = 0
var slides = []
var file = File.new()

signal swipe
var swipe_start = null
var minimum_drag = 100

func set_presentation_image(filepath):
	print(filedialogue.current_dir)
	var fullfilepath = "{0}/{1}".format([filedialogue.current_dir, filepath.split("\n")[0].replace("@", "").strip_edges() ])
	if not file.file_exists(fullfilepath):
		set_presentation_text(ICON_IMAGE)
		print("Image not found!")
		return
	presentation_text.hide()
	presentation_image.show()	
	var image = Image.new()
	image.load(fullfilepath)
	var texture = ImageTexture.new()
	texture.create_from_image(image)
	presentation_image.set_texture(texture)
	
func set_presentation_text(text):
	presentation_text.show()
	presentation_image.hide()
	presentation_text.text = text
	if (presentation_text.text.find("\n") <= 0):
		presentation_text.align = Label.ALIGN_CENTER
	else:
		presentation_text.align = Label.ALIGN_LEFT
		
	presentation_text.set_char_bounds()
	presentation_text.fit_text_to_screen()
	
# Called when the node enters the scene tree for the first time.
func _ready():	
	var foo = "_"
	print("Char length : {0}".format([foo.to_utf8().size()]))
	var foo1 = "🐖"
	print("Char length : {0}".format([foo1.to_utf8().size()]))	
	var foo2 ="this is a test"
	
func get_file_text(file_path):
	if not file.file_exists(file_path):
    	print("No file selected!")
    	return ""
	file.open(file_path, file.READ)
	
	return file.get_as_text()	
	
func parse_file_text(file_text):
	var lines = file_text.split("\n")
	currentSlideIndex = 0
	var slideIndex = 0
	var slideText = ""
	slides.clear()
	
	for i in range(0, lines.size()):
		if((lines[i].length() <= 0) && (slideText.length() > 0)):
			slides.append(slideText)
			slideText = ""
		elif(lines[i].length() > 0):
			if lines[i].strip_edges().begins_with("#"):
				pass
			elif lines[i].strip_edges().length() == 1 and lines[i].strip_edges().begins_with("\\"):
				slideText = "{0}\n".format([slideText])
			elif slideText.length() > 0:
				slideText = "{0}\n{1}".format([slideText, lines[i]])
			else:
				slideText = lines[i]
	slides.append("eof {0}".format([ICON_EOF])) # There is an emoji here
	
func display_slide():
	var slide = slides[currentSlideIndex]
	if slide.strip_edges().begins_with("@"):
		set_presentation_image(slide)
	else:
		set_presentation_text(slide)

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_file():
	mainmenu.hide()	
	var file_path = filedialogue.current_path
	var file_text = get_file_text(file_path)
	parse_file_text(file_text)
	display_slide()	
	
func toggle_window():
	OS.window_fullscreen = !OS.window_fullscreen
	var window_button_text = "window"
	if (!OS.window_fullscreen):
		OS.set_window_size(Vector2(1024, 600))
		presentation_text._on_PresentationText_resized()
		window_button.text = ""
	else:
		window_button_text = "fullscreen"
	window_button.text = "    w: Window Mode ({0})".format([window_button_text])

func _on_FileDialog_confirmed():
	open_file()

func _on_FileDialog_file_selected(path):
	open_file()


func _on_DarkMode_toggled(button_pressed):
	if(button_pressed):
		presentation_background.color = Color.black
		presentation_text.set("custom_colors/font_color", Color.white)
	else:
		presentation_background.color = Color.white
		presentation_text.set("custom_colors/font_color", Color.black)
		

func _on_OpenFileButton_pressed():
	filedialogue.popup()


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_WindowButton_pressed():
	toggle_window()
	
func next_slide():
	if currentSlideIndex < slides.size() - 1:
		currentSlideIndex = currentSlideIndex + 1
	else:
		return
	display_slide()

func prev_slide():
	currentSlideIndex = currentSlideIndex - 1
	if currentSlideIndex < 0:
		currentSlideIndex = 0
	else:
		display_slide()
			
func _input(event):
	if event.is_action_pressed("ui_leftclick"):
		swipe_start = get_global_mouse_position()
	if event.is_action_released("ui_leftclick"):
		_calculate_swipe(get_global_mouse_position())
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_select") or Input.is_action_just_released("ui_down"):
		next_slide()
	if Input.is_action_just_released("ui_left") or Input.is_action_just_released("ui_up"):
		prev_slide()
	if Input.is_action_just_pressed("ui_open"):
		filedialogue.popup()
	if Input.is_action_just_pressed("ui_quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("ui_toggle"):
		darkmode.pressed = !darkmode.pressed
		_on_DarkMode_toggled(darkmode.pressed)
	if Input.is_action_just_pressed("ui_cancel"):
		presentation_text.hide()
		presentation_image.hide()
		mainmenu.show()
	if Input.is_action_just_pressed("ui_window_mode"):
		toggle_window()
	
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0:
			emit_signal("swipe", "right")
		else:
			emit_signal("swipe", "left")
		return
	if abs(swipe.y) > minimum_drag:
		if swipe.y > 0:
			emit_signal("swipe", "down")
		else:
			emit_signal("swipe", "up")
		

func _on_Control_swipe(args):
	if args == "right":
		next_slide()
	if args == "left":
		prev_slide()


