local world_sounds = include("gameplay/world_sounds")
local simquery = include("sim/simquery")


local old_checkOcclusion = world_sounds.checkOcclusion

world_sounds.checkOcclusion = function(self, boardRig, x0, y0, maxRange )
	local occlusion = old_checkOcclusion(self, boardRig, x0, y0, maxRange )
	local sim = boardRig:getSim()
    if simquery.luna4s_isTileSilenced(sim, x0, y0) then
        occlusion = 1
    end

    return occlusion
end
