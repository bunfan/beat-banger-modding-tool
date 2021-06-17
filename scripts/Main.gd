extends Control



func _ready():
	$Splash.visible = true
	print(Global.popup_file_path)
	
# Popups

func song_popup():
	$Charter/SongPathField/SongFileDialog.current_dir = Global.popup_file_path
	$Charter/SongPathField/SongFileDialog.popup()

func pattern_popup():
	$Charter/PatternPath/PatternFileDialog.current_dir = Global.popup_file_path
	$Charter/PatternPath/PatternFileDialog.popup()

func game_over_sfx_popup():
	$Charter/GameOverSfxPath/GameOverSfxFileDialog.current_dir = Global.popup_file_path
	$Charter/GameOverSfxPath/GameOverSfxFileDialog.popup()

func sprite_sheet_popup():
	$Transitions/ImgPath/ImgFileDialog.current_dir = Global.popup_file_path
	$Transitions/ImgPath/ImgFileDialog.popup()

func fx_img_popup():
	$Transitions/FxImgPath/FxImgFileDialog.current_dir = Global.popup_file_path
	$Transitions/FxImgPath/FxImgFileDialog.popup()
	
func sfx_popup():
	$Transitions/SfxPath/SfxFileDialog.current_dir = Global.popup_file_path
	$Transitions/SfxPath/SfxFileDialog.popup()

func transition_sfx_popup():
	$Transitions/TransitionSfxPath/TransitionSfxFileDialog.current_dir = Global.popup_file_path
	$Transitions/TransitionSfxPath/TransitionSfxFileDialog.popup()


# Global Asset Storage

func on_song_selected(path):
	var data = Func.store_asset(
		path, 
		$Charter/SongPathField/SongFileDialog,
		$Charter/SongPathField
	)
	Global.song_file_path = data[0]
	Global.song_file_name = data[1]
	$Conductor.stream = Func.load_ogg(path)

func on_pattern_selected(path):
	var data = Func.store_asset(
		path, 
		$Charter/PatternPath/PatternFileDialog,
		$Charter/PatternPath
	)
	Global.pattern_file_path = data[0]
	Global.pattern_file_name = data[1]

func on_game_over_path_selected(path):
	var data = Func.store_asset(
		path, 
		$Charter/GameOverSfxPath/GameOverSfxFileDialog,
		$Charter/GameOverSfxPath
	)
	Global.games_over_sfx_path = data[0]
	Global.game_over_sfx_name = data[1]

# Transition Asset Storage	

func on_img_file_selected(path):
	var data = Func.store_image_asset(
		path,
		$Transitions/ImgPath/ImgFileDialog,
		$Transitions/ImgPath,
		$Preview/Preview
	)
	Global.sprite_sheet_file_path = data[0]
	Global.sprite_sheet_name = data[1]


func on_sfx_file_path_selected(path):
	var data = Func.store_asset(
		path, 
		$Transitions/SfxPath/SfxFileDialog,
		$Transitions/SfxPath
	)
	Global.sfx_file_path = data[0]
	Global.sfx_file_name = data[1]
	$Preview/Preview/PreviewSFX.stream = Func.load_ogg(path)

func on_fx_img_path_selected(path):
	var data = Func.store_image_asset(
		path,
		$Transitions/FxImgPath/FxImgFileDialog,
		$Transitions/FxImgPath,
		$Preview/Fx
	)
	Global.fx_img_path = data[0]
	Global.fx_img_name = data[1]


func on_transition_sfx_path_selected(path):
	var data = Func.store_asset(
		path, 
		$Transitions/TransitionSfxPath/TransitionSfxFileDialog,
		$Transitions/TransitionSfxPath
	)
	Global.transition_sfx_file_path = data[0]
	Global.transition_sfx_file_name = data[1]



# Clear Events

func _on_ButtonImageClear():
	Global.sprite_sheet_file_path = ""
	Global.sprite_sheet_name = ""
	$Transitions/ImgPath.text = ""
	$Preview/Preview.texture = null
	$Preview/Preview/Anim.stop()
	Global.previewing = false

func _on_ButtonFxImgClear():
	Global.fx_img_path = ""
	Global.fx_img_name = ""
	$Transitions/FxImgPath.text = ""

func _on_ButtonSfxClear():
	Global.sfx_file_path = ""
	Global.sfx_file_name = ""
	$Transitions/SfxPath.text = ""
	$Preview/Preview/PreviewSFX.stream = null

func _on_transition_sfx_clear():
	Global.transition_sfx_file_path = ""
	Global.transition_sfx_file_name = ""
	$Transitions/TransitionSfxPath.text = ""

