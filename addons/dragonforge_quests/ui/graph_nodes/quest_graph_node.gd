@tool
class_name QuestGraphNode extends GraphNode


func _ready() -> void:
	delete_request.connect(_on_delete_request)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_graph_delete") and selected:
		delete_request.emit()


func _on_delete_request() -> void:
	var command := DeleteQuestNodeCommand.new(self, get_parent())
	command.execute()
