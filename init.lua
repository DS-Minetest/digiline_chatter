--[[
    .___.__       .__.__  .__                         .__            __    __
  __| _/|__| ____ |__|  | |__| ____   ____       ____ |  |__ _____ _/  |__/  |_  ___________
 / __ | |  |/ ___\|  |  | |  |/    \_/ __ \    _/ ___\|  |  \\__  \\   __\   __\/ __ \_  __ \
/ /_/ | |  / /_/  >  |  |_|  |   |  \  ___/    \  \___|   Y  \/ __ \|  |  |  | \  ___/|  | \/
\____ | |__\___  /|__|____/__|___|  /\___  >____\___  >___|  (____  /__|  |__|  \___  >__|
     \/   /_____/                 \/     \/_____/   \/     \/     \/                \/
--]]

minetest.register_node("digiline_chatter:sayer", {
	description = "digiline sayer",
	tiles = {"mesecons_noteblock.png", "default_wood.png"},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
	},
	groups = {dig_immediate = 2},
	digiline = {
		receptor = {},
		effector = {
			action = function(pos, node, channel, msg)
				local meta = minetest.get_meta(pos)
				local setchannel = meta:get_string("channel")
				if channel ~= setchannel then return end
				minetest.chat_send_all(msg)
			end
		},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")
	end,
	on_receive_fields = function(pos, formname, fields, player)
		local name = player:get_player_name()
		if minetest.is_protected(pos, name) and not
				minetest.check_player_privs(name, {protection_bypass=true}) then
			minetest.record_protection_violation(pos, name)
			return
		end
		if fields.channel then
			minetest.get_meta(pos):set_string("channel", fields.channel)
		end
	end,
})

--~ if minetest.get_modpath("digiline_remote") then
	--~ minetest.register_craftitem("digiline_chatter:phone",{
		--~ description = "Phone",
		--~ inventory_image = "digiline_remote_rc.png",
		--~ stack_max = 1,
	--~ })
--~ end
