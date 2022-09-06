local rawget = rawget
local rawset = rawset
local unpack = unpack
local TEXT_FILTER_UNKNOWN = TEXT_FILTER_UNKNOWN
local FilterText = util.FilterText

-- TODO: This needs to be smartly cleaned regularly so it doesn't get really, really big
SafeSpace = { Cache = {} }
local cache = SafeSpace.Cache

local _filter = function( text )
    return FilterText( text, TEXT_FILTER_UNKNOWN )
end

local function filter( text )
    if not text then return end

    local cached = rawget( cache, text )
    if cached then
        return cached == true and text or cached
    end

    -- We just save "true" if the
    -- text remained unchanged to save tons of memory
    local result = _filter( text )
    local toSave = result == text and true or result
    rawset( cache, text, toSave )

    return result
end

local isEnabled = CreateClientConVar( "gm_safespace_enabled", 0, true, false, "Enable/Disable SafeSpace", 0, 1 ):GetBool()
cvars.AddChangeCallback( "gm_safespace_enabled", function( _, _, new )
    isEnabled = tobool( new )
    SafeSpace.Cache = {}
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
            -- args[textIndex] = filter( args[textIndex] )
            rawset( args, textIndex, filter( rawget( args, textIndex ) ) )
        end

        return og( unpack( args ) )
    end
end

hook.Add( "Think", "SafeSpace_CacheFilterText", function()
    hook.Remove( "Think", "SafeSpace_CacheFilterText" )
    FilterText = util.FilterText
end )
