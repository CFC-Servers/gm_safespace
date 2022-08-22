SafeSpace = {}

local filter = function( text )
    return util.FilterText( text, TEXT_FILTER_UNKNOWN )
end

local isEnabled = CreateClientConVar( "safespace_enabled", 1, true, false, "Enable/Disable SafeSpace", 0, 1 ):GetBool()
cvars.AddChangeCallback( "safespace_enabled", function( _, _, new )
    isEnabled = tobool( new )
end, "UpdateLocalValue" )

SafeSpace.wrap = function( lib, key, textIndex, argHandler )
    textIndex = textIndex or 1

    local ogName = "_SafeSpaceStub_" .. key
    lib[ogName] = lib[ogName] or lib[key]
    local og = lib[ogName]

    lib[key] = wrapper or function( ... )
        if not isEnabled then return og( ... ) end

        local args = { ... }

        -- TODO: Make the third param either an
        -- index (for default functionality) or a function (for custom filtering)
        if argHandler then
            args = argHandler( args, filter )
        else
            args[textIndex] = filter( args[textIndex] )
        end

        return og( unpack( args ) )
    end
end
