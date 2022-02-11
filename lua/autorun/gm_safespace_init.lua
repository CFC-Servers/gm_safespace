if SERVER then
    AddCSLuaFile( "safespace/utils.lua" )
    AddCSLuaFile( "safespace/wraps.lua" )
end

if CLIENT then
    hook.Add( "Think", "SafeSpace_Init", function()
        hook.Remove( "Think", "SafeSpace_Init" )
        include( "safespace/utils.lua" )
        include( "safespace/wraps.lua" )
    end )
end
