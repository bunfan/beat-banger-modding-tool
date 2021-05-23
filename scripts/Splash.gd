extends Control

func _on_splash_button_up():
	if !$Panel/ModName.text.is_valid_filename(): return OS.alert("Invalid Name")
	print("Generating Template for %s" % $Panel/ModName.text)
	# Make Dirs
	var dir = Directory.new()
	if dir.open(Global.save_dir) == OK:
		Global.chart_name = $Panel/ModName.text
		dir.make_dir(Global.chart_name)
		dir.make_dir(Global.chart_name + "/anims")
		dir.make_dir(Global.chart_name + "/anims/fx")
		dir.make_dir(Global.chart_name + "/sfx")
		dir.make_dir(Global.chart_name + "/songs")
		dir.make_dir(Global.chart_name + "/textures")
		print("Generated Template")
		visible = false
