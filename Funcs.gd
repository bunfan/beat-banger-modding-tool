extends Node

func load_ogg(path):

	var ogg_file = File.new() # Instance new File Class
	ogg_file.open(path, File.READ) # Read File
	var bytes = ogg_file.get_buffer(ogg_file.get_len()) # Get data of OGG file in Bytes

	var ogg_stream = AudioStreamOGGVorbis.new() # Instance new Audio Stream
	ogg_stream.data = bytes # Copy Bytes from file to stream data
	ogg_file.close() # Close File
	
	return ogg_stream

func copy_to_files(old_path, filename, destination):
	var chart_dir = Global.save_dir + "/" + Global.chart_name + destination

	if filename.is_valid_filename():
		print("trying to copy to %s" % chart_dir + filename)

		var dir = Directory.new()
		if dir.open(chart_dir) == OK:
			dir.copy(old_path, chart_dir + filename)
			print("Writing to %s" % filename)

func store_asset(path, dialog, field):
	Global.popup_file_path = path.trim_suffix(dialog.current_file)
	field.text = dialog.current_file
	print("Loaded %s" % dialog.current_file)
	return [path, dialog.current_file]

func store_image_asset(path, dialog, field, image):
	var img = Image.new()
	var tex = ImageTexture.new()	
	Global.popup_file_path = path.trim_suffix(dialog.current_file)
	field.text = dialog.current_file
	print("loaded %s" % path)
	img.load(path)
	tex.create_from_image(img)
	image.scale = Vector2(0.373,0.37)
	image.texture = tex
	return [path, dialog.current_file]


