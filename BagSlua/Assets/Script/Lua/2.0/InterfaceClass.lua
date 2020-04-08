require("baseclass")
InterfaceClass = InterfaceClass or BaseClass()

function InterfaceClass:__init()
    if InterfaceClass.Instance == nil then
        InterfaceClass.Instance = self
    else
        Debug.LogError("InterfaceClass.Instance 失败")
    end
end

function InterfaceClass:AddListenerByButton(object, func)
    object:GetComponent(Button).onClick:AddListener(
		func
	)
end

function InterfaceClass:AddListenerByValueChanged(object, func)
    object.onValueChanged:AddListener(
		func
	)
end