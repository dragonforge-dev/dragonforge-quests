@tool
@icon("uid://2xsqhs6xi5ew")
## When attached to a node like a [LineEdit] or [TextEdit], this disables the
## functionality that catches all Undo/Redo commands for the Quest Editor when 
## the parent node has focus allowing the commands to be passed up to the
## Godot Editor. In this way we do not have to re-implement Undo/Redo
## functionality for nodes that already have an implementation.
class_name BypassUndoRedoOnFocus extends Node


func _ready() -> void:
	get_parent().focus_entered.connect(_on_focus_entered)
	get_parent().focus_exited.connect(_on_focus_exited)


func _on_focus_entered() -> void:
	Quests.bypass_undo_redo.emit(true)


func _on_focus_exited() -> void:
	Quests.bypass_undo_redo.emit(false)
