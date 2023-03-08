local MarketplaceService = game:GetService("MarketplaceService")


local Utilities = {}


-- Recursively clones a table
function Utilities:CloneTable(original_table)
	local table_copy = {}

	for k, v in pairs(original_table) do
		if type(v) == "table" then
			v = self:CloneTable(v)
		end
		table_copy[k] = v
	end

	return table_copy
end

-- Converts a money string to a plain number with two decimal points
function Utilities:ConvertMoneyToNumber(n)
	n = n:gsub("%$", ""):gsub(",", "")
	n = tonumber(n)
	return n
end

-- Converts a number to a money string with two decimal points
function Utilities:ConvertNumberToMoney(s)
	s = string.format("%.2f", s)
	s = tostring(s)
	s = s:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
	return "$" .. s
end

-- Checks if player has a gamepass
function Utilities:HasGamepass(player, gamepassID)
	local hasPass
	local success, message = pcall(function()
		hasPass = MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassID)
	end)

	if success then
		return hasPass
	else
		print(message)
		return false
	end
end


return Utilities
