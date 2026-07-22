class_name LoadQuestCommand extends Command

const FORCE_READABLE_NAME = true # Helper constant
const QUESTS_16_X_16 = preload("uid://dt03876p01rxq")


var container: GraphTabContainer
var quest_graph_edit: QuestGraphEdit
var add_graph_tab: Control
var load_path: String


func _init(load_path: String, graph_tab_container: GraphTabContainer, add_graph_tab: Control) -> void:
	self.load_path = load_path
	container = graph_tab_container
	self.add_graph_tab = add_graph_tab


func execute() -> void:
	var quest: Quest = ResourceLoader.load(load_path)
	quest_graph_edit = QuestGraphEdit.new()
	quest_graph_edit.name = quest.name
	quest_graph_edit.right_disconnects = true
	container.add_child(quest_graph_edit, FORCE_READABLE_NAME)
	container.set_tab_icon(container.get_tab_idx_from_control(quest_graph_edit), QUESTS_16_X_16)
	container.current_tab = container.get_tab_idx_from_control(quest_graph_edit)
	container.move_child(add_graph_tab, -1)
	quest_graph_edit.load_quest(load_path)
	Quests.execute.emit(self)


func undo() -> void:
	quest_graph_edit.queue_free()
