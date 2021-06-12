extends Node

var exe_path = OS.get_executable_path().get_base_dir() + "/"
var save_dir


# Tool Vars

var bpm : float
var bps : float 
var previewing: bool
var loop_speed := 1.0
var last_beat: int

var music_volume := 0
var sfx_volume := 0
var current_beat = 0

var popup_file_path: String

# File Data

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

var transition_dict : Dictionary
var initial_data : Dictionary
