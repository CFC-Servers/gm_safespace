local populatePanel = function( panel )
    panel:Help( "Text Profanity Filtering uses your Steam Profanity settings and attempts to filter all in-game text content" )
    panel:Help( "This Check Box will enable/disable Profanity Filtering regardless of what Steam Settings you have selected" )
    panel:CheckBox( "Enable Text Profanity Filtering", "safespace_enabled" )
end

hook.Add( "AddToolMenuCategories", "SafeSpace_SettingsManager", function()
    spawnmenu.AddToolCategory( "Options", "CFC", "#CFC" )
end )

hook.Add( "PopulateToolMenu", "SafeSpace_SettingsManager", function()
    spawnmenu.AddToolMenuOption( "Options", "CFC", "safespace_is_enabled", "#Profanity Filtering", "", "", populatePanel )
end )
