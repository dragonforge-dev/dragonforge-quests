class_name CreateQuestCommand extends Command

const FORCE_READABLE_NAME = true # Helper constant
const QUESTS_16_X_16 = preload("uid://dt03876p01rxq")


var name: String
var graph_tab_container: GraphTabContainer
var quest_graph_edit: QuestGraphEdit
var add_graph_tab: Control


func _init(quest_name: String, graph_tab_container: GraphTabContainer, add_graph_tab: Control) -> void:
	name = quest_name
	self.graph_tab_container = graph_tab_container
	self.add_graph_tab = add_graph_tab


func execute() -> void:
	quest_graph_edit = QuestGraphEdit.new()
	quest_graph_edit.name = name
	quest_graph_edit.right_disconnects = true
	graph_tab_container.add_child(quest_graph_edit, FORCE_READABLE_NAME)
	graph_tab_container.set_tab_icon(graph_tab_container.get_tab_idx_from_control(quest_graph_edit), QUESTS_16_X_16)
	graph_tab_container.current_tab = graph_tab_container.get_tab_idx_from_control(quest_graph_edit)
	graph_tab_container.move_child(add_graph_tab, -1)
	Quests.execute.emit(self)


func undo() -> void:
	quest_graph_edit.queue_free()
