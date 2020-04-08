--item一些属性
local itemNameList = {"凶暴护腕","荣誉头饰","愚者盾","诚实法珠","仁慈护符","灵性项链"}

local itemDescribeList = {"被施以狂乱咒术的护腕","附有骁勇善战之骑士灵魂的魔法头饰",
    "认为物理防御就是一切的愚者用盾","高级神官用，被施以特殊魔法的法珠",
    "传说中由高僧施加防御魔法的护符","经过高级神官加持祝福过的神奇项链"}

local itemPropertyList = {"物理攻击+40%\n物理防御-15%\n魔法防御-15%","魔法攻击+20%\n命中+20%\n闪避+10%",
    "物理防御+40%\n魔法防御-20%","魔法攻击+30%\n命中+20%\n闪避+10%",
    "物理防御+20%\n魔法防御+20%","每一回合恢复HP，MP"}

local itemTypeList = {"护腕","头饰","盾牌","法珠","护符","项链"}
local sprites = {}
local spriteName = {"1","2","3","4","5"}

require("baseclass")
BagManage = BagManage or BaseClass()

function BagManage:__init()
    if BagManage.Instance ==nil then
        BagManage.Instance = self
    else
        error("BagManage.Instance")
    end
    
end
function BagManage:LoadSprite()
    local path = "Assets/AssetBunldes/Images/ItemImg/item.image"
    local ob = GameObject.Find("EventSystem"):GetComponent("GameStart")
    for _, value in pairs(spriteName) do
        table.insert(sprites,ob:GetSprite(path,value))
    end
end

function BagManage:GetSprite(pos)
    return sprites[pos]
end

function BagManage:GetSpriteNum()
    return #sprites
end

function BagManage:GetItemName(pos)
    return itemNameList[pos]
end

function BagManage:GetItemDescribe(pos)
    return itemDescribeList[pos]
end

function BagManage:GetItemProperty(pos)
    return itemPropertyList[pos]
end

function BagManage:GetItemType(pos)
    return itemTypeList[pos]
end

