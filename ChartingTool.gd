extends Control

var bpm: float

var no_spawn = []
var half_spawn = []
var quarter_spawn = []
var eighth_spawn = []

var section

func _ready():
	print("Program Started")
	$OptionButton.add_item("EASY")
	$OptionButton.add_item("HARD")

		

func on_generate():
	var file = File.new()
	if file.open("res://VisiPiano.json", File.READ) == OK:
		var text: String = file.get_as_text()
		var data = JSON.parse(text)
		var midi = data.result
		create_chart(midi)

func create_chart(midi):
	bpm = midi["header"]["bpm"]
	var time_sig = midi["header"]["timeSignature"]
	var notes = midi["tracks"][2]["notes"]
	
	print(bpm)
	print(time_sig)

	half_spawn = []
	quarter_spawn = []
	eighth_spawn = []

	for note in notes:
		var midi_num = int(note["midi"])
		var beat = int(floor(float(note["time"]*2) / (60/bpm)) + 1)
		print(typeof(midi_num))
		match midi_num:
			71:
				no_spawn.append(beat)
				print("appended to No Spawn")
			72:
				half_spawn.append(beat)
				print("appended to Half")
			73:
				quarter_spawn.append(beat)
				print("appended to Qaurter")
			74:
				eighth_spawn.append(beat)
				print("appended to Eighth")
	
	export_chart()

		
		
			



func export_chart():
	var config = ConfigFile.new()
	section = $OptionButton.get_item_text($OptionButton.selected)

	config.set_value(section, "name", $NameField.text)
	config.set_value(section, "song_path", "")
	config.set_value(section, "loop_speed", 1)
	config.set_value(section, "music_volume", -3)
	config.set_value(section, "foley_volume", 0)
	config.set_value(section, "bpm", bpm)
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
	config.set_value(section, "transitions", {
		0:{
			"animation": null,
			"sound": null,
			"effects": null,
			"looping": false
			}
		})
	config.set_value(section, "lastBeat", [0])
	config.save("res://chart.cfg")

	OS.alert("Chart Successfully Generated", "Notice")

