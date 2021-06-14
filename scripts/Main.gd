extends Control

func _ready():
	Global.save_dir = "user://" if OS.is_debug_build() == true else Global.exe_path
	$Splash/Panel/Dir.text = Global.save_dir
	$Splash.visible = true
	
# Song OGG

func song_popup():
	$Charter/SongPathField/SongFileDialog.current_dir = Global.popup_file_path
	$Charter/SongPathField/SongFileDialog.popup()

func on_song_selected(path):
	Global.song_file_path = path
	Global.song_file_name = $Charter/SongPathField/SongFileDialog.current_file
	Global.popup_file_path = $Charter/SongPathField/SongFileDialog.current_dir
	$Charter/SongPathField.text = Global.song_file_name
	$Conductor.stream = Func.load_ogg(Global.song_file_path)
	# print("loaded %s" % path)

	
	
# Midi / Json

# func json_popup():
# 	$Charter/JsonPath/JsonFileDialog.current_dir = Global.popup_file_path
# 	$Charter/JsonPath/JsonFileDialog.popup()

# func on_json_selected(path):
# 	Global.json_file_path = path
# 	Global.json_file_name = $Charter/JsonPath/JsonFileDialog.current_file
# 	Global.popup_file_path = $Charter/JsonPath/JsonFileDialog.current_dir
# 	$Charter/JsonPath.text = Global.json_file_name
# 	print("loaded %s" % path)
# 	collecct_midi_data(path)
# # Background Pattern

# func pattern_popup():
# 	$Charter/PatternPath/PatternFileDialog.current_dir = Global.popup_file_path
# 	$Charter/PatternPath/PatternFileDialog.popup()

# func on_pattern_selected(path):
# 	Global.pattern_file_path = path
# 	Global.pattern_file_name = $Charter/PatternPath/PatternFileDialog.current_file
# 	Global.popup_file_path = $Charter/PatternPath/PatternFileDialog.current_dir
# 	$Charter/PatternPath.text = Global.pattern_file_name
# 	print("loaded %s" % path)

# func collecct_midi_data(midi_path):
# 	var file = File.new()
# 	if file.open(midi_path, File.READ) == OK:
# 		var text: String = file.get_as_text()
# 		var data = JSON.parse(text)
# 		var midi = data.result
# 		Global.bpm = float(midi["header"]["bpm"])	
# 		$Charter/Bpm/CenterContainer/Label.text = str(Global.bpm)
# 		Global.bps = (60 / Global.bpm)
# 		Global.load_chart(midi)




# Sprite Sheet

var img = Image.new()
var tex = ImageTexture.new()

func sprite_sheet_popup():
	$Transitions/ImgPath/ImgFileDialog.current_dir = Global.popup_file_path
	$Transitions/ImgPath/ImgFileDialog.popup()

func on_img_file_selected(path):
	Global.sprite_sheet_file_path = path
	Global.sprite_sheet_name = $Transitions/ImgPath/ImgFileDialog.current_file
	Global.popup_file_path = $Transitions/ImgPath/ImgFileDialog.current_dir
	$Transitions/ImgPath.text = Global.sprite_sheet_name
	print("loaded %s" % path)
	img.load(path)
	tex.create_from_image(img)
	# $Transitions/Preview.hframes = 3
	# $Transitions/Preview.vframes = 2
	$Preview/Preview.scale = Vector2(0.373,0.37)
	$Preview/Preview.texture = tex

func _on_ButtonImageClear():
	Global.sprite_sheet_file_path = ""
	Global.sprite_sheet_name = ""
	$Transitions/ImgPath.text = ""
	$Preview/Preview.texture = null
	$Preview/Preview/Anim.stop()
	Global.previewing = false

#  SFX

func sfx_popup():
	$Transitions/SfxPath/SfxFileDialog.current_dir = Global.popup_file_path
	$Transitions/SfxPath/SfxFileDialog.popup()


func on_sfx_file_path_selected(path):
	Global.sfx_file_path = path
	Global.sfx_file_name = $Transitions/SfxPath/SfxFileDialog.current_file
	Global.popup_file_path = $Transitions/SfxPath/SfxFileDialog.current_dir
	$Transitions/SfxPath.text = Global.sfx_file_name
	print("loaded %s" % path)
	$Preview/Preview/PreviewSFX.stream = Func.load_ogg(path)

func _on_ButtonSfxClear():
	Global.sfx_file_path = ""
	Global.sfx_file_name = ""
	$Transitions/SfxPath.text = ""
	$Preview/Preview/PreviewSFX.stream = null

# FX Layer Sheet

func fx_img_popup():
	$Transitions/FxImgPath/FxImgFileDialog.current_dir = Global.popup_file_path
	$Transitions/FxImgPath/FxImgFileDialog.popup()


func on_fx_img_path_selected(path):
	Global.fx_img_path = path
	Global.fx_img_name = $Transitions/FxImgPath/FxImgFileDialog.current_file
	Global.popup_file_path = $Transitions/FxImgPath/FxImgFileDialog.current_dir
	$Transitions/FxImgPath.text = Global.fx_img_name
	print("loaded %s" % path)

func _on_ButtonFxImgClear():
	Global.fx_img_path = ""
	Global.fx_img_name = ""
	$Transitions/FxImgPath.text = ""

# Transition SFX

func transition_sfx_popup():
	$Transitions/TransitionSfxPath/TransitionSfxFileDialog.current_dir = Global.popup_file_path
	$Transitions/TransitionSfxPath/TransitionSfxFileDialog.popup()


func on_transition_sfx_path_selected(path):
	Global.transition_sfx_file_path = path
	Global.transition_sfx_file_name = $Transitions/TransitionSfxPath/TransitionSfxFileDialog.current_file
	Global.popup_file_path = $Transitions/TransitionSfxPath/TransitionSfxFileDialog.current_dir
	$Transitions/TransitionSfxPath.text = Global.transition_sfx_file_name
	print("loaded %s" % path)


func _on_transition_sfx_clear():
	Global.transition_sfx_file_path = ""
	Global.transition_sfx_file_name = ""
	$Transitions/TransitionSfxPath.text = ""

# Game Over

func game_over_sfx_popup():
	$Charter/GameOverSfxPath/GameOverSfxFileDialog.current_path = Global.popup_file_path
	$Charter/GameOverSfxPath/GameOverSfxFileDialog.popup()

func on_game_over_path_selected(path):
	Global.games_over_sfx_path = path
	Global.game_over_sfx_name = $Charter/GameOverSfxPath/GameOverSfxFileDialog.current_file
	Global.popup_file_path = $Charter/GameOverSfxPath/GameOverSfxFileDialog.current_path
	$Charter/GameOverSfxPath.text = Global.game_over_sfx_name
	print("loaded %s" % path)
