if SERVER then
    AddCSLuaFile( "safespace/utils.lua" )
    AddCSLuaFile( "safespace/wraps.lua" )
end

if CLIENT then
    include( "safespace/utils.lua" )
    include( "safespace/wraps.lua" )
end
