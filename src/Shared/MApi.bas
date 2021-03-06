Attribute VB_Name = "MApi"
Option Explicit

' Copyright (c) 2017 Jason Peter Brown <jason@bitspaces.com>
'
' MIT License
'
' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:
'
' The above copyright notice and this permission notice shall be included in all
' copies or substantial portions of the Software.
'
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
' SOFTWARE.

' This module is for WIN API declares and wrappers

' API Calls for reversing order of integer and long byte content
Public Declare Function apiNtohs Lib "wsock32.dll" Alias "ntohs" (ByVal a As Integer) As Integer
Public Declare Function apiNtohl Lib "wsock32.dll" Alias "ntohl" (ByVal a As Long) As Long

' Debugging
Private Declare Sub OutputDebugString Lib "kernel32.dll" Alias "OutputDebugStringA" (ByVal lpOutputString As String)

' Copying Bytes
Public Declare Sub apiCopyMemory Lib "kernel32.dll" Alias "RtlMoveMemory" (ByRef Destination As Any, ByRef Source As Any, ByVal Length As Long)

' Waiting
Public Declare Sub apiSleep Lib "kernel32.dll" Alias "Sleep" (ByVal dwMilliseconds As Long)

' Safe Array related
Public Declare Function apiSafeArrayAccessData Lib "Oleaut32" Alias "SafeArrayAccessData" (ByVal psa As Long, pvData As Long) As Long
Public Declare Function apiSafeArrayUnaccessData Lib "Oleaut32" Alias "SafeArrayUnaccessData" (ByVal psa As Long) As Long

' App Path related
Private Const MAX_PATH As Long = 260
Private Declare Function GetModuleFileName Lib "kernel32.dll" Alias "GetModuleFileNameW" (ByVal hModule As Long, ByVal lpFileName As Long, ByVal nSize As Long) As Long

' Unicode Command Line handling
Private Declare Function GetCommandLineW Lib "kernel32.dll" () As Long

' Mutex API related
Public Const SYNCHRONIZE As Long = &H100000
Public Const ERROR_ALREADY_EXISTS As Long = 183&
Public Const ERROR_ACCESS_DENIED As Long = 5&
Public Const ERROR_FILE_NOT_FOUND As Long = 2&
Public Declare Function apiCreateMutex Lib "kernel32.dll" Alias "CreateMutexW" (ByRef lpMutexAttributes As Any, ByVal bInitialOwner As Long, ByVal lpName As Long) As Long
Public Declare Function apiOpenMutex Lib "kernel32.dll" Alias "OpenMutexW" (ByVal dwDesiredAccess As Long, ByVal bInheritHandle As Long, ByVal lpName As Long) As Long
Public Declare Function apiCloseHandle Lib "kernel32.dll" Alias "CloseHandle" (ByVal hObject As Long) As Long

Public Function apiExePath() As String
   apiExePath = String$(MAX_PATH, 0)
   
   GetModuleFileName 0, StrPtr(apiExePath), MAX_PATH
   
   apiExePath = Left$(apiExePath, InStr(1, apiExePath, vbNullChar) - 1)
End Function

Public Sub apiOutputDebugString(ByVal p_Message As String)
   'If envDebugMode Then
      OutputDebugString p_Message
   'End If
End Sub

Public Function apiGetCommandLine() As String
   apiGetCommandLine = libRc5Factory.C.GetStringFromPointerW(GetCommandLineW)
End Function
   
