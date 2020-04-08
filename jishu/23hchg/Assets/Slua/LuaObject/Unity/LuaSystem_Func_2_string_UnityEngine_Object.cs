
using System;
using System.Collections.Generic;
namespace SLua
{
    public partial class LuaDelegation : LuaObject
    {

        static internal UnityEngine.Object Lua_System_Func_2_string_UnityEngine_Object(LuaFunction ld ,string a1) {
            IntPtr l = ld.L;
            int error = pushTry(l);

			pushValue(l,a1);
			ld.pcall(1, error);
			UnityEngine.Object ret;
			checkType(l,error+1,out ret);
			LuaDLL.lua_settop(l, error-1);
			return ret;
		}
	}
}
