using System;
using System.Collections.Generic;
using SLua;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

public class GameStart : MonoBehaviour
{
	public LuaSvr lua_Svr;
	public string path = "/Assets/Script/Lua/2.0/";
	public List<string> vs;
	void Start()
	{
		lua_Svr = new LuaSvr();
		lua_Svr.init(null, complete, LuaSvrFlag.LSF_BASIC | LuaSvrFlag.LSF_EXTLIB);
	}
	
	public Sprite GetSprite(string path, string name)
	{
		AssetBundle ab = AssetBundle.LoadFromFile(path);
		Sprite sprite = ab.LoadAsset<Sprite>(name);
		ab.Unload(false);
		return sprite;
	}
	void complete()
	{
		LuaSvr.mainState.loaderDelegate += LuaLoder;
		lua_Svr.start("GameLuaStart");
		//LuaSvr.mainState.getFunction("GetRoot").call(this.gameObject);
		LuaSvr.mainState.getFunction("Start").call();
		//this.GetComponent<RectTransform>().localPosition
		//this.GetComponent<Button>().interactable
		//this.GetComponent<Slider>().onValueChanged()
		//this.GetComponent<Dropdown>().options
	}

	public byte[] LuaLoder(string fn, ref string absoluteFn)
	{
		string newfn = fn.Replace(".", "/");
		string file_path = Directory.GetCurrentDirectory() + path + newfn + ".lua";
		return File.ReadAllBytes(file_path);
	}
}

