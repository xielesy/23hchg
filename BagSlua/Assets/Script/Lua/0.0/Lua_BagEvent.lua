import "UnityEngine"
import "UnityEngine.UI"

if not UnityEngine.GameObject or not  UnityEngine.UI then
	error("Click Make/All to generate lua wrap file")
end

--物品属性
Itemtables={}
--显示表
Showtables={}
--对象池表
Deletedtables={}
--唯一Id
ItemID=1

Itemsnames={"凶暴护腕","荣誉头饰","愚者盾","诚实法珠","仁慈护符","灵性项链"}

ItemsDes={"被施以狂乱咒术的护腕","附有骁勇善战之骑士灵魂的魔法头饰",
"认为物理防御就是一切的愚者用盾","高级神官用，被施以特殊魔法的法珠",
"传说中由高僧施加防御魔法的护符","经过高级神官加持祝福过的神奇项链"}

ItemsProperty={"物理攻击+40%\n物理防御-15%\n魔法防御-15%","魔法攻击+20%\n命中+20%\n闪避+10%",
"物理防御+40%\n魔法防御-20%","魔法攻击+30%\n命中+20%\n闪避+10%",
"物理防御+20%\n魔法防御+20%","每一回合恢复HP，MP"}

ItemsClass={"护腕","头饰","盾牌","法珠","护符","项链"}
function main()
	print("------------Lua_BagEvent.lua")
end
--获取根节点对象
function getroot(root)
	obroot=root
end

--开始执行Main函数

function EventMain()
	--获取图片资源
	local path="Assets/AssetBunldes/Images/ItemImg/item.image"
    local spritename={"1","2","3","4","5"}
    sprites={}
    local ob=obroot:GetComponent("BagEvent")
    for _, value in pairs(spritename) do
        table.insert(sprites,ob:GetSprite(path,value))
	end

	--已占用格式数量
	ItemNum=0
	items=obroot.transform:Find("BagBackground/ItemBackground/Items")
	Nowitem=items.transform:Find("item")
	NowId=0
	--计算格子容量
	Widthsize=math.floor(items.transform:Find("Itembackground"):GetComponent(RectTransform).rect.width / items.transform:Find("item"):GetComponent(RectTransform).rect.width)
	Heightsize =math.floor(items.transform:Find("Itembackground"):GetComponent(RectTransform).rect.height / items.transform:Find("item"):GetComponent(RectTransform).rect.height)
	--记录对象池数组
	ArrayDelete={}
	targetObject=items.transform:Find("item")
	--绑定增加物品事件
	addbtnob=obroot.transform:Find("BagBackground/Add")
	local addbtn=addbtnob:GetComponent("Button")
	addbtn.onClick:AddListener(AddClick)

	--绑定删除物品事件
	delebtnob=obroot.transform:Find("BagBackground/Delete")
	local delebtn=delebtnob:GetComponent("Button")
	delebtn.onClick:AddListener(DeleClick)

	--绑定整理物品事件
	sortbtnob=obroot.transform:Find("BagBackground/Sort")
	local sortbtn=sortbtnob:GetComponent("Button")
	sortbtn.onClick:AddListener(SortClick)

end

--添加事件实现
function AddClick(...)
	--首先判断对象池里是否为空
	--如果不为空，则从对象池中取出来，作为新增加的物体
	--如果为空，则随机新建一个物体
	if next(Deletedtables)==nil then  --空
		CreateRandom()
	else  --不为空
		CreateBytable()
	end
end

--创造item
function CreateRandom()     
	local itemtable={} 
	local showtable={}
    local num=math.random(1,100)
	local spriteindex=math.random(1,table.getn(sprites))
	local itemindex=math.random(1,table.getn(Itemsnames))
	local newObject=GameObject.Instantiate(targetObject)
    newObject.transform:SetParent(items.transform)
	newObject.gameObject:SetActive(true)
	--[[	--判断显示表中是否为空
	if next(Showtables)==nil then
		ItemNum=0
	else
		--如果为空，取出最后一个元素
	end
	]]

	newObject:GetComponent(RectTransform).anchoredPosition = GetXY()
    --设置图片
	newObject.transform:Find("itemImage"):GetComponent(Image).sprite = sprites[spriteindex]
    --设置数量
    newObject.transform:Find("itemText"):GetComponent(Text).text = tostring(num);
	--设置物品信息
	itemtable.id=ItemID
	itemtable.name=Itemsnames[itemindex]
	itemtable.sprite=sprites[spriteindex]
	itemtable.text=tostring(num)
	itemtable.xy=GetXY()
	--itemtable.HL=false
	itemtable.class=ItemsClass[itemindex]
	itemtable.property=ItemsProperty[itemindex]
	itemtable.describe=ItemsDes[itemindex]
	--加入物品属性表中
	table.insert(Itemtables,itemtable.id,itemtable)

	showtable.ob=newObject
	showtable.id=itemtable.id
	--showtable.itemnum=ItemNum	
	--加入显示表
	table.insert(Showtables,showtable.id,showtable)

	--按钮点击绑定事件
	local onClickHL=newObject:GetComponent("Button")
	onClickHL.onClick:AddListener( function ()
		ClickHL(newObject,itemtable.id)
	end)
	ItemID=ItemID+1
	ItemNum=ItemNum+1

end

function CreateBytable()
	for key, value in pairs(Deletedtables) do
		Itemtables[key].xy=GetXY()
		value.ob:GetComponent(RectTransform).anchoredPosition = GetXY()
		value.ob.gameObject:SetActive(true)
		table.insert(Showtables,value.id,value)
		Deletedtables[key]=nil
		break
	end
	ItemNum=ItemNum+1
end
--选择
function ClickHL(object,id)
	Nowitem.transform:Find("HLImage").gameObject:SetActive(false)
	object.transform:Find("HLImage").gameObject:SetActive(true)
	Nowitem=object
	NowId=id
	DescribeItem(id)
end

--描述
function DescribeItem(id)
	local item=obroot.transform:Find("BagBackground/DescribeBackground/Items/item")
	local describe=obroot.transform:Find("BagBackground/DescribeBackground/Items/Describe")
	item.transform:Find("itemImage"):GetComponent(Image).sprite =Itemtables[id].sprite
	item.transform:Find("itemText"):GetComponent(Text).text =Itemtables[id].text
	describe.transform:Find("DescribeText"):GetComponent(Text).text ="\t\t\t".."<color=#ff0000>"..Itemtables[id].name.."</color>".."\n"
	.."类别：".."<color=#ff0000>"..Itemtables[id].class.."</color>".."\n"
	.."介绍：".."<color=#ff0000>"..Itemtables[id].describe.."</color>".."\n"
	.."属性：".."<color=#ff0000>"..Itemtables[id].property.."</color>".."\n"
	item.transform:Find("itemImage").gameObject:SetActive(true)
	item.transform:Find("itemText").gameObject:SetActive(true)
	describe.transform:Find("DescribeText").gameObject:SetActive(true)
	--string.format()

end

--清除描述
function NoDescribeItem(id)
	local item=obroot.transform:Find("BagBackground/DescribeBackground/Items/item")
	local describe=obroot.transform:Find("BagBackground/DescribeBackground/Items/Describe")
	item.transform:Find("itemImage").gameObject:SetActive(false)
	item.transform:Find("itemText").gameObject:SetActive(false)
	describe.transform:Find("DescribeText").gameObject:SetActive(false)

end

--删除事件实现
function DeleClick(...)
	--需要在有选择对象下才能删除
	if Nowitem ~=targetObject and Showtables[NowId]~=nil and Nowitem.transform:Find("HLImage").gameObject.activeSelf then  
		Nowitem.transform:Find("HLImage").gameObject:SetActive(false)
		Nowitem.gameObject:SetActive(false)	
		Showtables[NowId]=nil
		--将对象添加到对象池中
		local deletedtable={}
		deletedtable.id=NowId
		deletedtable.ob=Nowitem
		--加入对象池
		table.insert(Deletedtables,deletedtable.id,deletedtable)
		NoDescribeItem(NowId)
		table.insert(ArrayDelete,GetItemNum(Itemtables[NowId].xy[1],Itemtables[NowId].xy[2]))
		UpdateItemNum()
	end
end

--整理按钮
function SortClick(...)
	local indexnum=0
	for key, value in pairs(Showtables) do
		local x = targetObject:GetComponent(RectTransform).anchoredPosition.x+ indexnum % Widthsize * targetObject:GetComponent(RectTransform).rect.width
		local y = targetObject:GetComponent(RectTransform).anchoredPosition.y - math.floor(indexnum / Widthsize) % Heightsize * targetObject:GetComponent(RectTransform).rect.height
		value.ob:GetComponent(RectTransform).anchoredPosition = {x, y}
		Itemtables[key].xy={x, y}
		indexnum=indexnum+1
	end
	ItemNum=indexnum
end

--更新已占最大格子
function UpdateItemNum()
	local key,max=table_maxn(ArrayDelete)
	while max==ItemNum-1 do
		ArrayDelete[key]=nil
		key,max=table_maxn(ArrayDelete)
		ItemNum=ItemNum-1
	end
end

--得到待已占格子数
function GetItemNum(curx,cury)
	local num=math.floor((curx-targetObject:GetComponent(RectTransform).anchoredPosition.x)/targetObject:GetComponent(RectTransform).rect.width)
		+math.floor((-cury+targetObject:GetComponent(RectTransform).anchoredPosition.y)/targetObject:GetComponent(RectTransform).rect.height)*Widthsize
	return num
end

--得到xy
function GetXY()
	local x = targetObject:GetComponent(RectTransform).anchoredPosition.x+ ItemNum % Widthsize * targetObject:GetComponent(RectTransform).rect.width
	local y = targetObject:GetComponent(RectTransform).anchoredPosition.y - math.floor(ItemNum / Widthsize) % Heightsize * targetObject:GetComponent(RectTransform).rect.height
	return {x,y}
end

--数组最大值
function table_maxn(t)
	local mn=nil;
	local mk=nil
	for k, v in pairs(t) do
	  if(mn==nil) then
		mn=v
		mk=k
	  end
	  if mn < v then
		mn = v
		mk=k
	  end
	end
	return mk,mn
  end