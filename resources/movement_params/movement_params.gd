class_name movement_params extends Resource
##the idea of making this a resource is to allow for easy hotswapping during gameplay
##say, for example, if we want the player to become heavier as a result of some mechanic

@export var max_horizontal_speed: float ##maximum achievable horizontal speed through inputs
@export var ground_accel: float ##acceleration factor applied to input while on the ground
@export var air_accel: float ##same as above, but mid air
@export var ground_drag: float ##deceleration of speed while no input is being received on the ground
@export var air_drag: float ##as above, but mid air
@export var ground_break_accel: float ##acceleration factor to be applied when input is opposite in direction to inertia
@export var gravity: float
@export var jump_force: float
@export var fast_gravity: float #applied if the jump button is let go of before upward movement has stupped.
@export var terminal_velocity: float #limit of how fast it can fall
@export var impulse_velocity: float
@export var impulse_time: float
@export var bounce_force: float
@export var bounce_elevation: float

func _init(
	p_max_horizontal_speed = 0.0, 
	p_ground_accel = 0.0, 
	p_air_accel = 0.0, 
	p_ground_drag = 0.0, 
	p_air_drag = 0.0, 
	p_ground_break_accel = 0.0, 
	p_gravity = 0.0, 
	p_jump_force = 0.0, 
	p_fast_gravity = 0.0, 
	p_terminal_velocity = 0.0,
	p_impulse_velocity = 0.0,
	p_impulse_time = 0.0,
	p_bounce_force = 0.0,
	p_bounce_elevation = 0.0
):
	max_horizontal_speed = p_max_horizontal_speed
	ground_accel = p_ground_accel
	air_accel = p_air_accel
	ground_drag = p_ground_drag
	air_drag = p_air_drag
	ground_break_accel = p_ground_break_accel
	gravity = p_gravity
	jump_force = p_jump_force
	fast_gravity = p_fast_gravity
	terminal_velocity = p_terminal_velocity
	impulse_velocity = p_impulse_velocity
	impulse_time = p_impulse_time
	bounce_force = p_bounce_force
	bounce_elevation = p_bounce_elevation
