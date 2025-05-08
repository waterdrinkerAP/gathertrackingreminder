-- GatherTrackingReminder - Modified by waterdrinkerAP
-- Based on version 2.0.6 by hyxgwyx (qeldroma)
-- License: BSD 3-Clause
-- Changes: Center screen alert, sound warning, better visibility

GTR = { }
GTR.spellname = ""
Helper = { }
function Helper.isempty(s)
  return s == nil or s == ''
end

-- Create a frame for central alert
local alertFrame = CreateFrame("Frame", "GTR_AlertFrame", UIParent)
alertFrame:SetSize(400, 100)
alertFrame:SetPoint("CENTER", 0, 100)
alertFrame.text = alertFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHuge")
alertFrame.text:SetAllPoints()
alertFrame.text:SetTextColor(1.0, 0.8, 0.1)
alertFrame:Hide()

function GTR.ShowCenterMessage(msg)
	alertFrame.text:SetText(msg)
	alertFrame:Show()

	-- Fade out after 2 seconds
	C_Timer.After(2, function()
		alertFrame:Hide()
	end)
end

function GTR.HasTracking()
	if (IsPlayerSpell("2383")) then
		local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo("2383")
		GTR.spellname = name
		return true
	end
	if (IsPlayerSpell("2580")) then
		local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo("2580")
		GTR.spellname = name
		return true
	end
	if (IsPlayerSpell("2481")) then
		local name, rank, icon, castTime, minRange, maxRange, spellId = GetSpellInfo("2481")
		GTR.spellname = name
		return true
	end
	return false
end

function GTR.AlertIfNoTracking()
	if(GTR.HasTracking() and not UnitIsDeadOrGhost("player") and Helper.isempty(GetTrackingTexture())) then
		local message = GTR.spellname .. " is not active!"
		GTR.ShowCenterMessage(message)
		PlaySound(5274, "Master") -- plays AuctionWindowOpen sound
	end
end

function GTR.Run()
		local timer = C_Timer.NewTicker(5, GTR.AlertIfNoTracking)
end
GTR.Run()
