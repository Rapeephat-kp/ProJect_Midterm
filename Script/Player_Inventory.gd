extends Node

const NUM_INVENTORY_SLOTS = 7
var inventory = {}

func add_item(item_name: String, item_quantity: int):
	for i in inventory.keys():
		if inventory[i][0] == item_name:
			inventory[i][1] += item_quantity
			return
	
	for i in range(NUM_INVENTORY_SLOTS):
		if not inventory.has(i):
			inventory[i] = [item_name, item_quantity]
			return

func remove_item(item_name: String, item_quantity: int):
	for i in inventory.keys():
		if inventory[i][0] == item_name:
			inventory[i][1] -= item_quantity
			if inventory[i][1] <= 0:
				inventory.erase(i)
			return

func get_item_quantity(item_name: String) -> int:
	for i in inventory.keys():
		if inventory[i][0] == item_name:
			return inventory[i][1]
	return 0
