extends Control

func _ready():
	$Splash.visible = true

# Charting

func json_popup():
	$Charter/JsonPath/JsonFileDialog.popup()

func on_json_selected(path):
	Global.json_file = path
	$Charter/JsonPath.text = $Charter/JsonPath/JsonFileDialog.current_file
	$Charter/GenerateChart.disabled = false
	print("loaded %s" % path)

# Sprite Sheet

var img = Image.new()
var tex = ImageTexture.new()

func sprite_sheet_popup():
	$Transitions/ImgPath/ImgFileDialog.popup()

func on_img_file_selected(path):
	Global.sprite_sheet_file_path = path
	Global.sprite_sheet_name = $Transitions/ImgPath/ImgFileDialog.current_file
	$Transitions/ImgPath.text = Global.sprite_sheet_name
	print("loaded %s" % path)
	img.load(path)
	tex.create_from_image(img)
	# $Transitions/Preview.hframes = 3
	# $Transitions/Preview.vframes = 2
	$Transitions/Preview.scale = Vector2(0.25,0.25)
	$Transitions/Preview.texture = tex
	$Transitions/Preview/Anim.play("Loop")
	$Transitions/AddTransition.disabled = false


#  SFX

func sfx_popup():
	$Transitions/SfxPath/SfxFileDialog.popup()


func on_sfx_file_selected(path):
	Global.sfx_file = path
	$Transitions/SfxPath.text = $Transitions/SfxPath/SfxFileDialog.current_file
	print("loaded %s" % path)

# FX Layer Sheet

func fx_img_popup():
	$Transitions/FxImgPath/FxImgFileDialog.popup()


func on_fx_img_file_selected(path):
	Global.fx_img_file = path
	$Transitions/FxImgPath.text = $Transitions/FxImgPath/FxImgFileDialog.current_file
	print("loaded %s" % path)

