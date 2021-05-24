extends HSlider


func _on_MusicVolume_changed(value):
	Global.music_volume = value
	$Label.text = "Music Volume : %sdb" % value
	AudioServer.set_bus_volume_db(1,value)