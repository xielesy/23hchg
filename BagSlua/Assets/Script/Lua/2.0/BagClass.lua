require("baseclass")
require("BagData")
require("ItemClass")
require("SliderManage")
require("InterfaceClass")
BagClass = BagClass or BaseClass()
function BagClass:__init()
	BagData.New()
	self.bagdata = BagData.Instance
	SliderManage.New()
	self.interface = InterfaceClass.New()
	self:GameObjectInit()
	self:SetVarInit()
	self:AddListenerInit()
	self:SetActiveInit()
end

--初始化方法
--start-------------------------------
function BagClass:GameObjectInit()
	--
	self.uiTool = GameObject.Find("GameManage"):GetComponent("UITool")
	local menuUIOb = GameObject.Find("GameUI/MenuUI")
	self.bagBtnTrans = menuUIOb.transform:Find("BagBtn")
	self.bagUITrans = menuUIOb.transform:Find("BagUI")
	self.exitBagTrans = self.bagUITrans:Find("ExitBag")
	--MenuUI
	local moneyUITrans = menuUIOb.transform:Find("MoneyUI")
	self.goldCountText = moneyUITrans:Find("Gold/Count"):GetComponent(Text)
	self.goldAddBtn = moneyUITrans:Find("Gold/Add"):GetComponent(Button)
	self.jewelryCountText = moneyUITrans:Find("Jewelry/Count"):GetComponent(Text)
	self.jewelryAddBtn = moneyUITrans:Find("Jewelry/Add"):GetComponent(Button)
	self.crystalCountText = moneyUITrans:Find("Crystal/Count"):GetComponent(Text)
	self.crystalAddBtn = moneyUITrans:Find("Crystal/Add"):GetComponent(Button)
	--物品类型
	local typeTrans = self.bagUITrans:Find("Type")
	self.allTypeImg = typeTrans:Find("AllType"):GetComponent(Image)
	self.propTypeImg = typeTrans:Find("PropType"):GetComponent(Image)
	self.giftTypeImg = typeTrans:Find("GiftType"):GetComponent(Image)
	self.expercardTypeImg = typeTrans:Find("ExperCardType"):GetComponent(Image)
	self.performTypeImg = typeTrans:Find("PerformType"):GetComponent(Image)
	self.inscriptionTypeImg = typeTrans:Find("InscriptionType"):GetComponent(Image)
	self.newTypeImg = typeTrans:Find("NewType"):GetComponent(Image)
	--描述框
	self.itemBackgroundTrans = self.bagUITrans:Find("Content/Background")
	self.itemTrans = self.itemBackgroundTrans:Find("Item")
	self.itemHL = self.itemTrans:Find("HL")
	local describe = self.bagUITrans:Find("Describe")
	self.describeItemTrans = describe:Find("Item")
	self.describeIconImg = self.describeItemTrans:Find("Icon"):GetComponent(Image)
	self.describeNameText = self.describeItemTrans:Find("Name"):GetComponent(Text)
	self.describeCount = self.describeItemTrans:Find("Count"):GetComponent(Text)
	self.describePriceTipText = self.describeItemTrans:Find("Price"):GetComponent(Text)
	self.describeContentText = describe:Find("ContentDescribe/DescribeText"):GetComponent(Text)
	--新建物品
	self.createTrans = typeTrans:Find("Create")
	self.cretew = menuUIOb.transform:Find("CreateWindow")
	local tip = self.cretew:Find("Tip")
	self.confirm = tip:Find("Confirm")
	self.cancel = tip:Find("Cancel")
	self.tipIconDropdown = tip:Find("Icon/Dropdown"):GetComponent(Dropdown)
	self.tipIconImage = tip:Find("Icon/Dropdown/Icon"):GetComponent(Image)
	self.tipNameInputField = tip:Find("Name/InputField"):GetComponent(InputField)
	self.tipCountSlider = tip:Find("Count/SliderCount/Slider"):GetComponent(Slider)
	self.tipTypeDropdown = tip:Find("Type/Dropdown"):GetComponent(Dropdown)
	self.tipTypeText = tip:Find("Type/Dropdown/Class"):GetComponent(Text)
	self.tipPricesSlider = tip:Find("Price/SliderCount/Slider"):GetComponent(Slider)
	SliderManage.Instance:SliderInit(self.tipPricesSlider)
	self.tipDescribeInputField = tip:Find("Describe/InputField"):GetComponent(InputField)
	--使用物品
	self.use = describe:Find("Use")
	self.useWindow = menuUIOb.transform:Find("UseWindow")
	local useTip = self.useWindow:Find("Tip")
	local useIconItemTran = useTip:Find("Icon/Item")
	self.useIcon = useIconItemTran:Find("Icon"):GetComponent(Image)
	self.useIconName = useIconItemTran:Find("Name"):GetComponent(Text)
	self.useIconCount = useIconItemTran:Find("Count"):GetComponent(Text)
	self.useIconPrice = useIconItemTran:Find("Price"):GetComponent(Text)
	self.useSlider = useTip:Find("SliderCount/Slider"):GetComponent(Slider)
	self.useConfirm = useTip:Find("Confirm"):GetComponent(Button)
	self.useCancel = useTip:Find("Cancel"):GetComponent(Button)
	--售卖物品
	self.sell = describe:Find("Sell")
	self.sellWindow = menuUIOb.transform:Find("SellWindow")
	local sellTip = self.sellWindow:Find("Tip")
	local sellIconItemTran = sellTip:Find("Icon/Item")
	self.sellIcon = sellIconItemTran:Find("Icon"):GetComponent(Image)
	self.sellIconName = sellIconItemTran:Find("Name"):GetComponent(Text)
	self.sellIconCount = sellIconItemTran:Find("Count"):GetComponent(Text)
	self.sellIconPrice = sellIconItemTran:Find("Price"):GetComponent(Text)
	self.sellSlider = sellTip:Find("SliderCount/Slider"):GetComponent(Slider)
	self.sellConfirm = sellTip:Find("Confirm"):GetComponent(Button)
	self.sellCancel = sellTip:Find("Cancel"):GetComponent(Button)
	self.sellGoldCount = sellTip:Find("GetGold/Gold/Count"):GetComponent(Text)
end

function BagClass:AddListenerInit()
	self.interface:AddListenerByButton(
		self.bagBtnTrans,
		function()
			self.bagBtnTrans.gameObject:SetActive(false)
			self.bagUITrans.gameObject:SetActive(true)
		end
	)
	self.interface:AddListenerByButton(
		self.exitBagTrans,
		function()
			self.bagBtnTrans.gameObject:SetActive(true)
			self.bagUITrans.gameObject:SetActive(false)
		end
	)
	self.interface:AddListenerByButton(
		self.propTypeImg,
		function()
			self:onClickType(self.propTypeImg)
		end
	)
	self.interface:AddListenerByButton(
		self.allTypeImg,
		function()
			self:onClickType(self.allTypeImg)
		end
	)

	self.interface:AddListenerByButton(
		self.giftTypeImg,
		function()
			self:onClickType(self.giftTypeImg)
		end
	)
	self.interface:AddListenerByButton(
		self.expercardTypeImg,
		function()
			self:onClickType(self.expercardTypeImg)
		end
	)
	self.interface:AddListenerByButton(
		self.performTypeImg,
		function()
			self:onClickType(self.performTypeImg)
		end
	)
	self.interface:AddListenerByButton(
		self.inscriptionTypeImg,
		function()
			self:onClickType(self.inscriptionTypeImg)
		end
	)
	self.interface:AddListenerByButton(
		self.newTypeImg,
		function()
			self:onClickType(self.newTypeImg)
		end
	)

	self.interface:AddListenerByButton(
		self.createTrans,
		function()
			self:onClickCreateW()
		end
	)
	self.interface:AddListenerByButton(
		self.use,
		function()
			self:onClickUse()
		end
	)
	self.interface:AddListenerByButton(
		self.sell,
		function()
			self:onClickSell()
		end
	)
	self.interface:AddListenerByButton(
		self.confirm,
		function()
			self:onClickConfirmCW()
		end
	)
	self.interface:AddListenerByButton(
		self.cancel,
		function()
			self:onClickCancelCW()
		end
	)
	self.interface:AddListenerByValueChanged(
		self.tipIconDropdown,
		function()
			self:IconDropdownValueChanged()
		end
	)
	self.interface:AddListenerByValueChanged(
		self.tipTypeDropdown,
		function()
			self:TypeDropdownValueChanged()
		end
	)
	self.interface:AddListenerByValueChanged(
		self.sellSlider,
		function()
			self:SellSliderValueChanged()
		end
	)
	self.interface:AddListenerByButton(
		self.sellConfirm,
		function()
			self:onClickConfirmSell()
		end
	)
	self.interface:AddListenerByButton(
		self.sellCancel,
		function()
			self:onClickCancelSell()
		end
	)
	self.interface:AddListenerByButton(
		self.useConfirm,
		function()
			self:onClickConfirmUse()
		end
	)
	self.interface:AddListenerByButton(
		self.useCancel,
		function()
			self:onClickCancelUse()
		end
	)
end

function BagClass:SetActiveInit()
	self.cretew.gameObject:SetActive(false)
	self.bagUITrans.gameObject:SetActive(true)
	self.useWindow.gameObject:SetActive(false)
	self.sellWindow.gameObject:SetActive(false)
	self.itemHL.gameObject:SetActive(false)
	SliderManage.Instance:SliderInit(self.tipCountSlider)
	SliderManage.Instance:SliderInit(self.useSlider)
	self.TypeList[self.currentType].sprite = self.bagdata:GetSprite(6)
	self.uiTool:GetSpriteTable(self.bagdata.imagespr)
	self:HideDescribeItem()
	self:LoadCreateWindow()
end
function BagClass:SetVarInit()
	self.itemId = 1
	self.itemPos = 1
	self.currentId = 1
	self.currentType = "AllType"
	local widthCase = self.itemBackgroundTrans.rect.width
	local heightCase = self.itemBackgroundTrans.rect.height
	self.widthItem = self.itemTrans.rect.width
	self.heightItem = self.itemTrans.rect.height
	self.xItem = self.itemTrans.localPosition.x
	self.yItem = self.itemTrans.localPosition.y
	self.widthSize = math.floor(widthCase / self.widthItem)
	self.heightSize = math.floor(heightCase / self.heightItem)

	self.TypeList = {}
	self.TypeList[self.allTypeImg.name] = self.allTypeImg
	self.TypeList[self.propTypeImg.name] = self.propTypeImg
	self.TypeList[self.giftTypeImg.name] = self.giftTypeImg
	self.TypeList[self.expercardTypeImg.name] = self.expercardTypeImg
	self.TypeList[self.performTypeImg.name] = self.performTypeImg
	self.TypeList[self.inscriptionTypeImg.name] = self.inscriptionTypeImg
	self.TypeList[self.newTypeImg.name] = self.newTypeImg
end
---end-------------------------------

--核心方法
---start----------------------------------
function BagClass:onClickCreateW()
	self:LoadCreateWindow()
	self.cretew.gameObject:SetActive(true)
end
function BagClass:onClickConfirmCW()
	local deletelist = self.bagdata.deleteList["AllType"]
	local tempId = deletelist[1] or self.itemId
	local tempItem = self.bagdata.itemList[tempId] or ItemClass.New(GameObject.Instantiate(self.itemTrans), self.itemId)
	self:SetCreateList()
	tempItem:SetData(self.bagdata.createDataList)
	if tempId == self.itemId then
		tempItem.ob.transform:SetParent(self.itemTrans.parent)
		tempItem.ob.transform.localScale = {1, 1, 1}
		tempItem.ob:GetComponent("Button").onClick:AddListener(
			function()
				self:OnClickHightLightOff()
				self.currentId = tempItem:OnClickHightLightOn()
				self:ShowDescribeItem(tempItem)
			end
		)
		self.itemId = self.itemId + 1
	else
		if tempItem.type ~= "AllType" then
			table.remove(self.bagdata.deleteList[tempItem.type], 1)
		end
		table.remove(self.bagdata.deleteList["AllType"], 1)
	end
	--在itemList表中我们以物品唯一id作为下标，通过id唯一确定物品
	self.bagdata.itemList[tempId] = tempItem
	tempItem.ob.localPosition = self:Getxy(tempItem.pos)
	if tempItem.type ~= "AllType" then
		table.insert(self.bagdata.showList[tempItem.type], tempId)
	end
	table.insert(self.bagdata.showList["AllType"], tempId)
	--当在格子里插入一个物品时候，此时应该将itempos指向下一个位置
	self.itemPos = tempItem.pos + 1
	self.cretew.gameObject:SetActive(false)
end
function BagClass:onClickCancelCW()
	self.cretew.gameObject:SetActive(false)
end
function BagClass:onClickSell()
	local tempItem = self.bagdata.itemList[self.currentId]
	if tempItem.HLTransform.gameObject.activeSelf then
		self.sellIcon.sprite = self.bagdata:GetSpriteIm(tempItem.icon)
		self.sellIconName.text = tempItem.name
		self.sellIconCount.text = string.format("拥有：<color=#ff0000>%s</color>", tempItem.count)
		self.sellIconPrice.text = string.format("价格：<color=#ff0000>%s</color>", tempItem.price)
		self.sellSlider.value = 0
		self.sellSlider.maxValue = tonumber(tempItem.count)
		SliderManage.Instance:SliderInit(self.sellSlider)
		self.sellWindow.gameObject:SetActive(true)
	end
end
function BagClass:onClickConfirmSell()
	local tempItem = self.bagdata.itemList[self.currentId]
	local goldCount = tonumber(self.goldCountText.text)
	self.sellWindow.gameObject:SetActive(false)
	tempItem.count = tempItem.count - self.sellSlider.value
	tempItem.CountTransform.text = tempItem.count
	self.goldCountText.text = goldCount + self.sellGoldCount.text
	if tonumber(tempItem.count) <= 0 then
		tempItem.ob.gameObject:SetActive(false)
		tempItem.HLTransform.gameObject:SetActive(false)
		if tempItem.type ~= "AllType" then
			table.insert(self.bagdata.deleteList[tempItem.type], self.currentId)
		end
		table.insert(self.bagdata.deleteList["AllType"], self.currentId)
		self:ChangeShowList()
		self:HideDescribeItem()
		self:SortClick()
		self:ShowDescribeItem(tempItem)
	end
end
function BagClass:onClickCancelSell()
	self.sellWindow.gameObject:SetActive(false)
end
function BagClass:SortClick()
	self.itemPos = 1
	local showList = self.bagdata.showList[self.currentType]
	for _, value in pairs(showList) do
		local tempItem = self.bagdata.itemList[value]
		tempItem.ob.localPosition = self:Getxy(self.itemPos)
		tempItem.ob.gameObject:SetActive(true)
		self.bagdata.itemList[value].pos = self.itemPos
		self.itemPos = self.itemPos + 1
	end
end
function BagClass:onClickUse()
	local tempItem = self.bagdata.itemList[self.currentId]
	if tempItem.HLTransform.gameObject.activeSelf then
		self.useIcon.sprite = self.bagdata:GetSpriteIm(tempItem.icon)
		self.useIconName.text = tempItem.name
		self.useIconCount.text = string.format("拥有：<color=#ff0000>%s</color>", tempItem.count)
		self.useIconPrice.text = string.format("价格：<color=#ff0000>%s</color>", tempItem.price)
		self.useSlider.value = 0
		self.useSlider.maxValue = tempItem.count
		SliderManage.Instance:SliderInit(self.useSlider)
		self.useWindow.gameObject:SetActive(true)
	end
end
function BagClass:onClickConfirmUse()
	local tempItem = self.bagdata.itemList[self.currentId]
	self.useWindow.gameObject:SetActive(false)
	tempItem.count = tempItem.count - self.useSlider.value
	tempItem.CountTransform.text = tempItem.count
	if tempItem.count <= 0 then
		tempItem.ob.gameObject:SetActive(false)
		tempItem.HLTransform.gameObject:SetActive(false)
		if tempItem.type ~= "AllType" then
			table.insert(self.bagdata.deleteList[tempItem.type], self.currentId)
		end
		table.insert(self.bagdata.deleteList["AllType"], self.currentId)
		self:ChangeShowList()
		self:HideDescribeItem()
		self:SortClick()
		self:ShowDescribeItem(tempItem)
	end
end
function BagClass:onClickCancelSell()
	self.useWindow.gameObject:SetActive(false)
end
---end------------------------------------

--其他方法
--分类-----------------------------------

function BagClass:onClickType(ImgObject)
	self:UpdateOldType()
	self.TypeList[ImgObject.name].sprite = self.bagdata:GetSprite(6)
	self.currentType = ImgObject.name
	self.tipTypeText.text = self.currentType
	self:SortClick()
end

--
--
---数据计算--------------------------------------------
function BagClass:SetCreateList()
	local createList = {}
	createList.pos = self.itemPos
	createList.icon = tonumber(self.tipIconImage.sprite.name)
	createList.name = self.tipNameInputField.text
	createList.count =  tonumber(self.tipCountSlider.value)
	createList.type = self.tipTypeText.text
	createList.price =  tonumber(self.tipPricesSlider.value)
	createList.describe = self.tipDescribeInputField.text
	self.bagdata:SetCreateDataList(createList)
end
function BagClass:Getxy(pos)
	local x = self.xItem + (pos - 1) % self.widthSize * self.widthItem
	local y = self.yItem - math.floor((pos - 1) / self.widthSize) % self.heightSize * self.heightItem
	return {x, y, 0}
end
function BagClass:ChangeShowList()
	local temp = 0
	local len = 0
	local showList = nil
	if self.currentType ~= "AllType" then
		showList = self.bagdata.showList[self.currentType]
		for key, value in pairs(showList) do
			if self.currentId == value then
				temp = key
				break
			end
		end
		table.remove(self.bagdata.showList[self.currentType], temp)
		showList = nil
	end
	showList = self.bagdata.showList["AllType"]
	for key, value in pairs(showList) do
		if self.currentId == value then
			temp = key
			break
		end
	end
	table.remove(self.bagdata.showList["AllType"], temp)
	len = #self.bagdata.showList["AllType"]
	--由于下次新建的物体肯定在显示表最后一个元素(pos)下一位位置
	if len == 0 then
		self.itemPos = 1
	else
		self.itemPos = self.bagdata.itemList[showList[len]].pos + 1
	end
end
--
--
---窗口------------------------------------------------
function BagClass:LoadCreateWindow()
	local textType = self.tipTypeText.text
	local tempList = self.bagdata.itemCreate[textType]
	self.tipIconDropdown:ClearOptions()
	if textType ~= "AllType" and textType ~= "NewType" then
		for key, value in pairs(tempList) do
			local icon = key
			local iconClass = value["Class"]
			self.uiTool:DrowdownAddOptions(icon, iconClass, self.tipIconDropdown)
		end
		self:IconDropdownValueChanged()
	end
end

function BagClass:OnClickHightLightOff()
	self.bagdata.itemList[self.currentId].HLTransform.gameObject:SetActive(false)
end

function BagClass:ShowDescribeItem(tempItem)
	self.describeIconImg.sprite = self.bagdata:GetSpriteIm(tempItem.icon)
	self.describeNameText.text = tempItem.name
	self.describeCount.text = string.format("拥有：<color=#ff0000>%s</color>", tempItem.count)
	self.describeContentText.text = string.format("\t<color=#6E8CB2FF>%s</color>", tempItem.describe)
	self.describePriceTipText.text = string.format("价格：<color=#ff0000>%s</color>", tempItem.price)

	self.describeIconImg.gameObject:SetActive(true)
	self.describeNameText.gameObject:SetActive(true)
	self.describeCount.gameObject:SetActive(true)
	self.describeContentText.gameObject:SetActive(true)
	self.describePriceTipText.gameObject:SetActive(true)
end

function BagClass:HideDescribeItem()
	self.describeIconImg.gameObject:SetActive(false)
	self.describeNameText.gameObject:SetActive(false)
	self.describeCount.gameObject:SetActive(false)
	self.describeContentText.gameObject:SetActive(false)
	self.describePriceTipText.gameObject:SetActive(false)
end

function BagClass:UpdateOldType()
	self.TypeList[self.currentType].sprite = self.bagdata:GetSprite(7)
	self:ClearItem()
end

function BagClass:ClearItem()
	local showList = self.bagdata.showList[self.currentType]
	for _, value in pairs(showList) do
		self.bagdata.itemList[value].ob.gameObject:SetActive(false)
	end
end

function BagClass:IconDropdownValueChanged()
	local iconName = self.tipIconImage.sprite.name
	local textType = self.tipTypeText.text
	local itemCreateByType = self.bagdata.itemCreate[textType]
	if textType ~= "AllType" and textType ~= "NewType" then
		local valueIcon = itemCreateByType[tonumber(iconName)]
		self.tipNameInputField.text = string.format("%s%s", valueIcon["Name"], valueIcon["Class"])
		self.tipCountSlider.value = tonumber(valueIcon["Count"])
		self.tipPricesSlider.value = tonumber(valueIcon["Price"])
		self.tipDescribeInputField.text = valueIcon["Describe"]
	end
end

function BagClass:TypeDropdownValueChanged()
	self:LoadCreateWindow()
end

function BagClass:SellSliderValueChanged()
	local tempItem = self.bagdata.itemList[self.currentId]
	self.sellGoldCount.text = self.sellSlider.value * tempItem.price
end
