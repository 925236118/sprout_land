extends Node2D

## 基础状态
class_name StateBase

var state_machine: StateMachine

## 进入状态
func enter() -> void:
	#print(name, " is enter")
	pass

## 退出状态
func exit() -> void:
	#print(name, " is exit")
	pass

## 渲染帧触发
func process_update(_delta: float) -> void:
	pass

## 物理帧触发
func physical_process_update(_delta: float) -> void:
	pass
