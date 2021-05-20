extends LineEdit

func popup():
	$FileDialog.popup()

func on_file_selected(path):
	print("loading %s" % path)
	Global.json_file = path
	var button = get_parent().get_node("Button")
	print(button)
	button.disabled = false
	text = path

