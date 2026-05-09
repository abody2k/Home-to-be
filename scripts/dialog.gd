extends CanvasLayer

enum DIALOG_TYPE {ONE_TIME,REPEATING}

@export var dialogs = []

@export var dialog_type : DIALOG_TYPE

var current_index=-1

signal finished_dialog

var typing = false

func next():

	if typing or current_index >= dialogs.size():
		return
		

	typing = true
	current_index+=1
	#get the next dialog
	

	if current_index >= dialogs.size():
		if dialog_type == DIALOG_TYPE.REPEATING:
			current_index = -1
		else:
			print("Auto destroyed")
			finished_dialog.emit()
			queue_free()
		return
	var tween = create_tween()
	tween.finished.connect(func(): typing = false)
	tween.tween_property($Control/Panel/label,"text",dialogs[current_index],1)
