require("baseclass")
require("BagManage")
require("Item")
Bag = Bag or BaseClass()

function Bag:__init()
	self.obRoot = GameObject.Find("BagUI/BagPanel/BagBackground")
	self.startBagOb = GameObject.Find("BagUI/StartBtn")
	BagManage.New()
	--显示表
	self.showTables = {}
	--删除表
	self.deletedTables = {}
	--临时显示表
	self.tempShowTables = {}
	--临时删除表
	self.tempDeletedTables = {}
	--唯一Id
	self.itemId = 1
	--记录格子位置
	self.itemPos = 1
	self.itemList = {}
	self.currentId = 1
	--是否开启自动整理
	self.isAutoSort = false
	local itemBackgroundTrans = self.obRoot.transform:Find("ItemBackground")
	local itemsTransform = itemBackgroundTrans.transform:Find("Items")
	self.targetTransform = itemsTransform.transform:Find("item")
	local widthCase = itemBackgroundTrans.rect.width
	local heightCase = itemBackgroundTrans.rect.height
	self.widthItem = self.targetTransform.rect.width
	self.heightItem = self.targetTransform.rect.height
	self.xItem = self.targetTransform.anchoredPosition.x
	self.yItem = self.targetTransform.anchoredPosition.y
	self.widthSize = math.floor(widthCase / self.widthItem)
	self.heightSize = math.floor(heightCase / self.heightItem)
	self.describeList = {}
	local desItems = self.obRoot.transform:Find("DescribeBackground/Items")
	table.insert(self.describeList, desItems.transform:Find("item/itemImage"):GetComponent(Image))
	table.insert(self.describeList, desItems.transform:Find("item/itemText"):GetComponent(Text))
	table.insert(self.describeList, desItems.transform:Find("Describe/DescribeText"):GetComponent(Text))
	BagManage.Instance:LoadSprite()
	self.startBagOb:GetComponent(Button).onClick:AddListener(
		function()
			self.obRoot:SetActive(true)
			self.startBagOb:SetActive(false)
		end
	)
	self.obRoot.transform:Find("Add"):GetComponent(Button).onClick:AddListener(
		function()
			self:AddClick()
		end
	)
	self.obRoot.transform:Find("Delete"):GetComponent(Button).onClick:AddListener(
		function()
			self:DeleClick()
		end
	)
	self.obRoot.transform:Find("Sort"):GetComponent(Button).onClick:AddListener(
		function()
			self:SortClick()
		end
	)
	self.obRoot.transform:Find("All"):GetComponent(Button).onClick:AddListener(
		function()
			self:AllClick()
		end
	)
	self.obRoot.transform:Find("Weapon"):GetComponent(Button).onClick:AddListener(
		function()
			self:WeaponClick()
		end
	)
	self.obRoot.transform:Find("Armor"):GetComponent(Button).onClick:AddListener(
		function()
			self:ArmorClick()
		end
	)
	self.obRoot.transform:Find("Consumable"):GetComponent(Button).onClick:AddListener(
		function()
			self:ConsumableClick()
		end
	)
	self.obRoot.transform:Find("Exit"):GetComponent(Button).onClick:AddListener(
		function()
			self.obRoot:SetActive(false)
			self.startBagOb:SetActive(true)
		end
	)
	self.obRoot:SetActive(false)
end

function Bag:AddClick()
	-- 如果对象池有元素则从对象池中取已有Id，如果没有，则取新建的Id
	local tempId = self.deletedTables[1] or self.itemId
	local temppos = nil
	self:CreateItem(tempId)
	temppos = self.itemList[tempId].pos
	self.itemList[tempId].ob.anchoredPosition = self:Getxy(temppos)
	table.insert(self.showTables, tempId)
	table.insert(self.tempShowTables, tempId)
	--当在格子里插入一个物品时候，此时应该将itempos指向下一个位置
	self.itemPos = temppos + 1
end

function Bag:CreateData()
	local num = math.random(1, 100)
	local spriteIndex = math.random(1, BagManage.Instance:GetSpriteNum())
	local itemIndex = math.random(1, BagManage.Instance:GetSpriteNum())
	local data = {}
	data.pos = self.itemPos
	data.name = itemIndex
	data.spriteIndex = spriteIndex
	data.text = tostring(num)
	data.type = itemIndex
	data.property = itemIndex
	data.describe = itemIndex
	return data
end

function Bag:CreateItem(id)
	local tempItem = self.itemList[id] or Item.New(GameObject.Instantiate(self.targetTransform),self.itemId)
	if id == self.itemId then
		tempItem.ob.transform:SetParent(self.targetTransform.parent)
		tempItem.ob:GetComponent("Button").onClick:AddListener(
			function()
				self:OnClickHightLightOff()
				self.currentId = tempItem:OnClickHightLightOn()
				self:DescribeItem(tempItem)
			end
		)
		self.itemId = self.itemId + 1
	else
		table.remove(self.tempDeletedTables, 1)
		table.remove(self.deletedTables, 1)
	end
	tempItem:SetData(self:CreateData())
	--在itemList表中我们以物品唯一id作为下标，通过id唯一确定物品
	self.itemList[id] = tempItem
end

function Bag:DescribeItem(item)
	self.describeList[1].sprite = BagManage.Instance:GetSprite(item.spriteIndex)
	self.describeList[2].text = item.text
	self.describeList[3].text =
		string.format(
		"\t\t\t<color=#ff0000>%s</color>\n类别：<color=#ff0000>%s</color>\n介绍：<color=#ff0000>%s</color>\n属性：<color=#ff0000>%s</color>\n",
		BagManage.Instance:GetItemName(item.name),
		BagManage.Instance:GetItemType(item.type),
		BagManage.Instance:GetItemDescribe(item.describe),
		BagManage.Instance:GetItemProperty(item.property)
	)
	self.describeList[1].gameObject:SetActive(true)
	self.describeList[2].gameObject:SetActive(true)
	self.describeList[3].gameObject:SetActive(true)
end

function Bag:OnClickHightLightOff()
	self.itemList[self.currentId].HLImageTransform.gameObject:SetActive(false)
end

function Bag:Getxy(pos)
	local x = self.xItem + (pos - 1) % self.widthSize * self.widthItem
	local y = self.yItem - math.floor((pos - 1) / self.widthSize) % self.heightSize * self.heightItem
	return {x, y}
end

function Bag:DeleClick()
	local tempItem = self.itemList[self.currentId]
	if tempItem.ob.gameObject.activeSelf then
		tempItem.HLImageTransform.gameObject:SetActive(false)
		tempItem.ob.gameObject:SetActive(false)
		table.insert(self.deletedTables, self.currentId)
		table.insert(self.tempDeletedTables, self.currentId)
		self.describeList[1].gameObject:SetActive(false)
		self.describeList[2].gameObject:SetActive(false)
		self.describeList[3].gameObject:SetActive(false)
		self:ChangeShowTables()
		if self.isAutoSort then
			self:SortClick()
		end
	end
end

function Bag:SortClick()
	self.itemPos = 1
	for _, value in pairs(self.showTables) do
		local tempItem = self.itemList[value]
		tempItem.ob.anchoredPosition = self:Getxy(self.itemPos)
		self.itemList[value].pos = self.itemPos
		self.itemPos = self.itemPos + 1
	end
end

function Bag:AllClick()
	self.isAutoSort = false
end

function Bag:WeaponClick()
	self.isAutoSort = true
	self:SortClick()
end

function Bag:ArmorClick()
	self.isAutoSort = true
	self:SortClick()
end

function Bag:ConsumableClick()
	self.isAutoSort = true
	self:SortClick()
end

function Bag:ExitClick()
	
end
function Bag:ChangeShowTables()
	local temp = 0
	local len = 0
	for key, value in pairs(self.showTables) do
		if not self.itemList[value].ob.gameObject.activeSelf then
			temp = key
			break
		end
	end
	table.remove(self.showTables, temp)
	len = #self.showTables
	--由于下次新建的物体肯定在显示表最后一个元素(pos)下一位位置
	self.itemPos = self.itemList[self.showTables[len]].pos + 1
end

function Bag:SetItemPos(xy)
	--itemPos从1开始，第一个格子为偏移量 0 + 1
	self.itemPos =
		math.floor((xy[1] - self.xItem) / self.widthItem) +
		math.floor((-xy[2] + self.yItem) / self.heightItem) * self.widthSize +
		1
end
