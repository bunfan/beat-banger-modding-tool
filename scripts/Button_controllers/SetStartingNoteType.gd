extends OptionButton


func _on_OptionButton_item_selected(index):
	Global.starting_note_type = index
	Global.current_note_type = index