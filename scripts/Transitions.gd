extends Panel

func _ready():
	$LoopOption.add_item("Don't loop without input")
	$LoopOption.add_item("Loop without input")
func _on_PlayStop_button_up():
	if !Global.sprite_sheet_file: return print("No Animation Loaded")
	if $Preview/Anim.current_animation == "Loop":
		$Preview/Anim.stop()
		print("Stopping Loop")
	else:
		$Preview/Anim.play("Loop")
		print("Playing Loop")


