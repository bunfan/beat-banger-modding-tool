extends HSlider


func _on_SfxVolume_changed(value):
	Global.sfx_volume = value
	$Label.text = "SFX Volume : %sdb" % value
	AudioServer.set_bus_volume_db(2,value)