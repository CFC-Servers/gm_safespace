SafeSpace = {}

local filter = function( text )
    return util.FilterText( text, TEXT_FILTER_UNKNOWN )
end

SafeSpace.wrap = function( lib, key, textIndex, argHandler )
    textIndex = textIndex or 1

    local og = "_SafeSpaceStub_" .. key
    lib[og] = lib[og] or lib[key]

    lib[key] = wrapper or function( ... )
        local args = { ... }

        -- TODO: Make the third param either an
        -- index (for default functionality) or a function (for custom filtering)
        if argHandler then
            args = argHandler( args, filter )
        else
            args[textIndex] = filter( args[textIndex] )
        end

        return lib[og]( unpack( args ) )
    end
end
