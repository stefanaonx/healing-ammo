require "util"
local table_deepcopy = util.table.deepcopy

healing_value = settings.startup["healing-value"].value

-- healing ammo item
new_ammo_type = {
    category = "bullet",
    action =
    {
        type = "direct",
        action_delivery =
        {
            type = "instant",
            source_effects =
            {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
            },
            target_effects =
            {
                {
                    type = "create-entity",
                    entity_name = "explosion-hit"
                },
                {
                    type = "damage",
                    damage = { amount = -1 * healing_value, type = "physical"}
                }
            }
        }
    }
}

local healing_ammo = table_deepcopy(data.raw["ammo"]["firearm-magazine"])
healing_ammo.name = "healing-ammo"
healing_ammo.ammo_type = new_ammo_type
healing_ammo.icon = "__healing-ammo__/graphics/healing-rounds-magazine.png"

-- the recipe
local healing_ammo_recipe = table_deepcopy(data.raw["recipe"]["firearm-magazine"])
healing_ammo_recipe.name = "healing-ammo"
healing_ammo_recipe.ingredients = {
    {"raw-fish", 5},
    {"firearm-magazine", 200}
}
healing_ammo_recipe.results = {
    {"healing-ammo", 200}
}
healing_ammo_recipe.result = "healing-ammo"


data:extend{
    healing_ammo,
    healing_ammo_recipe
}