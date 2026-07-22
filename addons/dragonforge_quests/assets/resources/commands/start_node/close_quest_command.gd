class_name CloseQuestCommand extends Command

var quest_graph_edit: QuestGraphEdit
var graph_tab_container: GraphTabContainer
var add_graph_tab: Control


func _init(quest_graph_edit: QuestGraphEdit, graph_tab_container: GraphTabContainer, add_graph_tab: Control) -> void:
	self.quest_graph_edit = quest_graph_edit
	self.graph_tab_container = graph_tab_container
	self.add_graph_tab = add_graph_tab


func execute() -> void:
	quest_graph_edit.reparent(Quests)
	quest_graph_edit.hide()
	Quests.execute.emit(self)


func undo() -> void:
	quest_graph_edit.reparent(graph_tab_container)
	quest_graph_edit.show()
	graph_tab_container.move_child(add_graph_tab, -1)
