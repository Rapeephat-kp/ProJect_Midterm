extends Node2D

const SlotClass = preload("res://Scene/Slot.gd")
@onready var inventory_slots = $GridContainer
var holding_item = null

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(Callable(self, "slot_gui_input").bind(inv_slot))
	refresh_inventory()

# เริ่มต้น UI Inventory
func refresh_inventory():
	var slots = inventory_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
		else:
			if slots[i].item:
				slots[i].item.queue_free()
				slots[i].item = null

# ฟังก์ชันซื้อไอเท็ม
func buy_item(item_name: String, quantity: int = 1) -> void:
	PlayerInventory.add_item(item_name, quantity)
	refresh_inventory()

# ฟังก์ชันลากวาง / ใช้ไอเท็ม
func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton and event.pressed:
		
		# คลิกซ้าย → ใช้ไอเท็ม
		if event.button_index == MOUSE_BUTTON_LEFT:
			if slot.item:
				if slot.item.item_name != "Logs":
					use_item(slot.item)
					PlayerInventory.remove_item(slot.item.item_name, 1)
					slot.item.decrease_item_quantity(1)
					if slot.item.item_quantity <= 0:
						PlayerInventory.remove_item(slot.item.item_name, 0) # ลบ slot เลย
						slot.clear_slot()
		
		# คลิกขวา → ย้าย / Drag & Drop
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if holding_item != null:
				if not slot.item:
					slot.putIntoSlot(holding_item)
					holding_item = null
				else:
					if holding_item.item_name != slot.item.item_name:
						var temp_item = slot.item
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(holding_item)
						holding_item = temp_item
					else:
						var stack_size = int(JsonData.item_data[slot.item.item_name]["StackSize"])
						var able_to_add = stack_size - slot.item.item_quantity
						if able_to_add >= holding_item.item_quantity:
							slot.item.add_item_quantity(holding_item.item_quantity)
							holding_item.queue_free()
							holding_item = null
						else:
							slot.item.add_item_quantity(able_to_add)
							holding_item.decrease_item_quantity(able_to_add)
			elif slot.item:
				holding_item = slot.item
				slot.pickFromSlot()
				holding_item.global_position = get_global_mouse_position()

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func use_item(item):
	match item.item_name:
		"Healing Potion":
			Gamemanager.set_player_health(50)
			print("Drink")
		"Increase Max Hp Potion":
			Gamemanager.set_max_hp(50)
			Gamemanager.set_player_health(10)
		"Atk Potion":
			Gamemanager.set_atk(15)
		"Antidote Potion":
			Gamemanager.set_player_buff(5.0)
		_:
			print("ไอเท็มไม่รู้จัก:", item.item_name)
