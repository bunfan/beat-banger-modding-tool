extends Control

var song
var playing = false
var song_position = 0.0

var calculated_half_beat: float
var rounded_half_beat: int

var bps: float
var bpm
var possible_sections = ["EASY","HARD"]
var section

var color_green = Color(0,1,0,1)
var color_red = Color(1,0,0,1)
var color_cyan = Color(0,1,1,1)

var z_spawn = []
var x_spawn = []
var c_spawn = []

var reported_beats = []
var last_note_type
var starting_note
var note_types = ["Z", "X", "C"]

func _ready():
	pass
	# $BpmField.text = "128"

func _process(_delta):
	if playing == true:
		
		song_position = (
		$Song.get_playback_position()
		+ AudioServer.get_time_since_last_mix()
		- AudioServer.get_output_latency()
		)

		bps = (60.0/float(bpm))
		calculated_half_beat = song_position / (bps * 0.5)
		rounded_half_beat = int(round(calculated_half_beat))
		print(calculated_half_beat)
		$_current_beat/label.text = "Current Beat: %s / %s" % [rounded_half_beat, calculated_half_beat]

func select_song():
	$FileDialog.popup()
	$FileDialog.set_filters(PoolStringArray(["*.ogg ; OGG Files"]))

func file_selected(_path):
	if playing == true: stop_song()
	$_file_name.text = "File Selected: %s" % $FileDialog.current_file
	song = load($FileDialog.current_file)

func difficulty_selected(index: int):
	section = possible_sections[index]
	$_current_difficulty/label.text = "Difficulty: %s" % possible_sections[index]

func starting_note_type_selected(index: int):
	$_starting_note_type_label/label.text = note_types[index]
	starting_note = note_types[index]
	last_note_type = note_types[index]

func button_play():

	# Check if playing already
	if playing == true: return

	# Check for BPM set Loaded
	if $BpmField.text == "": return show_message("No BPM set", color_red)
		
	bpm = float($BpmField.text)
		
	# Check if BPM greater than 0
	if bpm <= 0: return show_message("BPM must be greater than 0", color_red)

	# Check for Difficulty
	if section == null: return show_message("No Difficulty Selected", color_red)

	# Check for starting note type
	if starting_note == null: return show_message("No starting note type selected", color_red)

	# Check for File Loaded
	if $FileDialog.current_file == "": return show_message("No file selected", color_red)

	show_message("Playing", color_cyan)
	
	
	$BpmField.editable = false
	
	$Song.stream = song
	$Song.play()

	set_last_hit_note()

	print(reported_beats)

	playing = true
	

func button_stop():
	stop_song()

	
func stop_song():
	show_message("Stopping", color_cyan)
	$Song.stop()
	playing = false
	$BpmField.editable = true

func clear_all():
	$_z_spawn/z_spawn_list.clear()
	$_x_spawn/x_spawn_list.clear()
	$_c_spawn/c_spawn_list.clear()
	stop_song()
	

func _input(event):
	if playing == true:
		if !calculated_half_beat in reported_beats:

			if event.is_action_pressed("z"):
				if last_note_type != "Z":
					last_note_type = "Z"
					set_last_hit_note()
				
		
			if event.is_action_pressed("x"):
				if last_note_type != "X":
					last_note_type = "X"
					set_last_hit_note()

			if event.is_action_pressed("c"):
				if last_note_type != "C":
					last_note_type = "C"
					set_last_hit_note()

func set_last_hit_note():

	if rounded_half_beat == null:
		rounded_half_beat = 0

	match last_note_type:
		"Z":
			z_spawn.append(rounded_half_beat)
			$_z_spawn/z_spawn_list.add_item(str(rounded_half_beat))
		"X":
			x_spawn.append(rounded_half_beat)
			$_x_spawn/x_spawn_list.add_item(str(rounded_half_beat))
		"C":
			c_spawn.append(rounded_half_beat)
			$_c_spawn/c_spawn_list.add_item(str(rounded_half_beat))
		
	reported_beats.append(rounded_half_beat)
	$_last_note_type/label.text = "Last Note Type: %s" % last_note_type

func export_chart():

	# Check if playing already
	if playing == true: return

	# Check for BPM set Loaded
	if $BpmField.text == "": return show_message("No BPM set", color_red)
		
	bpm = float($BpmField.text)
		
	# Check if BPM greater than 0
	if bpm <= 0: return show_message("BPM must be greater than 0", color_red)

	# Check for Difficulty
	if section == null: return show_message("No Difficulty Selected", color_red)

	# Check for starting note type
	if starting_note == null: return show_message("No starting note type selected", color_red)

	# Check for File Loaded
	if $FileDialog.current_file == "": return show_message("No file selected", color_red)

	# Set to -1 if empty
	if z_spawn.size() == 0: z_spawn = [-1]
	if x_spawn.size() == 0: x_spawn = [-1]
	if c_spawn.size() == 0: c_spawn = [-1]

	var config = ConfigFile.new()
	config.set_value(section, "name", "Example")
	config.set_value(section, "notespeed", 2.66)
	config.set_value(section, "animspeed", 1)
	config.set_value(section, "music_volume", -3)
	config.set_value(section, "foley_volume", 0)
	config.set_value(section, "bpm", bpm)
	config.set_value(section, "no_spawn", [0])
	config.set_value(section, "z_spawn", z_spawn)
	config.set_value(section, "x_spawn", x_spawn)
	config.set_value(section, "c_spawn", c_spawn)
	config.set_value(section, "initial_data", {"animation": null,"sound": null,"effects": null})
	config.set_value(section, "transitions", {0:{"animation": null,"sound": null,"effects": null}})
	config.set_value(section, "lastBeat", [0])


	
	config.save("res://chart.cfg")
	show_message("Exporting chart configuration file", color_green)

func show_message(msg, color):
	print(msg)
	$_error.set("custom_colors/font_color", color)
	$_error.text = msg
	



	

