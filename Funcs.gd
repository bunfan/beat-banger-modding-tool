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

	var chart_dir = Global.save_dir + Global.chart_name	

	if filename.is_valid_filename():
		var sfx_dir = Directory.new()
		if sfx_dir.open(chart_dir + destination) == OK:
			sfx_dir.copy(old_path, chart_dir + destination + filename)
	


