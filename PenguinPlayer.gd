extends CharacterBody2D

const SPEED = 300
const SLIDE_SPEED = 500
const JUMP_VELOCITY = -450
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

var gravity : float = 980
var is_sliding = false
var facing = 1

func update_animation(dir: float) -> void:
	if not is_on_floor():
		sprite.play("jump")
	elif dir!=0:
		sprite.play("run")
	else:
		sprite.play("idle")

func start_slide() -> void:
	is_sliding = true
	sprite.play("slide")

func on_animation_finished() -> void:
	if sprite.animation == "slide":
		is_sliding = false

func _ready() -> void:
	sprite.animation_finished.connect(on_animation_finished)

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity.y += gravity*delta
		
	if is_sliding:
		velocity.x = facing*SLIDE_SPEED
	else:
		var dir = Input.get_axis("move_left","move_right")
		
		if dir!=0:
			facing = sign(dir)
		velocity.x = dir*SPEED
			
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			
		if Input.is_action_just_pressed("slide") and is_on_floor():
			start_slide()
			
		if not is_sliding:
			update_animation(dir)
	
	sprite.flip_h = facing<0
	move_and_slide()
