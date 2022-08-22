local rawget = rawget
local rawset = rawset
local isstring = isstring
local wrap = SafeSpace.wrap

local function filterVarArgs( args, filter )
    local argsCount = #args

    for i = 1, argsCount do
        local arg = rawget( args, i )

        if isstring( arg ) then
            rawset( args, i, filter( arg ) )
        end
    end

    return args
end

-- Chat
wrap( chat, "AddText", nil, filterVarArgs )

-- Surface
wrap( surface, "GetTextSize" )
wrap( surface, "DrawText" )

-- Notification
wrap( notification, "AddLegacy" )

-- Debugoverlay
wrap( debugoverlay, "Text", 2 )
wrap( debugoverlay, "ScreenText", 3 )
wrap( debugoverlay, "EntityTextAtPosition", 3 )

-- Builtin
wrap( _G, "print", nil, filterVarArgs )
wrap( _G, "Msg", nil, filterVarArgs )
wrap( _G, "MsgAll", nil, filterVarArgs )
wrap( _G, "MsgC", nil, filterVarArgs )
wrap( _G, "MsgN", nil, filterVarArgs )
