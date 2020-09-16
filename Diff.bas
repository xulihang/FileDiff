B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=7.8
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private fx As JFX
End Sub


Sub DiffMultipleLines(oldRows As List, newRows As List)
	Dim generatorStatic As JavaObject
	generatorStatic.InitializeStatic("com.github.difflib.text.DiffRowGenerator")
	Dim generator As JavaObject
	generator=generatorStatic.RunMethodJO("create",Null)
	generator.RunMethod("showInlineDiffs",Array(True))
	generator.RunMethod("inlineDiffByWord",Array(False))
	'generator.RunMethod("oldTag",Array("~"))
	'generator.RunMethod("newTag",Array("**"))
	generator=generator.RunMethod("build",Null)
	
	Dim rows As List
	rows=generator.RunMethod("generateDiffRows",Array(oldRows,newRows))
    Dim index As Int=0
	For Each row As JavaObject In rows
		oldRows.Set(index,row.RunMethod("getOldLine",Null))
		newRows.Set(index,row.RunMethod("getNewLine",Null))
		index=index+1
	Next
End Sub