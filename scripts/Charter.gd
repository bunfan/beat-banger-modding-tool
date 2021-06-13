extends Control

var section

var config = ConfigFile.new()
var user_data = ConfigFile.new()

func _ready():

	if user_data.load("user://tool_data.cfg") == OK:
		Global.popup_file_path = user_data.get_value("data", "saved_dir", "/")

	print("Program Started")

func on_generate():
	export_chart()
	

func export_chart():

	var dir = Directory.new()
	if dir.open(Global.save_dir) == OK:

		# Chart Dir
		var chart_dir = Global.save_dir + Global.chart_name

		# Copy song
		Func.copy_to_files(Global.song_file_path, Global.song_file_name, "/songs/")
		Func.copy_to_files(Global.pattern_file_path, Global.pattern_file_name, "/textures/")
		Func.copy_to_files(Global.games_over_sfx_path, Global.game_over_sfx_name, "/sfx/")

		# Write Transitions to main object
		for transition in Global.transition_array:
			Global.transition_dict[transition[0]] = transition[1]

		Global.last_beat = Global.transition_dict.keys().back()
					
		section = "EASY"

		config.set_value(section, "name", Global.chart_name)
		config.set_value(section, "song_path", Global.song_file_name)
		config.set_value(section, "loop_speed", Global.loop_speed)
		config.set_value(section, "music_volume", Global.music_volume)
		config.set_value(section, "sfx_volume", Global.sfx_volume)
		config.set_value(section, "bpm", Global.bpm)
		config.set_value(section, "note_offset", 0.0)
		config.set_value(section, "screen_flash", Global.screen_flash)
		config.set_value(section, "game_over_sound", Global.game_over_sfx_name)
		config.set_value(section, "post_song_delay", $PostSongDelay.value)
		config.set_value(section, "no_spawn", Global.no_spawn)
		config.set_value(section, "half_spawn",Global.half_spawn)
		config.set_value(section, "quarter_spawn", Global.quarter_spawn)
		config.set_value(section, "eighth_spawn", Global.eighth_spawn)
		config.set_value(section, "initial_data", Global.initial_data)
		config.set_value(section, "transitions", Global.transition_dict)
		config.set_value(section, "lastBeat", [Global.last_beat])

		config.save(chart_dir + "/chart.cfg")

		OS.alert("Generation Successful", "Notice")
		if OS.shell_open(ProjectSettings.globalize_path(chart_dir)) == OK:
			pass


func _on_Charter_tree_exiting():
	if Global.popup_file_path == "": return
	user_data.set_value("data", "saved_dir", Global.popup_file_path)
	user_data.save("user://tool_data.cfg")


