extends AudioStreamPlayer

var song_position = 0
var last_half_beat = 0

signal beat(half_beat)

func _on_preview(value):
	if value == true:
		
		if playing:
			set_stream_paused(false)
		else:
			last_half_beat = 0
			emit_signal("beat", last_half_beat)
			play()
	
		print("Playing Preview")
		Global.previewing = true
	else:
		set_stream_paused(true)
		print("Pausing Preview")
		Global.previewing = false

func _on_Stop_button_up():
	set_stream_paused(false)
	print("Stopping Preview")
	emit_signal("beat", 0)
	Global.previewing = false
	stop()

func _process(_delta):
	if playing: 
		#Get song position & Account for Latency
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
		)

		var half_beat = int(song_position / (Global.bps * 0.5))
		
		if half_beat > last_half_beat:
			# Emit Signals On Beat
			last_half_beat = half_beat
			emit_signal("beat", half_beat)
		
	
