if not skittles then skittles = {} end

--mouseover healing Immerseus - Contaminated Puddle
function skittles.mouseover()
 if UnitExists("mouseover")				
	and not UnitIsPlayer("mouseover") then
		local npcid = tonumber(UnitGUID("mouseover"):sub(6,10), 16) 				
		if npcid == 71604
		 then return true 
        end
 end
end  


-- Register library
ProbablyEngine.library.register("skittles", skittles)