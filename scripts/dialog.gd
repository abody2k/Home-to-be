extends CanvasLayer

enum DIALOG_TYPE {ONE_TIME,REPEATING}

@export var dialogs = []

@export var dialog_type : DIALOG_TYPE

var current_index=-1

var  x = {
	"MC":"hello there",
	"ME":""
}

signal finished_dialog

var typing = false

func next():
	
	if typing:
		return
		

	typing = true
	current_index+=1
	#get the next dialog
	
	var tween = create_tween()
	tween.finished.connect(func(): typing = false)
	tween.tween_property($Control/Panel/label,"text",dialogs[current_index],1)
	if dialogs.size() <= current_index:
		if dialog_type == DIALOG_TYPE.REPEATING:
			current_index = -1
		else:
			finished_dialog.emit()
			queue_free()
