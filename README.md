# GodotGenericFSM
A little different, flexible state machine for Godot. Built around Funcrefs.

Example implementation:

var sm := StateMachine.new()
	sm.add_state(
		"Hello World",
		{
			StateMachine.BEHAVIOUR_KEY.ENTER : [
				funcref(self, "hello_world"),
			]
	)
	
  func hello_world():
	  print("hello world");
