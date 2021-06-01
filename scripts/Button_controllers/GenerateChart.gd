extends Button

func _process(_delta):
	disabled = !Global.song_file_name.is_valid_filename()

