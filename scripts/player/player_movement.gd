class_name PlayerMovement extends Node

##the below given by player node
var body: CharacterBody2D
var input_handler: PlayerInputProcessor
var default_params: Resource:
	set(value):
		default_params = value
		set_default_params()

@export var flippable: Node2D #the node to flip, so it's not just the sprite
#but also every node that is asymmetrical to the sprite
@export var jump_buffer_frames: int #how many physics process a mid-air jump input should be remembered to trigger an immediate jump when ground is reached

var current_active_params: Resource #the currently active list of numbers that will be used for physics and movement
var current_horizontal_speed: float #direction and magnitude of the current horizontal movement
var current_vertical_speed: float #same as above
var fast_falling: bool #whether the current jump has already began fast fall
#fast fall is when the player's upwards acceleration quickly decays as a result of releasing the jump button
var jump_buffer: int #how many frames left of holding a jump input in memory
var just_stomped: bool
var disabled: bool

func _ready() -> void:
	set_default_params()
	disabled = false

func set_default_params(): #quick function to reset the movement params back to the default
	current_active_params = default_params

func _physics_process(_delta: float) -> void:
	if disabled: return
	body.velocity.x = calculate_horizontal_velocity(input_handler.horizontal_input) #self explanatory
	body.velocity.y = calculate_vertical_velocity(input_handler.jump_input)
	update_jump_buffer() #updates the jump_buffer if need be
	body.move_and_slide()
	

	## flip the sprite according to face direction
	if flippable != null:
		if input_handler.horizontal_input > 0:
			flippable.scale.x = 1
		elif input_handler.horizontal_input < 0:
			flippable.scale.x = -1
		
	current_horizontal_speed = body.velocity.x ##update these values so they can be used in the next calculation
	current_vertical_speed = body.velocity.y
	#print(velocity.y)

func update_jump_buffer():
	if body.is_on_floor():
		jump_buffer = 0
	elif input_handler.jump_input == Enums.Button_State.PRESSED:
		jump_buffer = jump_buffer_frames
	elif jump_buffer > 0:
		jump_buffer -= 1

func calculate_horizontal_velocity(input_num: float) -> float: 
	##asking for the input_num rather than taking horizontal_input allows us to intersect it, for example for confusion
	##effects that reverse controls, or that sort of thing
	var target_speed = input_num * current_active_params.max_horizontal_speed
	##this speed will be reached and maintained when the current input is held for long enough
	##not immediately, since acceleration.
	var accel = get_horizontal_accel(input_num) #the acceleration to be applied depends on a number of conditions
	return move_toward(current_horizontal_speed, target_speed, accel)

func get_horizontal_accel(input_num: float) -> float: ##will need to be modified to use the air versions of all these parameters
	if body.is_on_floor():
		if input_num == 0: ## if no movement is being held we use ground drag.
			return current_active_params.ground_drag
		elif signf(input_num) != signf(current_horizontal_speed): ##if the player is pushing the stick against current inertia
			return current_active_params.ground_break_accel
		else: ##otherwise use normal accel
			return current_active_params.ground_accel
	else:
		if input_num == 0.0:
			return current_active_params.air_drag
		else:
			return current_active_params.air_accel
		# no break accel since air movility needs to be lower than ground

func calculate_vertical_velocity(jump_state : Enums.Button_State) -> float:
	if body.is_on_floor():
		if input_handler.down_input == Enums.Button_State.PRESSED:
			body.position.y += 1
		if (jump_state != Enums.Button_State.PRESSED) && (jump_buffer == 0): ##if on the floor, the only input that matters is that a jump BEGAN
			fast_falling = false #reset this bool so the jump uses normal deceleration until told otherwise
			return 0.0
		else:
			if jump_buffer != 0:
				fast_falling = false
			return -current_active_params.jump_force ##negative since that is the 'up' direction in GODOT
	else: ##if we're already airborne then vertical acceleration needs to be taken into account
		var accel = get_vertical_accel(jump_state)
		return move_toward(current_vertical_speed, current_active_params.terminal_velocity, accel)

func get_vertical_accel(jump_state: Enums.Button_State) -> float:
	##uncomment these two lines if you want fast falling to only be applied on upwards velocity
	##if current_vertical_speed >= 0.0:
	##	return current_active_params.gravity
	
	if (!fast_falling) && ((jump_state == Enums.Button_State.RELEASED) || (jump_state == Enums.Button_State.OFF)):
		fast_falling = true ## this is so once fast falling has happened there's no going back (until a new jump happens)
	if fast_falling:
		return current_active_params.fast_gravity
	else:
		return current_active_params.gravity

func kill_momentum(): #if for any reason it becomes necessary to do this
	current_horizontal_speed = 0
	current_vertical_speed = 0
	body.velocity = Vector2.ZERO
