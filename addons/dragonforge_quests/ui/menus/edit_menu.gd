@tool
extends PopupMenu


func _ready() -> void:
	id_pressed.connect(_on_id_pressed)


func _on_id_pressed(id: int) -> void:
	print(id)
	print(get_item_text(get_item_index(id)))
	
	match id:
		0: # Undo
			Quests.undo.emit()
		1: # Redo
			Quests.redo.emit()
