using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using SLua;


public class UITool : MonoBehaviour {
	private LuaTable spriteTable;
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	public void DrowdownAddOptions(string icon,string iconClass,Dropdown dropdown)
	{
		Sprite sprite;
		if (icon == "")
		{
			sprite = new Sprite();
		}
		else
		{
			sprite = (Sprite)spriteTable[int.Parse(icon)];
		}
		Dropdown.OptionData item = new Dropdown.OptionData(iconClass,sprite);
		dropdown.AddOptions(new List<Dropdown.OptionData> { item });
	}
	public void GetSpriteTable(LuaTable table)
	{
		spriteTable = table;
	}
}
