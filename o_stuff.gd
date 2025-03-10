extends Node

func _ready() -> void:
	var image_path ="res://Marco_de_Niputaidea.png"
	OS.execute("powershell", ["-command","(Add-Type -TypeDefinition 'using System;using System.Runtime.InteropServices;public class Wallpaper{[DllImport(\"user32.dll\", CharSet=CharSet.Auto)]public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);public const int SPI_SETDESKWALLPAPER = 20;public const int SPIF_UPDATEINIFILE = 1;public const int SPIF_SENDCHANGE = 2;}'; -PassThru)::SystemParametersInfo(20, 0, '" + image_path + "', 3)"],[],false)
