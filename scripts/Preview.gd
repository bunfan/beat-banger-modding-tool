extends Panel


signal preview(value)

onready var preview_buttons = [
	$HBoxContainer/Button,
	$HBoxContainer/Button2,
	$HBoxContainer/Button3,
	$HBoxContainer/Button4
]

onready var starting_note_type_selector = get_node("../Charter/OptionButton")

func _ready():
	Global.preview_buttons = preview_buttons

func _on_PlayStop_button_up():

	if !Global.sprite_sheet_file_path: return print("No Animation Loaded")
	if !Global.song_file_name: return print("No Song Loaded")
	if !Global.json_file_name: return print("No Chart Loaded")

	if $Preview/Anim.current_animation == "Loop":
		emit_signal("preview", false)
		$Preview/Anim.stop()
	else:
		if Global.current_beat == 0: 
			Global.current_note_type = starting_note_type_selector.selected
			$Preview/Anim.playback_speed = Global.loop_speed * Global.notespeed_array[Global.current_note_type]
		emit_signal("preview", true)
		$Preview/Anim.play("Loop")

func _on_Stop_button_up():
	# Reset Beat Data
	Global.current_note_type = starting_note_type_selector.selected
	Global.current_beat = 0

	# Stop Aniamtion
	emit_signal("preview", false)
	$Preview/Anim.stop()

func _on_Conductor_beat(half_beat):
	if Global.previewing == false: return

	# Transitions
	if !Global.transition_array.empty():
		for transition in Global.transition_array:
			if transition[0] == half_beat:
				flash()
				load_image(transition)
				load_fx(transition)
				load_ogg_and_play(transition)
				
				

	# Get Note type
	if Global.half_spawn.has(half_beat):
		print("Half Beat")
		Global.current_note_type = 1
	elif Global.quarter_spawn.has(half_beat):
		print("Quarter Beat")
		Global.current_note_type = 2
	elif Global.eighth_spawn.has(half_beat):
		print("Eighth Beat")
		Global.current_note_type = 3
	# elif Global.no_spawn.has(half_beat):
	# 	print("No Beat")
	# 	Global.current_note_type

	# Change loop speed based on note type
	if Global.current_note_type == 1:
		if half_beat % 4 == 0:
			$Preview/Anim.playback_speed = Global.loop_speed * 1
			run_loop()
	elif Global.current_note_type == 2:
		if half_beat % 2 == 0:
			$Preview/Anim.playback_speed = Global.loop_speed * 2
			run_loop()
	elif Global.current_note_type == 3:
		$Preview/Anim.playback_speed = Global.loop_speed * 4
		run_loop()

func run_loop():
	$Preview/Anim.stop()
	$Preview/Anim.play("Loop")
	$Preview/PreviewSFX.play()
	$Preview/Tween.interpolate_property($Preview,"modulate", Color(1,1,1,1), Color(0.6,0.6,0.6,1), 1/$Preview/Anim.playback_speed)
	$Preview/Tween.start()

func _on_LoopSpeed_changed(value):
	Global.loop_speed = value
	
func load_image(transition):
	var img = Image.new()
	img.load(Global.save_dir + Global.chart_name + "/anims/" + transition[1]["animation"])
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$Preview.texture = tex

func load_fx(transition):
	var img = Image.new()
	img.load(Global.save_dir + Global.chart_name + "/anims/fx/" + transition[1]["effects"])
	var tex = ImageTexture.new()
	tex.create_from_image(img)
	$Fx.texture = tex
	$Fx/Anim.play("Loop_fx")

func load_ogg_and_play(transition):
	var ogg_file = File.new()
	if ogg_file.open(Global.save_dir + Global.chart_name + "/sfx/" + transition[1]["transition_sound"], File.READ) == OK:
		var bytes = ogg_file.get_buffer(ogg_file.get_len())
		var stream_data = AudioStreamOGGVorbis.new()
		stream_data.data = bytes
		ogg_file.close()
		$TransitionSound.stream = stream_data
		$TransitionSound.play()


func flash():
	if Global.screen_flash == true:
		$Flash/Tween.interpolate_property(
			$Flash,
			"color",
			Color(1,1,1,1),
			Color(1,1,1,0),
			1.0
		)
		$Flash/Tween.start()
