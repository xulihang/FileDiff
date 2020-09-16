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


Sub DiffTable(old As String, new As String,onlyDiff As Boolean) As String
	Dim result As String
	Dim htmlhead As String
	htmlhead=$"<!DOCTYPE HTML>
	<html>
	<head>
	<meta charset="utf-8"/>
	<style type="text/css">
	p {font-size: 18px}
	table {width: 100%}
	.editOldInline {color: red}
	.editNewInline {color: red}
	</style>
	</head><body>
	<table border="1" cellpadding="0" cellspacing="1">
	<tr>
	<th>行号</th>
	<th>旧</th>
	<th>新</th>
	</tr>"$
	result=result&htmlhead
	Dim htmlend As String
	htmlend="</table></body></html>"
    Dim oldRows,newRows As List
	oldRows=TextAsList(old)
	newRows=TextAsList(new)
	EvenList(oldRows,newRows)
	Dim lineNumbers As List
	lineNumbers.Initialize
	For i=1 To oldRows.Size
		lineNumbers.Add(i)
	Next
	If onlyDiff Then
		removeDuplicated(oldRows,newRows,lineNumbers)
	End If
	
	Diff.DiffMultipleLines(oldRows,newRows)
	Dim sb As StringBuilder
	sb.Initialize
	For i=0 To oldRows.Size-1
		sb.Append(fillData(lineNumbers.Get(i),oldRows.Get(i),newRows.Get(i)))
	Next
	result=result&sb.ToString&htmlend
	Return result
End Sub

Sub fillData(number As String,old As String, new As String) As String
	Dim one As String
	one=$"<tr>
	<td>${number}</td>
	<td>${old}</td>
	<td>${new}</td>
	</tr>"$
	Return one
End Sub

Sub TextAsList(str1 As String) As List
	Dim list1 As List
	list1.Initialize
	list1.AddAll(Regex.Split("\n",str1))
	Return list1
End Sub

Sub removeDuplicated(list1 As List,list2 As List,lineNumbers As List)
	For i=list1.Size-1 To 0 Step -1
		If list1.Get(i)=list2.Get(i) Then
			list1.RemoveAt(i)
			list2.RemoveAt(i)
			lineNumbers.RemoveAt(i)
		End If
	Next
End Sub

Sub EvenList(list1 As List,list2 As List)
	Do While list1.Size<>list2.Size
		If list1.Size>list2.Size Then
			list2.Add("")
		Else
			list1.Add("")
		End If
	Loop
End Sub