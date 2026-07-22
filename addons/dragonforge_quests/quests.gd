@tool
@icon("uid://cu1tcdypslmjy")
## Quests Autoload
extends Node

signal add_graph_node(node: PackedScene)
signal execute(command: Command)
signal undo()
signal redo()
signal bypass_undo_redo(on: bool)
