extends Reference
class_name StateMachine

# key = state_name, value = funcref []
var states = {}
var current_state
var current_state_name
#var _transitioned = false
# enter / exit will be automatically called on transition.
# others have to be manually invoked from process / physics process respectively
enum BEHAVIOUR_KEY { ENTER, EXIT, PROCESS, PHYSICS_PROCESS }

signal state_changed(new_state)

func add_state(name, behaviours: Dictionary):
	if states.has(name):
		printerr("Tried to add already existing state: ", name, ",to StateMachine Aborting!")

	states[name] = behaviours
	

func transition_to(state, allow_self: bool = false, cancel = false):
	if !allow_self && current_state == states[state]:
		return
	
	if cancel:
		current_state = null
		
	if current_state != null:
		state_exit()

	if !states.has(state):
		return
	
	current_state_name = state
	current_state = states[state]
	
	
#	_transitioned = true
	state_enter()
	emit_signal("state_changed", state)

func stop(exit_funcs: bool = true):
	if current_state != null && exit_funcs:
		state_exit()
		
	current_state = null

func state_enter():
	_run_funcs(BEHAVIOUR_KEY.ENTER)

func state_process():
	_run_funcs(BEHAVIOUR_KEY.PROCESS)

func state_physics_process():
	_run_funcs(BEHAVIOUR_KEY.PHYSICS_PROCESS)

func state_exit():
	_run_funcs(BEHAVIOUR_KEY.EXIT)

func _run_funcs(BK):
		if current_state == null || !current_state.has(BK):
			return

		var func_array = current_state[BK]
		var temp_state = current_state

		for n in func_array:
			var transition = n.call_func()
			#todo this might not catch all overlapping transitions,
			# when manually using "transition_to" from outside the sm
			if transition && temp_state == current_state:
				transition_to(transition)
				break


