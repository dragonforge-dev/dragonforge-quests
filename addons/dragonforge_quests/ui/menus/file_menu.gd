@tool
extends PopupMenu

@onready var graphs: GraphTabContainer = %Graphs


func _ready() -> void:
	id_pressed.connect(_on_id_pressed)


func _on_id_pressed(id: int) -> void:
	print(id)
	print(get_item_text(get_item_index(id)))
	
	match id:
		0: # New
			graphs.create_tab()
		1: # Open
			graphs.load_quest()
		2: # Save
			graphs.save_current_quest()
		3: # Close
			graphs.close_quest()
