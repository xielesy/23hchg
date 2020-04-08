require("baseclass")
Item = Item or BaseClass()


function Item:__init(ob,id)
	self.id = id
    self.pos = nil
	self.name = nil
	self.spriteIndex = nil
	self.text = nil
	self.type = nil
	self.property = nil
    self.describe = nil
    self.ob = ob
    self.ImageTransform = ob.transform:Find("itemImage"):GetComponent(Image)
    self.TextTransform = ob.transform:Find("itemText"):GetComponent(Text)
    self.HLImageTransform = ob.transform:Find("HLImage"):GetComponent(Image)	
end

function Item:SetData(data)
	self.pos = data.pos
	self.name = data.name
	self.spriteIndex = data.spriteIndex
	self.text = data.text
	self.type = data.type
	self.property = data.property
    self.describe = data.describe
	self.ob.gameObject:SetActive(true)
	self.ImageTransform.sprite = BagManage.Instance:GetSprite(self.spriteIndex)
	self.TextTransform.text = self.text
end

function Item:OnClickHightLightOn()
	self.HLImageTransform.gameObject:SetActive(true)
	return self.id
end
