function GM:GetSchemaInformation( )
	return {
		title = Schema.IntroTitle,
		desc = Schema.IntroDesc,
		author = "Design and development by " .. Schema.Author .. "."
	}
end

function GM:PostRenderScreenColor( pl, data )
	local data = { }
	data.colour = 0.6
	return data
end