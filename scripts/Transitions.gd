extends Panel

func _ready():
	$LoopOption.add_item("Don't loop without input")
	$LoopOption.add_item("Loop without input")

var cur_frame: int

func on_LoopOption_selected(index):
	Global.no_input_looping = bool(index)

func _on_screen_flash_toggled(value):
	Global.screen_flash = value

func _on_TransitionList_item_rmb_selected(index, _position):
	print("Removing transition on beat %s" % Global.transition_array[index][0])
	Global.transition_array.remove(index)
	refresh_list()

func _on_AddTransition():

	if Global.current_beat == 0:
		

		Global.initial_data = {
			"animation": Global.sprite_sheet_name,
			"looping": Global.no_input_looping,
			"sound_fx": Global.sfx_file_name,
			"note_type": Global.starting_note_type
		}

		$StartingData.placeholder_text = "Starting Animation : %s" % Global.initial_data["animation"]

	else:

		# Create Transition Object
		
		var transition_object = {
			"animation": Global.sprite_sheet_name,
			"effects": Global.fx_img_name,
			"looping": Global.no_input_looping,
			"sound_fx": Global.sfx_file_name,
			"transition_sound": Global.transition_sfx_file_name
		}

		# Write Transition Object
		Global.transition_array.append([Global.current_beat, transition_object])

	refresh_list()

	# Check image loaded
	if !Global.sprite_sheet_name.is_valid_filename(): return print("No Image Selected")
		
	# Copy files
	Func.copy_to_files(Global.sprite_sheet_file_path, Global.sprite_sheet_name, "/anims/")
	Func.copy_to_files(Global.transition_sfx_file_path, Global.transition_sfx_file_name, "/sfx/")
	Func.copy_to_files(Global.sfx_file_path, Global.sfx_file_name, "/sfx/")
	Func.copy_to_files(Global.fx_img_path, Global.fx_img_name, "/anims/fx/")


func refresh_list():
	$TransitionList.clear()
	Global.transition_array.sort_custom(self, "sort_transitions")
	for transition in Global.transition_array:
		# Add to list
		var transition_string = "%s: " % transition[0]
		if transition[1]["animation"] != "":
			transition_string += "%s" % transition[1]["animation"]
		if transition[1]["effects"] != "":
			transition_string += " | %s" % transition[1]["effects"] 
		if transition[1]["transition_sound"] != "":
			transition_string += " | %s" % transition[1]["transition_sound"]
		$TransitionList.add_item(transition_string)


func sort_transitions(a,b):
	if a[0] < b[0]:
		return true
	return false








