@icon("uid://bo17cv28siek3")
@abstract
## An interface class for creating commands that can be executed and undone.
class_name Command extends Resource


## Implement this to define what happens when this command is executed.
@abstract
func execute() -> void


## Implement this to define what happens when this command is undone.
@abstract
func undo() -> void
