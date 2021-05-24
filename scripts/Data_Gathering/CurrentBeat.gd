extends Panel


func _on_Conductor_beat(beat):
	Global.current_beat = beat
	$CenterContainer/Label.text = str(beat)

