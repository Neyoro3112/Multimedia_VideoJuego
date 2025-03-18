# AnimationController.gd
class_name AnimationController
extends Node

## Es el nodo de tipo AnimationTree que es controlado por la clase
@export var tree: AnimationTree


## Es el AnimationPlayback usado por el AnimationTree
var playback: AnimationNodeStateMachinePlayback
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var current_animation: String : get = get_current_animation

func get_current_animation():
	return str(playback.get_current_node())


func _ready():
	if tree == null: tree = $AnimationTree
	
	assert(tree != null, "AnimationTree not assigned in AnimationController")
	playback = tree.get("parameters/playback")
	assert(playback != null, "AnimationTree has not a AnimationPlayback")
	tree.active = true

func update_animation(animation_name: String, start: bool = false):
	if current_animation != animation_name:
		playback.travel(animation_name)
	elif start:
		playback.start(animation_name)


func randomize_animation(animation_name: String, number_choices: int):
	var animation_randomizer = "parameters/%s/randomizer/blend_position" % animation_name
	if  tree.get(animation_randomizer) != null:
		var rand_val = randi() % number_choices
		tree.set_deferred(animation_randomizer, rand_val)

func update_side(facing_right: bool):
	var animations_direction = 1 if facing_right else -1
	for animation_name in PlayerAnimations.list:

		tree.set_deferred("parameters/%s/BlendSpace1D/blend_position" % animation_name, animations_direction)

func get_animation_timescale(animation: String) -> float :
	return tree.get("parameters/%s/TimeScale/scale" % animation)

func change_animation_timescale(animation: String, timeScale: float):
	tree.set_deferred("parameters/%s/TimeScale/scale" % animation, timeScale)
