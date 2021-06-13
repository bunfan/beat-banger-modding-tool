extends Node

var exe_path = OS.get_executable_path().get_base_dir() + "/"
var save_dir


# Tool Vars

var no_spawn = []
var half_spawn = []
var quarter_spawn = []
var eighth_spawn = []
var bad_notes: int = 0

var bpm : float
var bps : float 
var previewing: bool
var loop_speed := 1.0
var last_beat: int

var music_volume := 0
var sfx_volume := 0
var current_beat = 0

# Preview variables

var notespeed_array = [
	0, #None
	1, #Half
	2, #Quarter
	4  #Eighth
]

var starting_note_type
var current_note_type: int setget set_current_note_type
var preview_buttons = []

func set_current_note_type(value):
	current_note_type = value
	for i in preview_buttons.size():
		preview_buttons[i].modulate = Color(1,1,1,0.4)
	preview_buttons[value].modulate = Color(1,1,1,1)


# File Data

var popup_file_path: String setget set_popup_file_path

func set_popup_file_path(value):
	popup_file_path = value
	# popup_file_path = ProjectSettings.globalize_path(value)
	print(popup_file_path)

var chart_name : String

var json_file_path : String
var json_file_name : String

var song_file_path : String
var song_file_name : String

var pattern_file_path : String
var pattern_file_name : String

var sprite_sheet_file_path : String
var sprite_sheet_name : String

var sfx_file_path : String
var sfx_file_name : String

var fx_img_path : String
var fx_img_name : String

var transition_sfx_file_path : String
var transition_sfx_file_name : String

var games_over_sfx_path: String
var game_over_sfx_name: String

# Params

var no_input_looping : bool
var screen_flash : bool = true

# Transitions

var transition_array = []
var transition_dict : Dictionary
var initial_data : Dictionary

# Function to Load Midi / Chart data
func load_chart(midi):
    print("Loading chart data...")
    create_chart(midi)

func find_notes(tracks):
    # Iterate through tracks to find notes
	for i in range(tracks.size()):
		if !tracks[i]["notes"].empty():
			return tracks[i]["notes"]

func create_chart(midi):

    # Grab notes data
	var notes = find_notes(midi["tracks"])

    # Clear arrays
	no_spawn = []
	half_spawn = []
	quarter_spawn = []
	eighth_spawn = []

	for note in notes:
		var note_name = note["name"]
		var beat = int(floor(float(note["time"]*2) / (60/bpm)))

		if note_name.findn("#") != -1:
			bad_note(note_name)
			continue
		elif note_name.findn("C") != -1:
			half_spawn.append(beat)
			continue
		elif note_name.findn("D") != -1:
			quarter_spawn.append(beat)
			continue
		elif note_name.findn("E") != -1:
			eighth_spawn.append(beat)
			continue
		elif note_name.findn("F") != -1:
			no_spawn.append(beat)
			continue
		else:
			bad_note(note_name)
			continue
	
	print(no_spawn)
	print(half_spawn)
	print(quarter_spawn)
	print(eighth_spawn)
        

func bad_note(note_name):
	bad_notes += 1
	print("%s Bad notes found (%s)" % [bad_notes, note_name])


# Full Screen
func _input(event):
	if !event is InputEventKey: return
	if event.is_action_pressed("Fullscreen"):
		OS.set_window_fullscreen(!OS.is_window_fullscreen())
