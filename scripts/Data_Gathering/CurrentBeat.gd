extends Panel

func _ready():
	$CenterContainer/Label.text = str(Global.current_beat)

func _on_Conductor_beat(beat):
	Global.current_beat = beat
	$CenterContainer/Label.text = str(beat)

