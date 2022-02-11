local isstring = isstring
local wrap = SafeSpace.wrap
local filter = SafeSpace.filter

-- Chat
wrap( chat, "AddText", nil, function( args, filter )
    for i = 1, #args do
        local arg = args[i]
        if isstring( arg ) then
            args[i] = filter( arg )
        end
    end

    return args
end )

-- Draw
local function filterTextData( args, filter )
    args[1].text = filter( args[1].text )
    return args
end
wrap( draw, "DrawText" )
wrap( draw, "SimpleText" )
wrap( draw, "SimpleTextOutlined" )
wrap( draw, "Text", nil, filterTextData )
wrap( draw, "TextShadow", nil, filterTextData )

-- Panel
local panelMeta = FindMetaTable( "Panel" )
wrap( panelMeta, "SetText", 2 )
wrap( panelMeta, "AppendText", 2 )
wrap( panelMeta, "GWEN_SetText", 2 )

-- Surface
wrap( surface, "GetTextSize" )
wrap( surface, "DrawText" )

