------------暂时没使用
--物品类
--用来管理物品的属性和方法
--属性
-- 方法：
-- 1 高亮显示物品
-- 2 通过id查找物品对象
require("baseclass")
BagItem = BagItem or BaseClass()

--item一些属性
local itemNames = {"凶暴护腕","荣誉头饰","愚者盾","诚实法珠","仁慈护符","灵性项链"}

local itemDescribe = {"被施以狂乱咒术的护腕","附有骁勇善战之骑士灵魂的魔法头饰",
    "认为物理防御就是一切的愚者用盾","高级神官用，被施以特殊魔法的法珠",
    "传说中由高僧施加防御魔法的护符","经过高级神官加持祝福过的神奇项链"}

local itemProperty = {"物理攻击+40%\n物理防御-15%\n魔法防御-15%","魔法攻击+20%\n命中+20%\n闪避+10%",
    "物理防御+40%\n魔法防御-20%","魔法攻击+30%\n命中+20%\n闪避+10%",
    "物理防御+20%\n魔法防御+20%","每一回合恢复HP，MP"}

local itemType = {"护腕","头饰","盾牌","法珠","护符","项链"}

function BagItem:__init()
    self.sprites = {}
	self.spriteName = {"1","2","3","4","5"}
    self.itemTables = {}
    self.currentPos = 1
    self.describeList = {}
    self:LoadSprite()
end

function BagItem:OnClickHightLight(itemTable)
    self.itemTables[self.currentPos].HLImageTransform.gameObject:SetActive(false)
	itemTable.HLImageTransform.gameObject:SetActive(true)
	self.currentPos = itemTable.pos
	self:DescribeItem(self.currentPos)
end

function BagItem:LoadSprite()
    local path = "Assets/AssetBunldes/Images/ItemImg/item.image"
    local ob = GameObject.Find("EventSystem"):GetComponent("GameStart")
    for _, value in pairs(self.spriteName) do
        table.insert(self.sprites,ob:GetSprite(path,value))
    end
end

function BagItem:CreateItem(xy,id,targetObject,isNew)
    local itemTable = {}
    local num = math.random(1,100)
	local spriteIndex=math.random(1,table.getn(self.sprites))
    local itemIndex=math.random(1,table.getn(self.spriteName))
    --物体属性列表
    itemTable.pos = id
	itemTable.name = itemNames[itemIndex]
	itemTable.spriteIndex = spriteIndex
	itemTable.text = tostring(num)
	itemTable.xy = xy
	itemTable.type = itemType[itemIndex]
	itemTable.property = itemProperty[itemIndex]
    itemTable.describe = itemDescribe[itemIndex]
    if isNew then
        itemTable.ob = GameObject.Instantiate(targetObject)  
        itemTable.ob.transform:SetParent(targetObject.transform.parent)
        local onClickHL=itemTable.ob:GetComponent("Button")
        onClickHL.onClick:AddListener( function () self:OnClickHightLight(itemTable) end)
        itemTable.ImageTransform = itemTable.ob.transform:Find("itemImage")
        itemTable.TextTransform = itemTable.ob.transform:Find("itemText")
        itemTable.HLImageTransform = itemTable.ob.transform:Find("HLImage")
    else
        itemTable.ob = self.itemTables[id].ob
        itemTable.ImageTransform = self.itemTables[id].ImageTransform
        itemTable.TextTransform = self.itemTables[id].TextTransform
        itemTable.HLImageTransform = self.itemTables[id].HLImageTransform
    end

    --物体属性设置
    itemTable.ob.gameObject:SetActive(true)
	itemTable.ImageTransform:GetComponent(Image).sprite = self.sprites[itemTable.spriteIndex]
    itemTable.TextTransform:GetComponent(Text).text = itemTable.text
    self.itemTables[itemTable.pos] = itemTable
end

function BagItem:SetDescribeList(describeList)
    self.describeList = describeList
end

function BagItem:DescribeItem(pos)
	self.describeList[1]:GetComponent(Image).sprite = self.sprites[self.itemTables[pos].spriteIndex]
	self.describeList[2]:GetComponent(Text).text = self.itemTables[pos].text
    self.describeList[3]:GetComponent(Text).text = 
        string.format("\t\t\t<color=#ff0000>%s</color>\n类别：<color=#ff0000>%s</color>\n介绍：<color=#ff0000>%s</color>\n属性：<color=#ff0000>%s</color>\n",
		self.itemTables[pos].name,self.itemTables[pos].type,self.itemTables[pos].describe,self.itemTables[pos].property)
	self.describeList[1]:SetActive(true)
	self.describeList[2]:SetActive(true)
	self.describeList[3]:SetActive(true)
end

function BagItem:NoDescribeItem()
	self.describeList[1]:SetActive(false)
	self.describeList[2]:SetActive(false)
	self.describeList[3]:SetActive(false)
end

function BagItem:IsAbleDelete()
    if self.itemTables[self.currentPos].ob.gameObject.activeSelf then
        return true
    end
    return false
end

function BagItem:DeleteItem()
    self.itemTables[self.currentPos].HLImageTransform.gameObject:SetActive(false)
	self.itemTables[self.currentPos].ob.gameObject:SetActive(false)	
end