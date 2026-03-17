B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=4.2
@EndOfDesignText@

Sub Class_Globals
	Dim App As AWTRIX
	Dim animationlist As List
	Dim animationMap As Map
	Dim nextAnimation As String
End Sub

' ignore
public Sub GetNiceName() As String
	Return App.Name
End Sub

' ignore
public Sub Run(Tag As String, Params As Map) As Object
	Return App.interface(Tag,Params)
End Sub

' Config your App
Public Sub Initialize() As String
	animationlist.Initialize
	animationMap.Initialize
	App.Initialize(Me,"App")
	
	'App name (must be unique, avoid spaces)
	App.Name ="LocalAnimations"
	
	'Version of the App
	App.Version ="1.0"
	
	'Description of the App. You can use HTML to format it
	App.Description = "Shows Animations from a local JSON file."
	
	App.CoverIcon = 620
	
	' No HTTP downloads required for local animations
	App.downloads = 0
		
	App.Author = "Custom"
	
	' Load local JSON
	Dim path As String = File.Combine(File.DirApp, "LocalAnimations")
	If File.Exists(path, "Animations.json") Then
		Dim parser As JSONParser
		parser.Initialize(File.ReadString(path, "Animations.json"))
		animationMap = parser.NextObject
		For Each name As String In animationMap.Keys
			If Not(App.settings.ContainsKey(name)) Then
				App.settings.Put(name,True)
			End If
			animationlist.Add(name)
		Next
		
		' Clean up old settings that are no longer in the JSON
		For Counter = App.settings.Size-1 To 0 Step -1
			Dim SettingsKey As String = App.settings.GetKeyAt(Counter)
			If Not(SettingsKey="UpdateInterval" Or SettingsKey="StartTime" Or SettingsKey="EndTime" Or SettingsKey="DisplayTime" Or SettingsKey="Enabled")   Then
				If animationlist.IndexOf(SettingsKey)=-1 Then
					App.settings.Remove(SettingsKey)
				End If
			End If
		Next
	Else
		Log("LocalAnimations: Animations.json not found in " & path)
	End If

	App.MakeSettings
	Return "AWTRIX20"
End Sub

Sub App_Started
	Try
		App.shouldShow=True
		If animationlist.Size>0 Then
			Dim oneActive As Boolean
			For Each AppName As String In animationlist
				If App.settings.Get(AppName) Then
					oneActive=True
				End If
			Next
		
			If oneActive = True Then
				Dim isEnable As Boolean =False
				nextAnimation="random"
				Do Until isEnable
					Dim nextApp As String = animationlist.Get(Rnd(0,animationlist.Size))
					If isactive(nextApp) Then
						isEnable = True
						nextAnimation=nextApp
					End If
				Loop
			Else
				nextAnimation="random"
			End If
		Else
			nextAnimation="random"
		End If
	Catch
		nextAnimation="random"
	End Try
End Sub

Sub isactive(name As String)As Boolean
	If App.Settings.ContainsKey(name) Then
		If App.settings.Get(name) = True Then
			Return True
		Else
			Return False
		End If
	Else
		Return False
	End If
End Sub

'With this sub you build your frame.
Sub App_genFrame
	Try
		If nextAnimation = "random" Or animationMap.ContainsKey(nextAnimation) = False Then
			App.finish
			Return
		End If
		
		Dim jg As JSONGenerator
		Dim animObj As Object = animationMap.Get(nextAnimation)
		If animObj Is Map Then
			jg.Initialize(animObj)
		Else If animObj Is List Then
			jg.Initialize2(animObj)
		Else
			App.finish
			Return
		End If
		
		Dim animData As String = jg.ToString
		
		' By passing the JSON string that contains "data", the AWTRIX server's icondownloader
		' will skip the HTTP fetch and directly pass it to animationhandler!
		App.customCommand(CreateMap("type":"animation","ID": animData))
	Catch
		Log("LocalAnimations Error: " & LastException)
		App.finish
	End Try
End Sub