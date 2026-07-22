@icon("uid://dsboqvrorf5oc")
## An abstract implementation of a linked list as a [Resource] to facilitate
## storing linked quest nodes.
@abstract
class_name QuestLinkedList extends QuestNode

## The node to the left of this node.
@export var left: QuestNode
## The node to the right of this node.
@export var right: QuestNode
