require("baseclass")
BagData = BagData or BaseClass()
local spriteName = {"10006","10041","35305","35501","40517","c_bg31","c_bg30"}
function BagData:__init()
    self.createDataList = {}
    self.showList = {}
    self.deleteList = {}
    self.itemList = {}
    self.imagespr = {}
    self.sprites = {}
    self.typeList = {"AllType","PropType", "GiftType", "ExperCardType", "PerformType", "InscriptionType", "NewType"}
    self.itemCreate = {
        ["PropType"] = { 
            [10006] = { ["Class"] = "衣服" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [10024] = { ["Class"] = "鞋子" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [10041] = { ["Class"] = "剑" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [20001] = { ["Class"] = "包" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [31104] = { ["Class"] = "宝箱" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
        },
        ["GiftType"] = { 
            [35309] = { ["Class"] = "黄金香蕉" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35500] = { ["Class"] = "狗皮膏" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35501] = { ["Class"] = "奇异果" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35502] = { ["Class"] = "红果" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35509] = { ["Class"] = "神果" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [40515] = { ["Class"] = "凉果" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
        },
        ["ExperCardType"] = {
            [35305] = { ["Class"] = "神仙水" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35503] = { ["Class"] = "琼瑶酒" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [40516] = { ["Class"] = "充值礼包" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [40517] = { ["Class"] = "新手礼包" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
        },
        ["PerformType"] = {
            [30005] = { ["Class"] = "排行榜" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [81003] = { ["Class"] = "令牌" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [89001] = { ["Class"] = "回炉" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [89005] = { ["Class"] = "天书" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
        },
        ["InscriptionType"] = {
            [30002] = { ["Class"] = "火龙珠" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"}, 
            [31103] = { ["Class"] = "能量石" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [31110] = { ["Class"] = "宝石" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [35300] = { ["Class"] = "菜单" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [51100] = { ["Class"] = "金蛋" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
            [90009] = { ["Class"] = "战斗劵" ,["Name"] = "珍稀", ["Count"] = "10", ["Price"] = "100",["Describe"] = "程序猿小哥哥很懒，还没想好写什么。。。。。"},
        },
    }
    self:CreateDataListInit()
    self:SetTypeList()
    self:LoadSprite()
    self:LoadSpriteim()
    if BagData.Instance == nil then
        BagData.Instance = self
    else
        Debug.LogError("BagData.Instance 失败")
    end
end

function BagData:SetCreateDataList(createList)
    self.createDataList.pos = createList.pos
    self.createDataList.icon = createList.icon
    self.createDataList.name = createList.name
    self.createDataList.count = createList.count
    self.createDataList.type = createList.type
    self.createDataList.price = createList.price
    self.createDataList.describe = createList.describe
end

function BagData:CreateDataListInit()
    self.createDataList.icon = nil
    self.createDataList.name = nil
    self.createDataList.count = nil
    self.createDataList.type = nil
    self.createDataList.price = nil
    self.createDataList.describe = nil
end

function BagData:SetTypeList()
    for key, value in pairs(self.typeList) do
        self.showList[value] = {}
        self.deleteList[value] = {}
    end
end

function BagData:LoadSprite()
    local path = "Assets/AssetBunldes/Images/ItemImg/item.image"
    local ob = GameObject.Find("GameManage"):GetComponent("GameStart")
    for _, value in pairs(spriteName) do
        table.insert(self.sprites,ob:GetSprite(path,value))
    end
end

function BagData:LoadSpriteim()
    local path = "Assets/AssetBunldes/Images/ItemImg/item.image"
    local ob = GameObject.Find("GameManage"):GetComponent("GameStart")
    for _, value in pairs(self.itemCreate) do
        for Icon, _ in pairs(value) do
            table.insert(self.imagespr,Icon,ob:GetSprite(path,Icon))
        end
    end
end
function BagData:GetSprite(pos)
    return self.sprites[pos]
end

function BagData:GetSpriteIm(pos)
    for key, value in pairs(self.imagespr) do
        if pos == key then
            return value
        end 
    end
    Debug.LogError("未找到图片")
    return false
end
