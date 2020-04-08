using System;
using SLua;
using System.Collections.Generic;
[UnityEngine.Scripting.Preserve]
public class Lua_UnityEngine_UI_Image_Rotation : LuaObject {
	static public void reg(IntPtr l) {
		getEnumTable(l,"UnityEngine.UI.Image.Rotation");
		addMember(l,0,"None");
		addMember(l,1,"Rotation90");
		addMember(l,2,"Rotation180");
		addMember(l,3,"Rotation270");
		addMember(l,4,"FlipHorizontal");
		addMember(l,5,"FlipVertical");
		LuaDLL.lua_pop(l, 1);
	}
}
