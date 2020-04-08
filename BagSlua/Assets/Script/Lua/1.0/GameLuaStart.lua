import "UnityEngine"
import "UnityEngine.UI"

if not UnityEngine.GameObject or not  UnityEngine.UI then
	error("Click Make/All to generate lua wrap file")
end

require("baseclass")
require("Bag")

local GameLuaStart =  GameLuaStart or BaseClass()

function GameLuaStart:Start()
    self:AllDictionary()
end

function GameLuaStart:AllDictionary()
    --BagClass.New()
    Bag.New()
end
function main()
end

function Start()
    GameLuaStart:Start()
end

