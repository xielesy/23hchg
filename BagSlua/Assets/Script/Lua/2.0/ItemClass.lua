require("baseclass")
ItemClass = ItemClass or BaseClass()

function ItemClass:__init(ob,id)
	self.id = id
    self.pos = nil
	self.name = nil
	self.icon = nil
	self.type = nil
    self.describe = nil
    self.price = nil
    self.count = nil
    self.ob = ob
    self.IconTransform = ob.transform:Find("Icon"):GetComponent(Image)
    self.CountTransform = ob.transform:Find("Count"):GetComponent(Text)
    self.HLTransform = ob.transform:Find("HL"):GetComponent(Image)	
end

function ItemClass:SetData(data)
	self.pos = data.pos
	self.name = data.name
	self.icon = data.icon
	self.count = data.count
	self.type = data.type
	self.price = data.price
    self.describe = data.describe
	self.ob.gameObject:SetActive(true)
	self.IconTransform.sprite = BagData.Instance:GetSpriteIm(self.icon)
	self.CountTransform.text = self.count
end

function ItemClass:OnClickHightLightOn()
	self.HLTransform.gameObject:SetActive(true)
	return self.id
end