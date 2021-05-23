extends Panel


func _on_PlayStop_button_up():
	if $Preview.vframes < 2: return
	if $Preview/Anim.current_animation == "Loop":
		$Preview/Anim.stop()
	else:
		$Preview/Anim.play("Loop")

	print("playing")
