extends Panel


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

func _on_Stop_button_up():
	emit_signal("preview", false)
	$Preview/Anim.stop()

func _on_Conductor_beat(half_beat):
	if Global.previewing == false: return
	if half_beat % 2 == 0:
		$Preview/Anim.stop()
		$Preview/Anim.play("Loop")
		$Preview/PreviewSFX.play()

func _on_LoopSpeed_changed(value):
	Global.loop_speed = value
	$Preview/Anim.playback_speed = Global.loop_speed * 2
	
