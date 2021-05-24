extends Control

var no_spawn = []
var half_spawn = []
var quarter_spawn = []
var eighth_spawn = []

var section

var config = ConfigFile.new()

var c_octave = [36,48,60,72]
var cs_octave = [37,49,61,73]
var d_octave = [38,50,62,74]


func _ready():
	print("Program Started")
	$OptionButton.add_item("EASY")
	$OptionButton.add_item("HARD")	

func on_generate():
	load_json()


	
func load_json():
	var file = File.new()
	if file.open(Global.json_file_path, File.READ) == OK:
		var text: String = file.get_as_text()
		var data = JSON.parse(text)
		var midi = data.result
		create_chart(midi)


func create_chart(midi):

	# bpm = midi["header"]["bpm"]
	# var time_sig = midi["header"]["timeSignature"]
	var notes = midi["tracks"][2]["notes"]

	print(Global.bpm)

	half_spawn = []
	quarter_spawn = []
	eighth_spawn = []

	for note in notes:
		var midi_num = int(note["midi"])
		var beat = int(floor(float(note["time"]*2) / (60/Global.bpm)))
		if c_octave.has(midi_num):
			half_spawn.append(beat)
			print("appended %s to Half" % beat)
		elif cs_octave.has(midi_num):
			quarter_spawn.append(beat)
			print("appended %s to Qaurter" % beat)
		elif d_octave.has(midi_num):
			eighth_spawn.append(beat)
			print("appended %s to Eighth" % beat)
		else:
			no_spawn.append(beat)
			print("appended %s to No Spawn" % beat)

	export_chart()
	

func export_chart():

	var dir = Directory.new()
	if dir.open(Global.save_dir) == OK:
		if !Global.chart_name: return OS.alert("Enter a name for the mod")

		# Chart Dir
		var chart_dir = Global.save_dir + Global.chart_name

		# Copy song
		Func.copy_to_files(Global.song_file_path, Global.song_file_name, "/songs/")
					
		section = $OptionButton.get_item_text($OptionButton.selected)

		config.set_value(section, "name", Global.chart_name)
		config.set_value(section, "song_path", Global.song_file_name)
		config.set_value(section, "loop_speed", 1)
		config.set_value(section, "music_volume", Global.music_volume)
		config.set_value(section, "sfx_volume", Global.sfx_volume)
		config.set_value(section, "bpm", Global.bpm)
		config.set_value(section, "no_spawn", [0])
		config.set_value(section, "half_spawn", half_spawn)
		config.set_value(section, "quarter_spawn", quarter_spawn)
		config.set_value(section, "eighth_spawn", eighth_spawn)
		config.set_value(section, "initial_data", {
			"note_type": 1,
			"animation": null,
			"sound": null,
			"effects": null,
			"looping": true
		})
		config.set_value(section, "transitions", Global.transition_dict)
		config.set_value(section, "lastBeat", [0])
		config.save(chart_dir + "/chart.cfg")

		OS.alert("Generation Successful", "Notice")
		if OS.shell_open(ProjectSettings.globalize_path(chart_dir)) == OK:
			pass



