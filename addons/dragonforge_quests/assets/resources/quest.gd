@icon("uid://gf6imdhxeh0m")
# A [Resource] representation of a StartQuestGraphNode.
class_name Quest extends QuestNode

## The display name for the quest.
@export var name: String
## The initial text to display to remind the player of the quest story.
@export var description: String
## Stores any boolean states that need to be checked by code. By default,
## every [Quest] tracks whether it is completed or not. (A quest is considered
## started when it is added to the player's Quest UI.)
@export var states: Dictionary[String, bool] = {
	"is_complete": false,
}
## All the quest goals linked to this quest. More than one in parallel means
## that all must be completed. Goals linked in serial must be completed in order.
@export var goals: Array[QuestNode]
## All the rewards linked to this quest. More than one means all rewards are
## given at the end of the quest.
@export var rewards: Array[QuestNode]
## All the failure conditions linked to this quest. More than one means that any
## condition causes the quest to fail.
@export var failures: Array[QuestNode]
