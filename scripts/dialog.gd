extends CanvasLayer

enum DIALOG_TYPE {ONE_TIME,REPEATING}

@export var dialogs = [
	
	
	["Wake up!",null],
	["Wake up man, we don't have time. The captain needs you",null],
	["He is in the control room and he demands that you be there", null],
	["You: Yes, yes, I will be there",null]
]

@export var dialog_type : DIALOG_TYPE

var current_index=-1

signal finished_dialog
var first_mission = true

var typing = false

func next():
	visible = true
	if typing or current_index >= dialogs.size():
		return
		

	typing = true
	current_index+=1
	#get the next dialog
	

	if current_index >= dialogs.size():
		if dialog_type == DIALOG_TYPE.REPEATING:
			current_index = -1

		else:
			if first_mission:
				first_mission = false
				GlobalData.mission_completed()			
			finished_dialog.emit()
			visible = false
			
		return
	var tween = create_tween()
	tween.finished.connect(func(): typing = false)
	tween.tween_property($Control/Panel/label,"text",dialogs[current_index],1)



func update_dialogs(new_dialogs):
	dialogs = new_dialogs
	current_index = -1
