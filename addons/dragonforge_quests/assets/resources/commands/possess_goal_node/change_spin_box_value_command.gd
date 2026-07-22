class_name ChangeSpinBoxValueCommand extends Command

# The [SpinBox] whose value is being changed.
var spin_box: SpinBox
# The new value.
var new_value: float
# The previous value for undoing.
var previous_value: float


func _init(spin_box: SpinBox, new_value: float, previous_value: float) -> void:
	self.spin_box = spin_box
	self.new_value = new_value
	self.previous_value = previous_value


func execute() -> void:
	spin_box.set_value_no_signal(new_value)
	Quests.execute.emit(self)


func undo() -> void:
	spin_box.set_value_no_signal(previous_value)
