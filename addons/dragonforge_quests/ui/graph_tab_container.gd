@tool
class_name GraphTabContainer extends TabContainer

@onready var add_graph_tab: Control = $AddGraphTab
@onready var load_file_dialog: FileDialog = %LoadFileDialog


func _ready() -> void:
	Quests.add_graph_node.connect(_on_add_graph_node)
	tab_clicked.connect(_on_tab_clicked)
	load_file_dialog.file_selected.connect(_on_load_file_selected)


func create_tab(tab_name: String = "New Quest") -> void:
	var command := CreateQuestCommand.new(tab_name, self, add_graph_tab)
	command.execute()


func _on_add_graph_node(scene: PackedScene) -> void:
	get_current_tab_control().add_graph_node(scene)


# Handles the new quest button being pressed.
func _on_tab_clicked(tab: int) -> void:
	if get_tab_control(tab) == add_graph_tab:
		create_tab()


# Calls the current tab's save() function.
func save_current_quest() -> void:
	get_current_tab_control().save_quest()


func load_quest() -> void:
	load_file_dialog.show()


func _on_load_file_selected(path: String) -> void:
	var command := LoadQuestCommand.new(path, self, add_graph_tab)
	command.execute()


func close_quest() -> void:
	var command := CloseQuestCommand.new(get_current_tab_control(), self, add_graph_tab)
	command.execute()
