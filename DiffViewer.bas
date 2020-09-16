B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=7.8
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
	Private frm As Form
	Private WebView1 As WebView
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	frm.Initialize("frm",600,300)
	frm.RootPane.LoadLayout("diffViewer")
End Sub

Public Sub show
	frm.Show
End Sub

Public Sub loadHtml(html As String)
	WebView1.LoadHtml(html)
End Sub
