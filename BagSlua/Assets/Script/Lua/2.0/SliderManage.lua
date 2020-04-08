require("baseclass")
SliderManage = SliderManage or BaseClass()

function SliderManage:__init()
    if SliderManage.Instance == nil then
        SliderManage.Instance = self
    else
        Debug.LogError("SliderManage.Instance 失败")
    end
end

function SliderManage:SliderInit(slider)
    local subBtn = slider.transform:Find("Sub"):GetComponent(Button)
    local addBtn = slider.transform:Find("Add"):GetComponent(Button)
    local maxText = slider.transform:Find("MaxText"):GetComponent(Text)
    local valueText = slider.transform:Find("ValueText"):GetComponent(Text)
    maxText.text = tostring(slider.maxValue)
    valueText.text = tostring(slider.value)
    subBtn.onClick:AddListener(
        function()
            self:Sub(slider)
        end
    )
    addBtn.onClick:AddListener(
        function()
            self:Add(slider)
        end
    )
    slider.onValueChanged:AddListener(
        function()
            self:ValueChanged(slider, maxText, valueText, subBtn, addBtn)
        end
    )
end

function SliderManage:Sub(slider)
    if slider.value > slider.minValue then
        slider.value = slider.value - 1
    end
end

function SliderManage:Add(slider)
    if slider.value < slider.maxValue then
        slider.value = slider.value + 1
    end
end
function SliderManage:ValueChanged(slider, maxText, valueText, subBtn, addBtn)
    maxText.text = tostring(slider.maxValue)
    valueText.text = tostring(slider.value)
    if slider.value <= slider.minValue then
        subBtn.interactable = false
    else
        subBtn.interactable = true
    end
    if slider.value >= slider.maxValue then
        addBtn.interactable = false
    else
        addBtn.interactable = true
    end
end