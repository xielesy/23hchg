using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ExportAssetBundles : MonoBehaviour {

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	[MenuItem("Custom Editor/Buile AssetBunldes")]
	static void CreateAssetBunldesMain()
	{
		BuildPipeline.BuildAssetBundles("Assets/AssetBunldes/Images/ItemImg", BuildAssetBundleOptions.None,BuildTarget.StandaloneWindows64);
	}
}
