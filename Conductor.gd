extends AudioStreamPlayer

var song_position = 0
var last_half_beat = 0

signal beat(half_beat)

func _input(event):
	if event.is_action_pressed("StopReset"):
		_on_Stop_button_up()

func _on_preview():
	Global.previewing = !Global.previewing

	print(Global.previewing)

	if Global.previewing:

		# Play song again if stopped
		if !playing:
			play()

		# Unpause song and play next beat
		set_stream_paused(false)
		last_half_beat = 0
		emit_signal("beat", Global.current_beat)
		print("Playing Preview")

	else:
		# Pause song
		set_stream_paused(true)
		print("Pausing Preview")

func _on_Stop_button_up():
	# Stop song
	stop()
	Global.previewing = false
	emit_signal("beat", 0)
	print("Stopping Preview")
	
var goto_beat: float = 0

func _on_BeatNum_value_changed(value):
	goto_beat = value
	
func _on_GoToBeat():
	last_half_beat = 0
	var time = (Global.bps * 0.5) * goto_beat
	seek(time)
	print("GOTO")


func _process(_delta):
	if playing: 
		#Get song position & Account for Latency
		song_position = (
			get_playback_position() 
			+ AudioServer.get_time_since_last_mix()
			- AudioServer.get_output_latency()
		)

		#  x = y / ( 60 / BPM )
		#  60 / BPM * x = y

		var half_beat = int(song_position / (Global.bps * 0.5))
		
		if half_beat > last_half_beat:
			# Emit Signals On Beat
			last_half_beat = half_beat
			emit_signal("beat", half_beat)
		
	
