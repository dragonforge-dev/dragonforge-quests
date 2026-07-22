class_name DeleteQuestNodeCommand extends Command

var quest_graph_edit: QuestGraphEdit
var position_offset: Vector2
var graph_node: GraphNode
var connections: Array


func _init(graph_node: GraphNode, quest_graph_edit: QuestGraphEdit) -> void:
	self.graph_node = graph_node
	self.quest_graph_edit = quest_graph_edit


func execute() -> void:
	for connection in quest_graph_edit.get_connection_list_from_node(graph_node.name):
		connections.append(connection)
	graph_node.selected = false
	graph_node.reparent(Quests)
	graph_node.hide()
	quest_graph_edit.node_index -= 1
	Quests.execute.emit(self)


func undo() -> void:
	graph_node.reparent(quest_graph_edit)
	graph_node.show()
	quest_graph_edit.node_index += 1
	for connection in connections:
		quest_graph_edit.connect_node(connection.from_node, connection.from_port, connection.to_node, connection.to_port)
