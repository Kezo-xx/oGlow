local update = function(self)
	-- We shouldn't really do this. The correct solution would be to delay the
	-- event registration until Blizzard_GuildBankUI is loaded, but we use this
	-- solution for now.
	if(not IsAddOnLoaded"Blizzard_GuildBankUI") then return end

	local tab = GetCurrentGuildBankTab()
	for i=1, 98 do
		local index = math.fmod(i, 14)
		if(index == 0) then
			index = 14
		end
		local column = math.ceil((i-0.5)/14)

		local slotLink = GetGuildBankItemLink(tab, i)
		local slotFrame = _G["GuildBankColumn"..column.."Button"..index]

		self:CallFilters('gbank', slotFrame, slotLink)
	end
end

local enable = function(self)
	self:RegisterEvent('GUILDBANKBAGSLOTS_CHANGED', update)
	self:RegisterEvent('GUILDBANKFRAME_OPENED', update)
end

local disable = function(self)
	self:UnregisterEvent('GUILDBANKBAGSLOTS_CHANGED', update)
	self:UnregisterEvent('GUILDBANKFRAME_OPENED', update)
end

oGlow:RegisterPipe('gbank', enable, disable, update, 'Blizzard Guild Bank Frame', nil)
