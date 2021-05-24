extends Panel

func _ready():
	$LoopOption.add_item("Don't loop without input")
	$LoopOption.add_item("Loop without input")

var cur_frame: int

func on_LoopOption_selected(index):
	Global.no_input_looping = bool(index)
		
signal preview(value)
func _on_PlayStop_button_up():

	if !Global.sprite_sheet_file_path: return print("No Animation Loaded")
	if !Global.song_file_name: return print("No Song Loaded")
	if !Global.json_file_name: return print("No Chart Loaded")

	if $Preview/Anim.current_animation == "Loop":
		emit_signal("preview", false)
		$Preview/Anim.stop()
	else:
		emit_signal("preview", true)
		$Preview/Anim.playback_speed = Global.loop_speed * 2
		$Preview/Anim.play("Loop")
		
		
func _on_Conductor_beat(half_beat):
	if half_beat % 2 == 0:
		$Preview/Anim.stop()
		$Preview/Anim.play("Loop")
		$Preview/PreviewSFX.play()
	

func _on_AddTransition():

	$TransitionList.add_item("Transition to %s on Beat %s" % [Global.sprite_sheet_name, Global.current_beat])

	# Create Transition Object
	
	var transition_object = {
		"animation": Global.sprite_sheet_name,
		"effects": Global.fx_img_name,
		"looping": Global.no_input_looping,
		"sound": Global.sfx_file_name
	}

	Global.transition_dict[Global.current_beat] = transition_object
	print(Global.transition_dict)

	# Check image loaded
	if !Global.sprite_sheet_name.is_valid_filename(): return print("No Image Selected")
		
	# Copy files
	Func.copy_to_files(Global.sprite_sheet_file_path, Global.sprite_sheet_name, "/anims/")
	Func.copy_to_files(Global.sfx_file_path, Global.sfx_file_name, "/sfx/")
	Func.copy_to_files(Global.fx_img_path, Global.fx_img_name, "/anims/fx/")








