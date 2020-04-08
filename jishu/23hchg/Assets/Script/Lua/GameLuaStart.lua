import "UnityEngine"
import "UnityEngine.UI"

if not UnityEngine.GameObject or not  UnityEngine.UI then
	error("Click Make/All to generate lua wrap file")
end

require("baseclass")

local GameLuaStart =  GameLuaStart or BaseClass()

function GameLuaStart:Start()
    self:AllDictionary()
end

function GameLuaStart:AllDictionary()
    --这里作为写游戏逻辑的lua文件的入口
    --BagClass.New()
    print("Lua接口加载成功")
end
function main()
end

function Start()
    GameLuaStart:Start()
end

