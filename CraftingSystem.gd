extends Node
class_name CraftingStation

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func can_craft(item: Dictionary, inventory: Dictionary, amount: int = 1) -> bool:
	#returns true if a certain item can be crafted based on inventory content
	var can_craft = true
	if amount < 1 or item.recipe.empty() or not inventory.has_all(item.recipe.keys()):
		can_craft = false
	else:
		var adjusted_item: = adjust_item_recipe(item, amount)
		for ingredient in item.recipe:
			if adjusted_item.recipe[ingredient] > inventory[ingredient]:
				can_craft = false
				break
	return can_craft

func adjust_item_recipe(item: Dictionary, amount: int) -> Dictionary:
	#returns new item with adjusted recipe based on amount of items to craft
	var adjusted_item := item.duplicate(true)
	if amount > 1:
		for ingredient in adjusted_item.recipe:
			adjusted_item.recipe[ingredient] *= amount
	return adjusted_item

func craft(item: Dictionary, inventory: Dictionary, amount: int = 1) -> Dictionary:
	#crafts the amount of items and consumed the required material from inven...returns new items in an updated inventory
	if amount < 0 or not can_craft(item, inventory, amount):
		return { }
	var crafted_items : = []
	for i in amount:
		crafted_items.append(load(item.scene).instance())
	var items_and_inventory = {
		"items": crafted_items,
		"inventory": use(item, inventory, amount)
	}
	return items_and_inventory
	
func use(item: Dictionary, inventory: Dictionary, amount: int = 1) -> Dictionary:
	#creates and return new inven with used up resources
	var used_inventory = inventory.duplicate()
	var adjusted_recipe = adjust_item_recipe(item, amount).recipe
	if not inventory.has_all(adjusted_recipe.keys()):
		return used_inventory
	for ingredient in adjusted_recipe.keys():
		used_inventory[ingredient] -= adjusted_recipe[ingredient]
		if used_inventory[ingredient] == 0:
			used_inventory.erase(ingredient)
	return used_inventory
