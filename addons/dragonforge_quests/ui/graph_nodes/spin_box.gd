@tool
extends SpinBox

@onready var previous_value: float = value


func _ready() -> void:
	value_changed.connect(_on_value_changed)


func _on_value_changed(value: float) -> void:
	var command := ChangeSpinBoxValueCommand.new(self, value, previous_value)
	command.execute()
	previous_value = value
