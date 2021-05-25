extends Node

var save_dir = OS.get_executable_path().get_base_dir() + "/"

# Tool Vars

var bpm : float
var bps : float 
var previewing: bool
var loop_speed := 1.0

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

# Input Looping

var no_input_looping : bool

# Transitions

var transition_dict : Dictionary
var initial_data : Dictionary
