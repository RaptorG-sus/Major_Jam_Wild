extends Control


@onready var object_panel :Panel = $ObjectPanel
@onready var crafting_panel :Panel = $CraftingPanel
@onready var vboxcontainer :VBoxContainer = $VBoxContainer


var is_open :bool = false


func _ready() -> void:
	object_panel.visible = false
	crafting_panel.visible = false
	$VBoxContainer.visible = false
	
	for page in $CraftingPanel/Craft.get_children():
		for inv_ui_slot in page.get_children():
			inv_ui_slot.pressed.connect(craft_process)


func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			print("open")
			_open()


func _open() -> void:
	is_open = true
	object_panel.visible = true
	crafting_panel.visible = false
	$VBoxContainer.visible = true

	get_tree().paused = true
	
	
func close() -> void:
	is_open = false
	object_panel.visible = false
	crafting_panel.visible = false
	$VBoxContainer.visible = false

	get_tree().paused = false


func _on_object_panel_button_pressed() -> void:
	if !object_panel.visible:
		object_panel.visible = true
		crafting_panel.visible = false
		$VBoxContainer/ObjectPanelButton.mouse_filter = Control.MOUSE_FILTER_IGNORE
		$VBoxContainer/CraftingPanelButton.mouse_filter = Control.MOUSE_FILTER_STOP


func _on_crafting_panel_button_pressed() -> void:
	if !crafting_panel.visible:
		object_panel.visible = false
		crafting_panel.visible = true
		$VBoxContainer/ObjectPanelButton.mouse_filter = Control.MOUSE_FILTER_STOP
		$VBoxContainer/CraftingPanelButton.mouse_filter = Control.MOUSE_FILTER_IGNORE


func craft_process(panel :Panel) -> void:
	pass
