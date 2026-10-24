extends Control
class_name PopUp

@export var resource: Resource

var nome: String

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	pass	
	
func set_text(newRes: Resource):
	if not newRes:
		return
	resource = newRes
	$Panel/RichTextLabel.clear()
	$Panel/RichTextLabel.append_text(resource.name + "\n")
		
