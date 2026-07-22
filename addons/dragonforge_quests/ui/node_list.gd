@tool
extends ItemList

## An [Array] of [PackedScene]s that map to the options in the [ItemList] for
## dragging and dropping into the [GraphEdit].
@export var graph_nodes: Array[PackedScene]


func _ready() -> void:
	item_activated.connect(_on_item_activated)


# Returns data and sets preview for dragging and dropping a [GraphNode].
func _get_drag_data(at_position: Vector2) -> Variant:
	var selected_index: int = get_selected_items()[0]
	var preview = TextureRect.new()
	preview.texture = get_item_icon(selected_index)
	set_drag_preview(preview)
	
	return { "type": "quest_graph_node", "quest_graph_node": graph_nodes[selected_index], "from": self}


func _on_item_activated(index: int) -> void:
	Quests.add_graph_node.emit(graph_nodes[index])
