if SERVER then
    AddCSLuaFile( "safespace/utils.lua" )
    AddCSLuaFile( "safespace/wraps.lua" )
    AddCSLuaFile( "safespace/options.lua" )
end

if CLIENT then
    include( "safespace/utils.lua" )
    include( "safespace/wraps.lua" )
    include( "safespace/options.lua" )
end
