SafeSpace = {}

local filter = function( text )
    return util.FilterText( text, TEXT_FILTER_UNKNOWN, LocalPlayer() )
end

SafeSpace.wrap = function( lib, key, textIndex )
    textIndex = textIndex or 1

    local og = "_SafeSpaceStub_" .. key
    lib[og] = lib[og] or lib[key]

    lib[key] = function( ... )
        local args = { ... }
        args[textIndex] = filter( args[textIndex] )

        return lib[og]( unpack( args ) )
    end
end
