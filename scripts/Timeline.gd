extends Panel

onready var timeline_nodes = [
	$Graph/Node,
	$Graph/Node2,
	$Graph/Node3,
	$Graph/Node4,
	$Graph/Node5,
	$Graph/Node6,
	$Graph/Node7,
	$Graph/Node8,
	$Graph/Node9,
	$Graph/Node10,
	$Graph/Node11,
	$Graph/Node12,
	$Graph/Node13,
	$Graph/Node14,
	$Graph/Node15,
	$Graph/Node16
]

var half_keyframes = []
var quarter_keyframes = []
var eighth_keyframes = []

onready var conductor = get_node("../Conductor")

func _ready():
	get_pages()
	refresh_nodes(0)
	connect_buttons()

func connect_buttons():
	for i in timeline_nodes.size():
		timeline_nodes[i].connect("gui_input", self, "_on_pressed", [i])

func _on_pressed(event, i):
	if event is InputEventMouseButton and event.pressed:
		var beat_num = i + (16 * Global.timeline_page)
		if event.button_index == BUTTON_LEFT:
			conductor._on_BeatNum_value_changed(beat_num)
			conductor._on_GoToBeat()
		elif event.button_index == BUTTON_RIGHT:
			clear_from_arrays(beat_num, Global.half_spawn, half_keyframes)
			clear_from_arrays(beat_num, Global.quarter_spawn, quarter_keyframes)
			clear_from_arrays(beat_num, Global.eighth_spawn, eighth_keyframes)

			clear_keyframe(beat_num % 16)
			get_pages()

func clear_from_arrays(beat_num, global, local):
	if global.has(beat_num):
		global.erase(beat_num)
		for keyframe in local:
			keyframe.erase(beat_num)
		print(local)



func _on_Conductor_beat(beat):
	Global.timeline_page = int(beat / 16)
	$PageLabel.text = "Current Page : %s" % Global.timeline_page
	refresh_nodes(beat % 16)

func refresh_nodes(beat):
	for i in timeline_nodes.size():
		timeline_nodes[i].modulate = Color(1,1,1,0.2)
	timeline_nodes[beat].modulate = Color(1,1,1,1)
	draw_colors()

func draw_colors():
	clear_colors()
	
	place_colors_on_timeline(half_keyframes, "#19a3db")
	place_colors_on_timeline(quarter_keyframes, "#f67858")
	place_colors_on_timeline(eighth_keyframes, "#e82928")


func place_colors_on_timeline(source_array, color):
	for notes in source_array:
		if notes.empty(): continue

		if Global.timeline_page == notes.values()[0]:
			timeline_nodes[notes.keys()[0] % 16].self_modulate = Color(color)

		
func clear_colors():
	for node in timeline_nodes:
		node.self_modulate =  Color(1,1,1,1)

func clear_keyframe(index):
	timeline_nodes[index].self_modulate =  Color(1,1,1,1)
		

func get_pages():
	chart_data_to_keyframe(Global.half_spawn, half_keyframes)
	chart_data_to_keyframe(Global.quarter_spawn, quarter_keyframes)
	chart_data_to_keyframe(Global.eighth_spawn, eighth_keyframes)


func chart_data_to_keyframe(source, target):
	for beat in source:
		var designated_page = floor(beat / 16)
		for obj in target:
			if obj.keys().has(beat): return
		target.append({beat:designated_page})






