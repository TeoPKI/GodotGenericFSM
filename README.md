# GodotGenericFSM
A little different, flexible state machine for Godot. Built around Funcrefs.

Example implementation:
```
var sm := StateMachine.new()


func _ready():
	sm.add_state(
		"Hello World",
		{
			StateMachine.BEHAVIOUR_KEY.ENTER : [
				funcref(self, "hello_world"),
			]
	)
	
	sm.transition_to("Hello World")

func hello_world():
  	print("hello world");
```
