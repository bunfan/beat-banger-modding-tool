extends Control

var no_spawn = []
var half_spawn = []
var quarter_spawn = []
var eighth_spawn = []

var section

var config = ConfigFile.new()

var b_octave = [35,47,59,71]
var c_octave = [36,48,60,72]
var cs_octave = [37,49,61,73]
var d_octave = [38,50,62,74]


func _ready():
	print("Program Started")

func on_generate():
	load_json()
	export_chart()


	
func load_json():
	var file = File.new()
	if file.open(Global.json_file_path, File.READ) == OK:
		var text: String = file.get_as_text()
		var data = JSON.parse(text)
		var midi = data.result
		create_chart(midi)

func find_notes(tracks):
	for i in range(tracks.size()):
		if !tracks[i]["notes"].empty():
			return tracks[i]["notes"]

func create_chart(midi):

	# bpm = midi["header"]["bpm"]
	# var time_sig = midi["header"]["timeSignature"]
	var notes = find_notes(midi["tracks"])

	print(Global.bpm)

	half_spawn = []
	quarter_spawn = []
	eighth_spawn = []

	for note in notes:
		var midi_num = int(note["midi"])
		var beat = int(floor(float(note["time"]*2) / (60/Global.bpm)))
		if c_octave.has(midi_num):
			half_spawn.append(beat)
		elif cs_octave.has(midi_num):
			quarter_spawn.append(beat)
		elif d_octave.has(midi_num):
			eighth_spawn.append(beat)
		elif b_octave.has(midi_num):
			no_spawn.append(beat)
	

func export_chart():

	var dir = Directory.new()
	if dir.open(Global.save_dir) == OK:

		# Chart Dir
		var chart_dir = Global.save_dir + Global.chart_name

		# Copy song
		Func.copy_to_files(Global.song_file_path, Global.song_file_name, "/songs/")
		Func.copy_to_files(Global.pattern_file_path, Global.pattern_file_name, "/textures/")
		Func.copy_to_files(Global.games_over_sfx_path, Global.game_over_sfx_name, "/sfx/")
					
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
		config.set_value(section, "no_spawn", no_spawn)
		config.set_value(section, "half_spawn", half_spawn)
		config.set_value(section, "quarter_spawn", quarter_spawn)
		config.set_value(section, "eighth_spawn", eighth_spawn)
		config.set_value(section, "initial_data", Global.initial_data)
		config.set_value(section, "transitions", Global.transition_dict)
		config.set_value(section, "lastBeat", [Global.last_beat])

		config.save(chart_dir + "/chart.cfg")

		OS.alert("Generation Successful", "Notice")
		if OS.shell_open(ProjectSettings.globalize_path(chart_dir)) == OK:
			pass



