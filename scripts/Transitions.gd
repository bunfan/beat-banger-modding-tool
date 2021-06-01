extends Panel

func _ready():
	$LoopOption.add_item("Don't loop without input")
	$LoopOption.add_item("Loop without input")

var cur_frame: int

func on_LoopOption_selected(index):
	Global.no_input_looping = bool(index)

func _on_screen_flash_toggled(value):
	Global.screen_flash = value


func _on_AddTransition():

	if Global.current_beat == 0:
		$TransitionList.add_item("Set Starting Animatiom to %s" % [Global.sprite_sheet_name])

		Global.initial_data = {
			"animation": Global.sprite_sheet_name,
			"looping": Global.no_input_looping,
			"sound_fx": Global.sfx_file_name,
			"note_type": 1
		}	

	else:

		$TransitionList.add_item("Transition to %s on Beat %s" % [Global.sprite_sheet_name, Global.current_beat])

		# Create Transition Object
		
		var transition_object = {
			"animation": Global.sprite_sheet_name,
			"effects": Global.fx_img_name,
			"looping": Global.no_input_looping,
			"sound_fx": Global.sfx_file_name,
			"transition_sound": Global.transition_sfx_file_name
		}

		Global.transition_dict[Global.current_beat] = transition_object
		Global.last_beat = Global.transition_dict.keys().back()

	# Check image loaded
	if !Global.sprite_sheet_name.is_valid_filename(): return print("No Image Selected")
		
	# Copy files
	Func.copy_to_files(Global.sprite_sheet_file_path, Global.sprite_sheet_name, "/anims/")
	Func.copy_to_files(Global.transition_sfx_file_path, Global.transition_sfx_file_name, "/sfx/")
	Func.copy_to_files(Global.sfx_file_path, Global.sfx_file_name, "/sfx/")
	Func.copy_to_files(Global.fx_img_path, Global.fx_img_name, "/anims/fx/")








