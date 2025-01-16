local waterwell = table.deepcopy(data.raw["offshore-pump"]["offshore-pump"])
waterwell.name = "stone-waterwell"
waterwell.icon = "__StoneWaterWell-ActuallyUpdated__/graphics/stone-waterwell.icon.png"
waterwell.icon_size = 32
waterwell.icon_mipmaps = 1


waterwell.water_reflection = nil
waterwell.animation = nil
waterwell.placeable_position_visualization = nil
waterwell.tile_buildability_rules = nil
waterwell.graphics_set = {
	base_pictures = {
	sheets = {
{
	filename = "__StoneWaterWell-ActuallyUpdated__/graphics/stone-waterwell.png",
	priority = "extra-high",
	shift = {0.3, 0.8},
	width = 256,
	height = 256,
}
	}
}
}
waterwell.fluid_box.filter = "water"
waterwell.pumping_speed = 20
waterwell.minable = {mining_time = 1, result = "stone-waterwell"}
waterwell.flags = {"placeable-neutral", "player-creation"}

waterwell.adjacent_tile_collision_test = {"ground-tile"}
waterwell.adjacent_tile_collision_mask = nil
waterwell.collision_box = {{-2.2, -2.2}, {2.2, 2.2}}
waterwell.selection_box = {{-2.5, -2.5}, {2.5, 2.5}, }
waterwell.collision_mask = {
    layers = {item = true, object = true, player = true, water_tile = true}
}
waterwell.adjacent_tile_collision_test = { "ground-tile" }
waterwell.adjacent_tile_collision_mask = nil

waterwell.fluid_box.pipe_connections[1].position = {0, 2.2}

waterwell.circuit_wire_connection_points = circuit_connector_definitions["storage-tank"].points
waterwell.circuit_connector_sprites = circuit_connector_definitions["storage-tank"].sprites

local waterwellRecipe = {
	type = "recipe",
	name = "stone-waterwell",
	energy_required = 10,
	ingredients = {
		{type = "item", name = "iron-stick", amount = 4},
		{type = "item", name = "stone-brick", amount = 8},
		{type = "item", name = "stone", amount = 40},
		{type = "item", name = "offshore-pump", amount = 1}
	},
	results = {{type="item", name="stone-waterwell", amount=1}},
	enabled=false -- we don't want this recipe enabled at the start of the game
}

local pressureReq = {
	{
		property = "pressure",
		min = 1000,
		max = 2000
	}
}

if mods["space-age"] then
	waterwell.surface_conditions = pressureReq
	table.insert(waterwellRecipe, pressureReq)
end

data:extend(
{
	waterwell,
	waterwellRecipe,
	{
		type = "item",
		name = "stone-waterwell",
		icon = "__StoneWaterWell-ActuallyUpdated__/graphics/stone-waterwell.icon.png",
		icon_size = 32,
		subgroup = "extraction-machine",
		order = "b[fluids]-a[stone-waterwell]",
		place_result = "stone-waterwell",
		stack_size = 5
	},
	{
		type = "technology",
		name = "deep-water-well",
		icon_size = 256,
		icon = "__StoneWaterWell-ActuallyUpdated__/graphics/stone-waterwell.icon.png",
		prerequisites = {"logistic-science-pack"},
		effects =
		{
			{
				type = "unlock-recipe",
				recipe = "stone-waterwell"
			}
		},
		unit =
		{
			count = 100,
			ingredients = {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
			time = 20
		},
		order = "c-a"
	}
})
