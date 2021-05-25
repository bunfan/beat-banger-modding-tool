extends Button

func _process(_delta):
	if Global.song_file_name.is_valid_filename() and Global.json_file_name.is_valid_filename() and Global.pattern_file_name.is_valid_filename():
		disabled = false
	else:
		disabled = true
