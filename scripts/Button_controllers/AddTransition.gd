extends Button

func _process(_delta):
	disabled = !Global.sprite_sheet_name.is_valid_filename()

	
