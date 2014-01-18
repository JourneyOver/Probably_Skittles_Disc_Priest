if not skittles then skittles = {} end

local lastRapture
local skittles = {}

--mouseover healing Immerseus - Contaminated Puddle
function skittles.mouseover()
 if UnitExists("mouseover") and not UnitIsPlayer("mouseover") then
   local npcid = tonumber(UnitGUID("mouseover"):sub(6,10), 16)        
   if npcid == 71604 then 
   return true 
   end
  end
end

function skittles.checkRapture()
  if not lastRapture then
    lastRapture = time()
    return true
  end
  if time() - lastRapture > 12 then return true end
  return false
end

function skittles.bossCheck()
  if UnitExists("boss1") then
    local npcId = tonumber(UnitGUID("boss1"):sub(6,10), 16)
    if npcId == 71454 then
      return true 
  end
  end
end 

function skittles.stopCast(unit)
  if UnitBuff("player", 31821) then return false end -- Devo
  if not unit then unit = "boss1" end
  local spell, _, _, _, _, endTime = UnitCastingInfo(unit)
  local stop = false
  if spell == GetSpellInfo(138763) then stop = true end -- Dark Animus
  if spell == GetSpellInfo(137457) then stop = true end -- Oondasta
  if spell == GetSpellInfo(143343) then stop = true end -- Thok
  if stop then
    if UnitCastingInfo("player") or UnitChannelInfo("player") then
	 local CastFinish = endTime / 1000 - GetTime()
     if CastFinish <= .25 then
       return true
     end
	end
  end
  return false
end

local function findRapture(timeStamp, event, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, ...)
  if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_ME) and event == 'SPELL_ENERGIZE' then
    local name = select(2, ...)
    if name == 'Rapture' then lastRapture = timestamp end
  end
end
ProbablyEngine.listener.register('COMBAT_LOG_EVENT_UNFILTERED', findRapture)

-- Register library
ProbablyEngine.library.register("skittles", skittles)