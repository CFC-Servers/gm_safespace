local wrap = SafeSpace.wrap

-- Chat
wrap( chat, "AddText" )

-- Draw
wrap( draw, "DrawText" )
wrap( draw, "SimpleText" )
wrap( draw, "SimpleTextOutlined" )
wrap( draw, "Text" )
wrap( draw, "TextShadow" )

-- Panel
local panelMeta = FindMetaTable( "Panel" )
wrap( panelMeta, "SetText", 2 )
wrap( panelMeta, "AppendText", 2 )
wrap( panelMeta, "GetTextSize", 2 )
wrap( panelMeta, "GWEN_SetText", 2 )

-- Surface
wrap( surface, "GetTextSize" )
wrap( surface, "DrawText" )
