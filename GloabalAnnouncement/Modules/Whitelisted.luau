local Whitelist = {}

Whitelist.UserIds = {
	8000822432,
}

function Whitelist:IsWhitelisted(userId)
    for i, id in Whitelist.UserIds do
        if id == userId then
            return true
        end
    end
    return false
end

return Whitelist

