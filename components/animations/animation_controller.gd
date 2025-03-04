# AnimationController.gd
class_name AnimationController
extends Node

@export var animation_tree: AnimationTree
@export var animation_player: AnimationPlayer

var anim_playback: AnimationNodeStateMachinePlayback

func _ready():
	if animation_tree == null: animation_tree = $AnimationTree
	if animation_player == null: animation_player = $AnimationPlayer
	
	assert(animation_tree != null, "AnimationTree not assigned in AnimationController")
	assert(animation_player != null, "AbunationPlayer not assigned in AnimationController")
	anim_playback = animation_tree.get("parameters/playback")
	assert(animation_tree != null, "AnimationTree has not a AnimationPlayback")

func update_animation(animation: String):
	if animation_player.current_animation != animation:
		anim_playback.travel(animation)
func get_animation_playing():
	return animation_player.is_playing()
	

func update_side(facing_right: bool):
	var animations_direction = 1 if facing_right else -1
	for animation_name in PlayerAnimations.list:

		animation_tree.set_deferred("parameters/%s/BlendSpace1D/blend_position" % animation_name, animations_direction)

func get_animation_timescale(animation: String) -> float :
	return animation_tree.get("parameters/%s/TimeScale/scale" % animation)

func change_animation_timescale(animation: String, timeScale: float):
	animation_tree.set_deferred("parameters/%s/TimeScale/scale" % animation, timeScale)
