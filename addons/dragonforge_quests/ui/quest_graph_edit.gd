@tool
@icon("uid://cu8xqwekwfxve")
class_name QuestGraphEdit extends GraphEdit

const FORCE_READABLE_NAME = true # Helper for code readbility
const START_QUEST_GRAPH_NODE = preload("uid://cth6kkxg234md")

# The offset for the first node placed.
var initial_position := Vector2(20, 20)
# The offset for each new node added.
var node_offset : = Vector2(20, 40)
# How many nodes have been added.
var node_index: int = 0
# Reference to the automatically generated Start Node.
var start_node: StartQuestGraphNode
# Path to save the [Quest] resource.
var save_path: String
# The [Quest] resource for this graph.
var quest: Quest
# The dialog for creating a file path. Needs to be hardcoded or it won't
# work for newly created nodes. So we cannot use a unique name.
@onready var save_file_dialog: FileDialog = $"../../../../SaveFileDialog"


func _ready() -> void:
	connection_request.connect(_on_connection_request)
	disconnection_request.connect(_on_disconnection_request)
	
	start_node = START_QUEST_GRAPH_NODE.instantiate()
	start_node.position_offset += initial_position + node_offset
	add_child(start_node, FORCE_READABLE_NAME)
	node_index += 2
	start_node.quest_name.text = name
	start_node.previous_name = name


# Determines if data can be dropped on this node. We only want to allow
# GraphNodes.
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true


# When a GraphNode is dropped, drop it.
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data.has("quest_graph_node"):
		var command: Command = AddQuestNodeCommand.new(data["quest_graph_node"], self, at_position - Vector2(0, 30))
		command.execute()


func _on_connection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	var command := ConnectQuestNodeCommand.new(self, from_node, from_port, to_node, to_port)
	command.execute()


func _on_disconnection_request(from_node: StringName, from_port: int, to_node: StringName, to_port: int) -> void:
	var command := DisconnectQuestNodeCommand.new(self, from_node, from_port, to_node, to_port)
	command.execute()


func add_graph_node(scene: PackedScene) -> void:
	var command: Command = AddQuestNodeCommand.new(scene, self, initial_position + (node_index * node_offset))
	command.execute()


func save_quest() -> void:
	# If we don't have a save path yet, we need to create one.
	if not save_path:
		save_file_dialog.show()
		save_file_dialog.file_selected.connect(_on_save_file_selected)
		return
	
	start_node.save_quest(save_path)
	name = save_path.get_file()


func load_quest(path: String) -> void:
	# Make sure we save this to the same place when saved.
	save_path = path
	start_node.load_quest(path)
	print(save_path.get_file())
	name = save_path.get_file()


func _on_save_file_selected(path: String) -> void:
	save_file_dialog.file_selected.disconnect(_on_save_file_selected)
	save_path = path
	print(path)
	save_quest()
