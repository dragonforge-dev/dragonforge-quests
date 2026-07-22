class_name AddQuestNodeCommand extends Command

const FORCE_READABLE_NAME = true # Helper constant

var scene: PackedScene
var quest_graph_edit: QuestGraphEdit
var position_offset: Vector2
var graph_node: GraphNode
var connections: Array


func _init(scene: PackedScene, quest_graph_edit: QuestGraphEdit, offset: Vector2) -> void:
	self.scene = scene
	self.quest_graph_edit = quest_graph_edit
	position_offset = offset


func execute() -> void:
	if not graph_node: # We run this the first time.
		graph_node = scene.instantiate()
		graph_node.position_offset += position_offset
		quest_graph_edit.add_child(graph_node, FORCE_READABLE_NAME)
		quest_graph_edit.node_index += 1
	else: # We run this on redo
		graph_node.reparent(quest_graph_edit)
		graph_node.show()
		quest_graph_edit.node_index += 1
		for connection in connections:
			quest_graph_edit.connect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)
	Quests.execute.emit(self)


func undo() -> void:
	for connection in quest_graph_edit.get_connection_list_from_node(graph_node.name):
		connections.append(connection)
	graph_node.selected = false
	graph_node.reparent(Quests)
	graph_node.hide()
	quest_graph_edit.node_index -= 1
