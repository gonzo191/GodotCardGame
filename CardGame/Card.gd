tool
extends Control

# https://godotengine.org/qa/15622/how-do-i-get-the-correct-event-trigger
export var name = 'Lunar New Year'
export (int, "Lunar New Year", "Maraad", "Magni") var type setget set_type

onready var texture = get_node("TextureFrame")
onready var sprites = [
	preload('res://sprites/00.png'),
	preload('res://sprites/01.png'),
	preload('res://sprites/02.png')
]

# mouse states, self explanatory
var over = false
var pressed = false

# Handler for the input event signal on the specific card 
# Note: you can use the base _input_event(event) instead but that requires 
# the ready function whereas this just needs to be connected via the Node tab.
func on_card_input_event(event):
	if over && event.is_action_pressed("mouse"):
		# is the mouse over and was it pressed
		pressed = true
		focus_z_order()
	elif over && event.is_action_released("mouse"):
		# is the mouse over and was it released
		pressed = false
	
	# move the card to the mouse's position (a bit hacky)
	if over && pressed && event.type == InputEvent.MOUSE_MOTION:
		set_pos(get_global_mouse_pos() - get_size() / 2)

# Handler for the mouse_enter signal via the Node tab
func on_card_mouse_enter(): 
	over = true

# Handler for the mouse_exit signal via the Node tab
func on_card_mouse_exit(): 
	over = false

# Set the card image from the editor and have it displayed accordingly
func set_type(value):
	if texture != null:
		texture.set_texture(sprites[value])

# Just reset the z order of the parent node and set this z order to the highest for visual flare
func focus_z_order():
	for node in get_parent().get_parent().get_children():
		node.set_z(0)
	get_parent().set_z(1)

