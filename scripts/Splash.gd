extends Control

var startup_config = ConfigFile.new()

func _ready():
	if startup_config.load("user://tool_data.cfg") == OK:
		Global.save_dir = startup_config.get_value("data", "mod_dir", null)
		
	if Global.save_dir != null:
		$Panel/Button.disabled = false

	$Panel/ModDir.text = "None" if Global.save_dir == null else Global.save_dir
	$Panel/ModName.grab_focus()

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
		
func _on_mod_dir_button():
	$Panel/ModDir/FileDialog.popup()


func _on_FileDialog_dir_selected(path: String):
	var dir = Directory.new()
	if dir.open(path) == OK:
		Global.save_dir = path
		$Panel/ModDir.text = path
		$Panel/Button.disabled = false
		startup_config.set_value("data", "mod_dir", Global.save_dir)
		startup_config.save("user://tool_data.cfg")
