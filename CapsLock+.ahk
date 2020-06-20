/*
;OPTIMIZATIONS START
#NoEnv
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
*/

global trace:=""
global isdown:=0
global PriorKeys:= []
ih := InputHook("I1VL12000")
ih.KeyOpt("{All}", "NV")
ih.OnKeyDown := Func("priorKeyHandler")
ih.Start()
priorKeyHandler(ih, vk, sc) {
	global PriorKeys

	vk := Format("vk{:x}", vk)
	sc := Format("sc{:x}", sc)
	name := GetKeyName(vk sc)
	PriorKeys.InsertAt(1,(name != "") ? name : "undefined")
    
    if(PriorKeys.Length()>700)
   {
 	PriorKeys.RemoveAt(300, 400)
   }
   if (StrLen(ih.input)>10000)
{
ih.Stop()
ih.Start()
}

}


IME_GET(WinTitle="")
;-----------------------------------------------------------
; IMEの状態の取得
;    対象： AHK v1.0.34以降
;   WinTitle : 対象Window (省略時:アクティブウィンドウ)
;   戻り-  1:ON 0:OFF
;-----------------------------------------------------------
{
    ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
 
    ;Message : -_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}
switchime(ime := "A")
{
	if (ime = 1){
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,"00000804", UInt, 1))
	}else if (ime = 0)
	{
		DllCall("SendMessage", UInt, WinActive("A"), UInt, 80, UInt, 1, UInt, DllCall("LoadKeyboardLayout", Str,, UInt, 1))
	}else if (ime = "A")
	{
		;ime_status:=DllCall("GetKeyboardLayout","int",0,UInt)
		sendinput, #{space}
	}}

asc(string){
u :=  A_IsUnicode ? 2 : 1 ;Unicode版ahk字符长度是2
length:=StrPut(string,"CP0")
if(A_IsUnicode)
    {
    VarSetCapacity(address,length),StrPut(string,&address,"CP0")
    }
else
    address:=string
VarSetCapacity(out,2*length*u)
index =0
Loop
{
index += 1
if (index>length-1)
    Break
asc := NumGet(address,index-1,"UChar")
if asc > 126
    {
    index += 1
    asc2 := NumGet(address,index-1,"UChar")
    asc := asc*256+asc2
    }
sendinput, % "{ASC " asc "}"
}
}
 
 
ascaltinput(string){
u :=  A_IsUnicode ? 2 : 1 ;Unicode版ahk字符长度是2
length:=StrPut(string,"CP0")
if(A_IsUnicode)
    {
    VarSetCapacity(address,length),StrPut(string,&address,"CP0")
    }
else
    address:=string
VarSetCapacity(out,2*length*u)
index =0
Loop
{
index += 1
if (index>length-1)
    Break
asc := NumGet(address,index-1,"UChar")
if asc > 126
    {
    index += 1
    asc2 := NumGet(address,index-1,"UChar")
    asc := asc*256+asc2
    }
StringSplit, var, asc,
Loop % var0
{
str .= "{Numpad" var%A_index% "}"
}
sendinput, {AltDown}%str%{Altup}
str =
}
}


#Hotstring EndChars Vv
global mathh
if not A_IsAdmin ;running by administrator
{
   Run *RunAs "%A_ScriptFullPath%" 
   ExitApp
}
IfExist, capslock+icon.ico
{
menu, TRAY, Icon, capslock+icon.ico, , 1
}



global pp
global CLversion:="Version: 0.1| 2020.6.-1`n`nCopyright 2016 Chen JunKai co Peter Wang" 
global orig:=1
global cClipboardAll ;capslock+ clipboard
global caClipboardAll ;capslock+alt clipboard
global sClipboardAll ;system clipboard
global whichClipboardNow  ;0 system clipboard; 1 capslock+ clipboard; 2 capslock+alt clipboard
global clipSaveArr=[]
allowRunOnClipboardChange:=true


 GroupAdd, math, Ahk_exe texworks.exe
 GroupAdd, math, Ahk_exe Typora.exe
 GroupAdd, math, ahk_exe Mathematica.exe
  gosub,hahaha

 
  
 gosub,literal
 
 gosub,label1
    
    Hotstring(":*X:lk","label1",1)
   gosub,eat
   
~[ up::
    isdown=0
    return
<!d::SendInput,[]{left}
return
#if GetKeyState("]")
:*?:-::{Backspace}_
#if GetKeyState("[") 
:*?:l::
:*?:m::
:*?:c::
:*?:r::
:*?:n::
:*?:h::
:*?:x::
:*?:y::
:*?:g::
:*?:u::
:*?:v::
:*?:t::
:*?:k::
:*?:s::
:*?:b::
:*?:1::
:*?:2::
:*?:a::
:*?:z::
:*?:j::
:*?:e::
:*?:d::
:*?:f::
:*?:c::
:*?:q::
:*?:w::
:*?:i::

a:=PriorKeys[1]
if(isdown=0)
    sendinput,{bs}
if(a="1")
    sendinput,P
else if(a="2")
    sendinput,V
else 
sendinput,{ShiftDown}%a%{ShiftUp}
isdown=1
return
#if
:*?C0Z:lj::
sendinput,,
return

:*?B0:sah::
Hotstring("reset")
return


:*?B0:uuo::
sendinput,{backspace 1}
SendInput,{Right 1}
return
:*?B0Z:ooi::
sendinput,{backspace 1}
SendInput,{left 1}
return
:*?B0Z:oop::
sendinput,{backspace 1}
SendInput,{Right 1}
return
:*?B0:oou::
sendinput,{backspace 1}
SendInput,{Left 1}
return
:*?B0:del::
sendinput,{Backspace 3}\delta `
return
:*?B0:delnn::
sendinput,{Backspace 2}{^}n 
return

:*?B0:dellk::
sendinput,{Backspace 2}
gosub,label1
return
:*?B0:cnp::
sendinput,{Backspace 3}\cup `
return
:*?B0:cap::
sendinput,{Backspace 3}\cap `

return
:*?B0:inf::
sendinput,{Left 3}\{Right 3} `
return
:*?B0:nf::
sendinput,{Backspace 2}\infty `
return
:*?B0:eps::
SendInput,{Backspace 3}\varepsilon `
return
:*?B0:kr::
SendInput,{BackSpace 2}\vert `
return

:*?B0:kw::
sendinput,{BackSpace 2}\Big|_
return
:*?B0:kwb::
sendinput,{BackSpace}{{}{}}{left 1}
return
:*?:kww::
sendinput,{BackSpace 4}k{^}2
return
:*?:kw ::
sendinput,{BackSpace 4}k{_}2
return


:*?B0:uou::
sendinput,{backspace 1}
SendInput,{Left 1}
return
:*?B0:ouo::
sendinput,{backspace 1}
SendInput,{Right 1}
return

:*?B0:fc::
SendInput,{left 2}\{right 1}ra{right 1} `
return

:*?:fcss::
SendInput,{bs 4}
sendinput,f&
return

:*?B0:rt::
sendinput,{left 2}\sq{Right 2} `
return
:*?B0:sso::
sendinput,{backspace 1}
SendInput,{Right 1}
return
:*?B0:oos::
sendinput,{backspace 1}
SendInput,{Left 1}
return
:*?B0:sos::
sendinput,{backspace 1}
SendInput,{Left 1}
return
:*?B0:oso::
sendinput,{backspace 1}
SendInput,{Right 1}
return
:*?B0:krc::{BackSpace 1}{left 6}\big{right 6}
:*?:krr::{backspace 4}k{^}3
;:*?C0Z:dh::,
;:*?C0Z:jh::.
:*?C0Z:kkj::
SendInput,.
return

;:*?C0Z:fh::
;sendinput,;
;return

:*?C0Z:emf::
SendInput,===={left 2}
return

;:?*b0:col::
;return
:?*b0:ijk::

:?*C0Z:dol::
asc("$")
return
:?*:gee::\geqslant `
:?*:lee::\leqslant `
:*?C0:fjj::  
sendinput,^P
return
:*?C0:fkk::{F11}

~Shift::
Hotstring("reset")
return
~Shift up::
Hotstring("reset")


Sleep,13
varial:=A_PriorKey
If(varial="Lshift")
{
If (IME_GET()=1){
    
    Hotstring(":*X:lk","label1",1)
    gosub,literal
gosub,eat
    }else{
    
    Hotstring(":*X:lk","label4",1)
        gosub,literal
gosub,shit
   
}
}

return





~LButton up::
global trace
global mathh
if ((WinExist("A")!=trace)and(trace!=""))
 {   a:=trace
    gosub literal
    trace:=a
}
else if ((WinExist("A")=trace)and(mathh=0))
    gosub math
    
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
If  (A_Cursor = "IBeam" ) {
	Edit_Mode := 1
} else if(A_Cursor = "Arrow" ) {
   Edit_Mode := 0
} 

 not_Edit_InFocus(){
global color
Global Edit_Mode
ControlGetFocus theFocus, A ; 取得目前活動窗口 的焦點之控件标识符
return  (Edit_Mode = 0) or (color="0xCCEDC7")
;!(inStr(theFocus , "Edit") or  (theFocus = "Scintilla1")   ;把查到是文字編輯卻不含Edit名的theFucus加進來
;or (theFocus ="DirectUIHWND1") or  (Edit_Mode = 1))
}
;MouseGetPos, , , WhichWindow, WhichControl
;WinGetPos,winx,winy,,,%WhichWindow%
;ControlGetPos, x, y, w, h, %WhichControl%, ahk_id %WhichWindow%
;~ ToolTip, %WhichControl%`nX%X%`tY%Y%`nW%W%`t%H%
; Control+Alt+Z hotkey.



if ( 0 = not_Edit_InFocus())
{ 

	If (IME_GET()=1)
    {
        ToolTip % "中" 
	}else{
		ToolTip, 英
    }
    Sleep,350
ToolTip
return
}
return
 
 




<!q::
Hotstring("Reset")
SendInput -
return

<!f::
SendInput {+}
return
<!r::
Hotstring("Reset")
asc("{}")
SendInput,{left 1}
return
<!w::
Hotstring("Reset")
SendInput,(){left 1}
if mathh=1
{
input,a,L1V,{left}{right}
if Instr(a,"b")
    sendinput,{bs}\right^{left 2}\left{right}
}
return
!BackSpace::
SendInput,+{End}
SendInput,{Delete}
return 


;删除光标到行首的内容
;!o::
;sendinput,+{right}
;return


!l::SendInput,]
!i::SendInput,\left( \right){left 7}
!p::sendinput,\left \right{left 6}
!1::SendInput,3

$!j::
if(CapsLock=1){
try
    runFunc(keyset.caps_lalt_j)
Capslock2:=""
}else{
       if(mathh=1){
    SendRaw,[
}else{
SendInput,!j
}
}
return
$!k::
if(CapsLock=1){
try
    runFunc(keyset.caps_lalt_k)
Capslock2:=""
}else{
    if(mathh=1)
    {
    Sendraw,\}
    }else{
SendInput,!k
}
}
return
{
!h::
if(mathh=1)
    SendRaw,\{
else
    SendInput,+{Home}{Delete}
return 

#if
#Hotstring ? O C1 Z
 
:*:ijn::
asc("\Big/")
return
:*:jn::
asc("/")
return
:*R:rpp::\Re `
:*?:feh::

MsgBox,,,% A_Priorhotkey
:*R:ipp::\Im `
:*:sup::\sup `
:*:sbb::\subset `
:*:subb::\subset `
:*:spp::\supset `
:*:limm::\lim

:*:mrin::\mathring `

:*:rmm::\mathrm `
:*:rmb::\mathrm{{}{}}{left 1}
:*:fz::f(z)
:*:gz::g(z)
:*:cal::\mathcal `
:*:calb::\mathcal{{}{}}{left 1}

:*:fx::
asc("f(x)")
return
:*:gx::
asc("g(x)")
return
:*:hx::
asc("h(x)")
return
:*:mbb::\mathbb ` 
:*:mbf::\mathbf ` 
}

#if GetKeyState("q")  AND WinActive("Ahk_group math")AND mathh=0
:*?:g::{Backspace}!g
#if GetKeyState("q")  AND WinActive("Ahk_group math") AND mathh=1
:*?:j::
SendInput,{bs}-
return
:*?:f::
sendinput,{Backspace}
if(A_PriorKey="f")
    Sendinput,{^}{+}
    else
{
sendinput,{+}
}
return
:*?:e::
sendinput,{Backspace}
if(A_PriorKey="e")
    Sendinput,:
    else
{
sendinput,=

}
return
:*?:w::

sendinput,{Backspace}
if(A_PriorKey="w")
    Sendinput,{Delete}-
    else if(A_PriorHotkey=":*?:w" and SubStr(ih.input,-2, 1)="w"and SubStr(ih.input,-3,1)="q")
        Sendinput,{bs}{Delete}-
        else
{
sendinput,(){left 1}
input,a,L1V,{left}{right}
if Instr(a,"b")
    sendinput,{bs}\right^{left 2}\left{right}`
if Instr(a,"w")
    sendinput,{bs 2}{Delete}-
}
return

:*?:d::
sendinput,{Backspace}
if(A_PriorKey="d")
    Sendinput,{Delete}{{}{}}{left 1}
    else
{
sendinput,[]{left 1}
}
return
#if (GetKeyState("q") OR GetKeyState("p")) AND WinActive("Ahk_group math") AND mathh=1
:*?:l::{Backspace}L
:*?:m::{Backspace}M

:*?:x::{Backspace}X
:*?:y::{Backspace}Y
:*?:g::{Backspace}G
:*?:u::{Backspace}U
:*?:v::{Backspace}V
:*?:t::{Backspace}T
:*?:k::{Backspace}K
:*?:s::{Backspace}S
:*?:b::{Backspace}B
:*?:i::{Backspace}I


#if GetKeyState("q") AND WinActive("Ahk_group math") AND mathh=1
:*?:c::
:*?:r::
:*?:q::
:*?:n::
:*?:z::
:*?:h::
:*?:p::
a:=PriorKeys[1]
sendinput,{ShiftDown}%a%{ShiftUp}
return
#if GetKeyState("m") AND WinActive("Ahk_group math") AND mathh=1
:*?:p::
sendinput % "{bs}\mathbb {ShiftDown}" SubStr(ih.input,0) "{ShiftUp} `" 
Input,a,L2 V,{left}{right},n,w,r,f,b,e,o,1,2,3,4,5,6
if(Errorlevel="Match")
    if Instr(a,"b")
            sendinput,{bs}(){left 1}
            else
sendinput % "{bs}{left}{_}" (a="e"?"1":(a="f"?"\infty":(a="w"?"2":(a="r"?"3":(a="o"?"0":a))))) "{right}"
Hotstring("reset")
return
#if GetKeyState("c") AND WinActive("Ahk_group math") AND mathh=1
:*?:p::
:*?:l::
:*?:f::
Hotstring("reset")
sendinput % "{bs}\mathcal {ShiftDown}" SubStr(ih.input,0) "{ShiftUp} `" 
Input,a,L2 V,{left}{right},n,w,r,f,b,e,1,2,3,4,5,6
if(Errorlevel="Match")
    if Instr(a,"b")
            sendinput,{bs}(){left 1}
            else
sendinput % "{bs}{left}{_}" (a="e"?"1":(a="f"?"\infty":(a="w"?"2":(a="r"?"3":(a="o"?"0":a))))) "{right}"
return
#if GetKeyState("p") AND WinActive("Ahk_group math") AND mathh=1
:*?:e::{Backspace}E
:*?:d::{Backspace}D
:*?:f::{Backspace}F
:*?:c::
:*?:r::
:*?:q::
:*?:n::
:*?:z::
:*?:h::
:*?:a::
sendinput % "{bs}\" (InStr(A_ThisHotkey,"a")?"mathbb ":"") "{ShiftDown}" SubStr(ih.input,0) "{ShiftUp} `" 
Input,a,L2 V,{left}{right},n,w,r,f,e,1,2,3,4,5,6
if(Errorlevel="Match")
{
sendinput % "{bs}{left}" (Instr(A_ThisHotkey,"a")?"_":"{^}") (a="f"?"\infty":(a="e"?"1":(a="w"?"2":(a="r"?"3":(a="o"?"0":a))))) "{right}"
}
Hotstring("reset")
return

:*?:w::{Backspace}W
:*?:j::

if((Priorkeys[2]="j")or(Priorkeys[2]="o"))
{
SendInput,{left}
}
    else
{
    
sendinput,{Backspace}
SendInput,{left}
}
return
:*?:o::
if ((Priorkeys[2]="j")or(Priorkeys[2]="o"))
{
SendInput,{right}
 }
 else
{
sendinput,{Backspace}
SendInput,{right}
}
return

#IfWinActive Ahk_group math

:*?:fcp::
SendInput,{Backspace 4}f\circ `
return
:*:bweg::\bigwedge `
:*:weg::\wedge `
:*:noin::\notin `
:*:bee::\beta `
:*:bot::\bot `
:*:tau::\tau `
:*:staa::*
::begfr::\begin{{}frame{}}{enter 2}\end{{}frame{}}{left 11}
::begbl::\begin{{}block{}}{enter 2}\end{{}block{}}{left 11}
::begal::\begin{{}aligned{}}{Left}{PGDN}\end{{}aligned{}}{left 13}
::begar::\begin{{}array{}}{{}{}}{PGDN}\end{{}array{}}{left 12}
::beg::\begin{{}{}}{PGDN}\end{{}{}}
:*:gath::\begin{{}gathered{}}\end{{}gathered{}}{left 14}
:*:frak::\mathfrak `
:*:foal::\forall `
:*:lag::\langle `
:*:grad::\mathrm{{}grad{}} `
:*:rag::\rangle `
:*:agg::
sendinput,\langle \rangle{left 7}
input,a,L1V,{left}{right}
if Instr(a,"b")
    sendinput,{bs}\right^{left 4}\left^{Right 2} `
return
:*:dzz::\mathrm dz
:*:opnb::\operatorname{{}{}}{left 1}
:*:opnn::\operatorname `
::sigc::\varSigma `
:*:sigcc::\Sigma `

::sig::\varsigma `
:*:sigb::\sigma(){left 1}

:*:cosh::\cosh `


::sigx::\sigma(x) 
:*:sigg::\sigma `
:*:lrar::\leftrightarrow ` 
:*:lgra::\longrightarrow ` 
:*:lgla::\longleftarrow ` 
::rh::\rightharpoonup `
:*:rsa::\rightsquigarrow `
:*:qwer::
sendinput,\overline{{}{}}
sendinput,{left 1}
return


::lh::\leftharpoonup `
::''::{^}\prime `


::AML::\amalg `
::tf::\ftfrac ` 
::gx::
asc("g(x)")
return
:*:\::
asc("\")
return
::gv::g(){left 1}
:*:lnx::\ln(x)
:*:lnb::\ln(){left 1}
:*:lnn::\ln ` 
:*B0Z:fcd::
SendRaw,{\mathrm d}{\mathrm d}
SendInput,{left}
return
:*:sbe::\subseteq `
:*:spe::\supseteq `

:*:mapp::
asc("\mapsto ")
return












::the::\vartheta `
:*:thec::\Theta `
:*:lamb::\lambda(){left 1} 
::lam::\varLambda `
:*:lamc::\Lambda `
:*:lamm::\lambda `
::gam::\varGamma `
:*:gamc::\Gamma `
:*:gamm::\gamma `
:*:gamb::\gamma(){left 1}
:*:omgc::\Omega `
:*:omgg::\omega `
::omg::\varOmega `
:*:delc::
sendinput,{Backspace 3}Delta `
return
:*:cnpp::
sendinput,{Backspace 1}bigcup_{{}{}}{Left 1}`
return
:*:capp::
sendinput,{Backspace 1}bigcap_{{}{}}{Left 1} `
return
:*:vee::
sendinput,\vee `
return
:*:veb::
sendinput,\bigvee_{{}{}}{Left 1} `
return
:*:delv::
SendInput,{Backspace 3}varDelta `
return

:*:phic::\Phi `
:*:intt::\int `
:*:intu::\int{^}{{}{}}{left 1}
:*:intd::\int{_}{{}{}}{left 1}
:*:intb::\int{_}{{}{}}{^}{{}{}}{left 4}
:*:parb::\frac{{}\partial {}}{{}\partial {}}{left 12}
:*:parr::\partial `
:*?:phi::
:*?:alp::
hs := A_ThisHotkey  ; For convenience and in case we're interrupted.
    if (hs == ":*?:alp")
            Sendinput,\alpha `
            else
                Sendinput,\varphi `
Input,Userinput,V L1,{left}{right},r,x,t,s,b,d, ,
if Errorlevel in Match
{
    SendInput,{bs}
if InStr(Userinput,"r")
    {
    sendinput,'
    Input, Userinput,V L1,{left}{right},x,t,s,b,d
    if Errorlevel in Match
       sendinput,{bs}
    }
if InStr(Userinput,"b")
    sendinput,(){left}
if Instr(Userinput,"t")
    sendinput,(t)
if Instr(Userinput,"x")
    sendinput,(x)
if Instr(Userinput," ")
    sendinput,^{left 2}_^{right 2}
    
        
}
return

:*:ds::
Input, Userinput,V L1,{left}{right}
if(Userinput="c")
    {
    sendinput,{bs}
    sendinput,\cdots `
    }
    if(Userinput="s")
    {
    sendinput,{bs}
    sendinput,\mathrm{{}d{}}s
    }
    if(Userinput="v")
    {
    sendinput,{bs}
    sendinput,\vdots `
    }
     if(Userinput="d")
    {
    sendinput,{bs}
    sendinput,\ddots `
    }
     if(Userinput="l")
    {
    sendinput,{bs}
    sendinput,\ldots `
    }
    
    return
:*:dt::
Input, Userinput,V L1,{left}{right},c,o,t,v,d,l,h
if Instr(ErrorLevel,"Match")
{
    sendinput,{bs}
    if(Userinput="c")
    {
    sendinput,\cdot `
    }
    if(Userinput="o")
    {
    sendinput,\odot `
    }
    if(Userinput="t")
    {
    sendinput,\mathrm{{}d{}}t
    }
    if(Userinput="v")
    {
    sendinput,\vdot `
    }
     if(Userinput="d")
    {
    sendinput,\ddot `
    }
     if(Userinput="l")
    {
    sendinput,\ldot `
    }
    if(Userinput="h")
    {
    sendinput,\mathrm{{}d{}}\theta `
    }
}
Hotstring("reset")
return
:*?:uu::
sendinput,{^}
Input, Userinput,V L1,{space}
If InStr(ErrorLevel,"End")
    sendinput,{bs 2}uu
return
:*:ke::
SendInput,||{left}
Input, Userinput,V L1,{left}{right}
If InStr(Userinput," ")
    sendinput,{bs 2}k{_}1{Delete}
If InStr(Userinput,"e")
    sendinput,{bs 2}k{^}1{Delete}
If InStr(Userinput,"b")
    sendinput,{bs}{left}\left{right}\right^{left 2}
return
:*:nee::\ne `
:*?CZ:ee::
SendInput,{^}1 `
input,a,L2V,{left}{right}{Space},e
if inStr(Errorlevel,"Match")or Instr(Errorlevel,"Space")
{    sendinput,{bs 4}
if instr(a,"e")
    sendinput,e{^}1
else 
    sendinput,e_1
}
Hotstring("Reset")
return


:*:exp::
:*:log::
:*:cos::
:*:sin::
:*:tan::
sendinput,%A_ThisHotkey%{left 3}{bs 3}\{right 3} `
Input, Userinput,V L1,{left}{right},b,v,u,w,x,z,t   
if InStr(ErrorLevel, "Match")
    sendinput,{bs}
else 
    return
if(Userinput="w")
    {
    SendRaw,^2 `
    Input, Userinput,V L1,{left}{right},b,v,u,x,z,t
    if InStr(ErrorLevel, "Match")
        sendinput,{bs 1}
    else return
    }
if(Userinput="b")
    sendinput,(){left}
if(Userinput="v")
    sendinput,(v)
if(Userinput="u")
    sendinput,(u)
if(Userinput="x")
    sendinput,(x)
if(Userinput="z")
    sendinput,(z)
if(Userinput="t")
    { 
    sendinput,(t)
    Input,Userinput,V L1,{left}{right}
    if(Userinput="h")
        {
        sendinput,{bs}{left 1}{bs}\theta{right 1}
        Input,Userinput,V L1,{left}{right},h,w,v
        if Instr(Errorlevel,"Match")
            sendinput,{bs}
        else 
            return
        if(Userinput="w")
            sendraw,^2
        if(Userinput="v")
            sendinput,{left 6}var{right 6}
            
        }   
    }

return



:*:qqd::\qquad `
;:*:qd::\quad ` 
:*B0Z:fcb::
SendInput,{{}{}}{{}{}}{left 3}
return
:*:psii::\psi `
:*:otimb::\bigotimes `
:*:otimm::\otimes `
:*:timm::\times `
:*:vec::\vec `
:*:kap::\kappa `

:*:dxx::\mathrm{{}d{}}x
:*:dyy::\mathrm{{}d{}}y
:*:duu::\mathrm{{}d{}}u
:C*:Var::\operatorname{{}Var{}}(){left 1}
::co::\operatorname{{}Cov{}}(){left 1}
::hx::h(x)
:*:fnt::
asc("[^]")
SendInput,{left}
return
:*:fnnt::
asc("[^]:")
SendInput,{left 2}
return
:*:inv::{^}{{}-1{}}
:*?B0:infb::_{{}{}}{{}{}}{left 3}
:*?B0:infd::{{}{}}
:*:cass::\cases{{}\\{}}{left 3}
:?*:rtb::t{{}{}}{LEFT 1}
:*:cop::\circ `
:*:sime::\simeq `
:*:simm::\sim `

::tr::\mathrm{{}tr{}}

:*?:str::
sendinput,4
Input, Userinput,V L4,{left}{right},r
If (ErrorLevel="Match")
{
sendinput,{bs 2}2
Input, Userinput,V L2,{left}{right}
sendinput,{bs 3}
b:=SubStr(Userinput,1,1)
c:=SubStr(Userinput,0)
sendinput % ( b . "," . b+1 . ",\ldots") . (c="f" ? "\ " : "," . c)
}else if(ErrorLevel="Max")
{
sendinput,{bs 5}
a:=SubStr(Userinput,1,1)
b:=SubStr(Userinput,2,1)
c:=SubStr(Userinput,3,1)
d:=SubStr(Userinput,0)
c:=(c="w")?2:((c="o")?0:((c="e")?1:((c="r")?3:c)))
sendinput % (a . (b="d" ? "_" : "{^}") . c . "," . a . (b="d" ?"_":"{^}") . c+1 . ",\ldots")  . (d="f" ? "\ ":"," . a . (b="d" ? "_" : "{^}") . d)
}
return
:*:limx0::\lim\limits_{{}x\to0{}}
:*:limt0::\lim\limits_{{}t\to 0{}}
:*:limn0::\lim\limits_{{}n\to0{}}
:*:limz0::\lim\limits_{{}z\to 0{}}
:*:limz ::\lim\limits_{{}z\to {}}{left 1}
:*:limx ::\lim\limits_{{}x\to{}}{left 1}
:*:limt ::\lim\limits_{{}t\to{}}{left 1}
:*:limn ::\lim\limits_{{}n\to{}}{left 1}
:*:limh ::\lim\limits_{{}h\to{}}{left 1}
:*:limk ::\lim\limits_{{}k\to{}}{left 1}
:*:limj ::\lim\limits_{{}j\to{}}{left 1}
:*:limti::\lim\limits_{{}t\to\infty{}}
:*:limni::\lim\limits_{{}n\to\infty{}}
:*:limli::\lim\limits_{{}l\to\infty{}}
:*:limzi::\lim\limits_{{}n\to\infty{}}
:*:limxi::\lim\limits_{{}x\to\infty{}}
:*:limxi::\lim\limits_{{}x\to\infty{}}
:*:limki::\lim\limits_{{}k\to\infty{}}
:*:limji::\lim\limits_{{}j\to\infty{}}


:R:pxi::\frac{\partial } {\partial x^i}
:R:pri::\frac{\partial\ } {\partial r^i}





:*:sumk0n::\sum\limits_{{}k=0{}}{^}{{}n{}}
:*:sumk1i::\sum\limits_{{}k=1{}}{^}{{}\infty{}}
:*:sumk0i::\sum\limits_{{}k=0{}}{^}{{}\infty{}}
:*:sumk0b::\sum\limits_{{}k=0{}}{^}{{}{}}{left 1}
:*:sumk1n::\sum\limits_{{}k=1{}}{^}{{}n{}}
:*:sumkb::\sum\limits_{{}k={}}{^}{{}{}}{left 4}
:*:sumkni::\sum\limits_{{}k=n{}}{^}{{}\infty{}}

:*:sumi1n::\sum\limits_{{}i=1{}}{^}{{}n{}}
:*:summ::\sum `
:*:sumi1n::\sum\limits_{{}i=1{}}{^}{{}n{}}
:*:sumini::\sum\limits_{{}i=n{}}{^}{{}\infty{}}
:*:sumjni::\sum\limits_{{}j=n{}}{^}{{}\infty{}}
:*:sumi0n::\sum\limits_{{}i=0{}}{^}{{}n{}}
:*:sumi1i::\sum\limits_{{}i=1{}}{^}{{}\infty{}}
:*:sumi0i::\sum\limits_{{}i=0{}}{^}{{}\infty{}}
:*:sumn1i::\sum\limits_{{}n=1{}}{^}{{}\infty{}}
:*:sumn0i::\sum\limits_{{}n=0{}}{^}{{}\infty{}}
:*:sumni::\sum\limits_{{}n{}}{^}{{}\infty{}}
:*:sumj0n::\sum\limits_{{}j=0{}}{^}{{}n{}}
:*:sumj1i::\sum\limits_{{}j=1{}}{^}{{}\infty{}}
:*:sumj0i::\sum\limits_{{}j=0{}}{^}{{}\infty{}}
:*:sumb::\sum\limits_{{}{}}{^}{{}{}}{left 4}
:*:sumd::\sum\limits_{{}{}}{left 1}
:*:sumii::\sum\limits_{{}-\infty{}}{^}{{}\infty{}}
:*:sumnii::\sum\limits_{{}n=-\infty{}}{^}{{}\infty{}}
:*:sumn0b::\sum\limits_{{}n=0{}}{^}{{}{}}{left 1}
:*:sumi0b::\sum\limits_{{}i=0{}}{^}{{}{}}{left 1}
:*:sumj0b::\sum\limits_{{}j=0{}}{^}{{}{}}{left 1}
:*:sumn1b::\sum\limits_{{}n=1{}}{^}{{}{}}{left 1}
:*:sumi1b::\sum\limits_{{}i=1{}}{^}{{}{}}{left 1}
:*:sumj1b::\sum\limits_{{}j=1{}}{^}{{}{}}{left 1}
:*:sumj1n::\sum\limits_{{}j=1{}}{^}{{}n{}}
:*:sumib::\sum\limits_{{}i={}}{^}{{}{}}{left 4}
:*:sumjb::\sum\limits_{{}j={}}{^}{{}{}}{left 4}
:*:sumnb::\sum\limits_{{}n={}}{^}{{}{}}{left 4}



:*?:jj::	


If (IME_GET()=1)
{
SendInput,^ `
gosub, shit
gosub, math
asc(" $$ ")
SendInput,{left 2}
}else{
    gosub, shit
gosub, math
asc(" $$ ")
SendInput,{left 2}
}
SetCapsLockState,off


return


#IfWinActive
/*
:*?:jj::	


If (IME_GET()=1)
{
SendInput,^  $$ {left 2}
}else{

SendInput, $$ {left 2}
}
SetCapsLockState,off

gosub, shit
gosub, math
return
*/
:*:arg::\arg `
:*:pii::\pi `
:*:inn::\in `
:*:ww::{^}2 
:*:rr::
SendInput,{^}3 
return

:*:tt::{^}4 
:*:sm::<
:*C:bg::
asc(">")
return
:*:mm::{^}m 
:*:y ::_y
:*:x ::_x 
:*:w ::_2 
:*:e ::_1
:*:p ::_p 
:*:r ::_3 
:*:t ::_4 
:*:o ::_0
:*:n ::_n  
:*:m ::_m  
:*R:i ::_i
:*R:j ::_j
:*R:k ::_k 
:*:/::
asc("/")
return
::equ::\equiv `
:*:weh::?
return
:*:pozh::
asc("——")
return
:*:slh::
asc("……")
return
:*:jgh::
asc("\#")
return
:*:staa::*
:*:slaa::**{left 2}
:*:dunh::
asc("、")
return



:R?*:alf::\alef `
:*:csb::&$   ${left 2}
:*:css::&

:*:\::
asc("\")
return
:*:muu::\mu `
:*:muh::\hat\mu `
:*:sigh::\hat\sigma `
:*:nuu::\nu `

:*:shx::
global orig=IME_GET()
If (orig=1)
{
     SendInput,^ `
}else{
}
SetCapsLockState,off
gosub,shit
gosub, math
return
:*:wez::
gosub, literal
global orig
If (orig=IME_GET())
{
}else{
  SendInput,^ `
  gosub,eat
}
SetCapsLockState,off
return


label1:
Input,,L0V

If (IME_GET()=0){
    sendinput,^ `
    }else{
        
    }
gosub, literal
gosub, eat
SetCapsLockState,off
sendinput,{end}
sendinput,^r
input,a,VL1,{left}{right},k,i
if Instr(a,"o")
    sendinput,{bs}{PGDN}{Down}
if Instr(a,"i")
    sendinput,{bs}{Down}
return


label4:
Input,,L0V
sendinput,{end}
SetCapsLockState,off
gosub, literal
If (IME_GET()=1)
{
     sendinput,^ `
}else{
}
sendinput,^r
input,a,VL1,{left}{right},k,i
if Instr(a,"o")
    sendinput,{bs}{PGDN}{Down}
if Instr(a,"i")
    sendinput,{bs}{Down}
return

:*:jk::
SetCapsLockState,off
If (IME_GET()=0)
{
gosub,literal
    gosub,eat
    }else{
        gosub,shit
    gosub,literal

    }
     sendinput,^ `

return



:*:minn::\min `
:*:maxx::\max `
:*:minb::\min\{{}\{}}{left 2} 
:*:maxb::\max\{{}\{}}{left 2}
:*:mind::\min_{}}{}}{left 1} 
:*:maxd::\max _{{}{}}{left 1}
:*:ff::2

:*:oi::
if( A_PriorHotkey!="*$p")
{
SendInput,{right 1}
}else{
SendInput,oi
}
return

:*:noth::\varnothing `



return

literal:
global trace:=""
global mathh:=0
Hotstring(":?:minn",,0)
Hotstring(":?:minb",,0)
Hotstring(":?:mind",,0)
Hotstring(":?:cal",,0)
Hotstring(":?:fz",,0)
Hotstring(":?:gz",,0)

Hotstring(":?:rpp",,0)
Hotstring(":?:ipp",,0)
Hotstring(":?:w",,0)
Hotstring(":?:e",,0)
Hotstring(":?:r",,0)
Hotstring(":?:t",,0)
Hotstring(":?:o",,0)
Hotstring(":?:kr",,0)
Hotstring(":?:kw",,0)
Hotstring(":?:msta",,0)
Hotstring(":?:jm",,0)
Hotstring(":?:jn",,0)
Hotstring(":?:lor",,0)
Hotstring(":?:and",,0)

Hotstring(":X?:ww",,0)
Hotstring(":?:rr","3",1)
Hotstring(":?:binoo",,0)
Hotstring(":?:binob",,0)
Hotstring(":?:tt",,0)
Hotstring(":?:nn",,0)
Hotstring(":?:n ",,0)
Hotstring(":?:w ",,0)
Hotstring(":?:r ",,0)
Hotstring(":?:x ",,0)
Hotstring(":?:y ",,0)
Hotstring(":?:t ",,0)
Hotstring(":?:i ",,0)
Hotstring(":?:dn",,0)
Hotstring(":?:up",,0)
Hotstring(":?:j ",,0)
Hotstring(":?:o ",,0)
Hotstring(":?:e ",,0)

Hotstring(":?:p ",,0)

Hotstring(":?:limm",,0)
Hotstring(":?:inn",,0)
Hotstring(":?:kk",,0)
Hotstring(":?:coo",,0)
Hotstring(":?:k ",,0)
Hotstring(":?:y ",,0)
Hotstring(":?:eta",,0)
Hotstring(":?:ksi",,0)
Hotstring(":?:imp",,0)
Hotstring(":?:wer",,0)
Hotstring(":?:deg",,0)
Hotstring(":?:pii",,0)
Hotstring(":?:chi",,0)
Hotstring(":?:iot",,0)
Hotstring(":?:iff",,0)
Hotstring(":?:yy",,0)
Hotstring(":?:j",,0)
Hotstring(":?:nii",,0)
Hotstring(":?C:Res",,0)

Hotstring(":?:aryb",,0)
Hotstring(":?:dd",,0)
Hotstring(":?:inf",,0)
Hotstring(":?:nf",,0)
Hotstring(":?:rt",,0)

Hotstring(":?:lab",,0)
Hotstring(":?:ref",,0)

Hotstring(":?:muu",,0)
Hotstring(":?:rmb",,0)
Hotstring(":?:rmm",,0)
Hotstring(":?:nuu",,0)
Hotstring(":?:ik",,0)
Hotstring(":*?R:exs","\exists  ",0)
hotstring(":*RB0:ii",,0)
hotstring(":*RB0:iin",,0)
Hotstring(":?:ol",,0)
Hotstring(":?:muh",,0)
Hotstring(":?*:det","\det(){left 1}",0)
Hotstring(":?C:eu",,0)
Hotstring(":?*R:neg","^\neg ",0)
Hotstring(":?:mbb",,0)
Hotstring(":?:sigh",,0)
Hotstring(":?:mm",,0)
Hotstring(":?:m ",,0)
Hotstring(":?:gee",,0)
Hotstring(":?:lee",,0)
Hotstring(":?:sm",,0)
Hotstring(":*?:noth",,0)
Hotstring(":?C:bg",,0)

Hotstring(":?:theb",,0)
Hotstring(":?*:hn",":",1)
Hotstring(":?*R:sdf","\underline",0)
Hotstring(":?:arg",,0)
Hotstring(":?:fx",,0)
Hotstring(":?:gx",,0)
Hotstring(":?:hx",,0)
Hotstring(":?:proo",,0)

Hotstring(":?*RC0:z ","\Z",0)
Hotstring(":?*RC0:q ","\Q",0)
Hotstring(":?:i",,0)
Hotstring(":R?:u ","_u",0)
Hotstring(":R?:v ","_v",0)
Hotstring(":?:cap",,0)
Hotstring(":?:cnp",,0)
Hotstring(":?:55",,0)
Hotstring(":?:99",,0)
Hotstring(":?:88",,0)
Hotstring(":*?R:uit","^{-T}",0)
Hotstring(":?*:del",,0)
Hotstring(":*?C:lar","\large ",0)
Hotstring(":*?C:Lar","\Large ",0)
Hotstring(":?:77",,0)
Hotstring(":?:fc",,0)
Hotstring(":*:rr",,0)
Hotstring(":?:rho",,0)
Hotstring(":?:prob",,0)


Hotstring(":?*:rf","""""{left 1}",1)
Hotstring(":?:ang",,0)

Hotstring(":?:66",,0)
Hotstring(":*?R:ut","^{T}",0)

Hotstring(":?:css",,0)
Hotstring(":?:oou",,1)
Hotstring(":?:uou",,1)
Hotstring(":?:uuo",,1)
Hotkey ,!i,Off
Hotkey ,!l,Off
Hotkey ,!e,bb,On

Hotkey,*$p,on
;Hotkey,"8",On
Hotkey,!u,lefts,On
Hotkey,!o,rights,On
Hotkey ,!p,Off

Hotkey,IfWinActive,Ahk_group math
Hotstring(":*?:ard","\Downarrow ",0)
Hotstring(":*?:l ","_l",0)
Hotstring(":*?:veb",,0)
Hotstring(":?:nee",,0)
;Hotstring(":B0*?:ve",,0)
Hotstring(":*?:aru","\Uparrow ",0)
Hotstring(":*?X:sto","label10",1)
Hotstring(":*?:uu",,0)
Hotstring(":*?:ke",,0)
Hotstring(":?C*:ee",,0)
Hotstring(":*?X:too","label8",1)
Hotstring(":*?R:yel","{\color{yellow}}",0)
Hotstring(":*?R:gre","{\color{green}}",0)
Hotstring(":*?R:red","{\color{red}}",0)
Hotstring(":*?:sin",,0)
Hotstring(":*?:tan",,0)
Hotstring(":*?:str",,0)
Hotstring(":*?:cos",,0)
Hotstring(":*?R:blu","{\color{blu}}",0)
Hotstring(":*?R:pur","{\color{purple}}",0)
Hotstring(":*?X:foo","label7",1)
Hotstring(":*?R:alm","\ \ \mathrm{a.s.}",0)
Hotstring(":*?X:sfo","label9",1)
;Hotstring(":*:qd",,0)
Hotstring(":*?:the","\theta ",0)
Hotstring(":*?CX:res","label6",1)
Hotstring(":*?CX:les","label5",1)
Hotstring(":*?:  ","\ ",0)
Hotstring(":*?:fv",":",0)


Hotkey,IfWinActive
return  
label10:
asc(" :arrow_right_hook: ")
return
label8:
asc(":arrow_right:")
return
label9:
asc(" :leftwards_arrow_with_hook: ")
return
label7:
asc(":arrow_left:")
return
label6:
asc("$\large\restriction$")
return
label5:
asc("$\large\upharpoonleft$")
return

aa:
Hotstring("Reset")
Sendinput,;
return
bb:
Hotstring("Reset")
SendInput {=}
return

math:
Hotkey ,!e,bb,On
Hotkey ,!l,On
Hotkey ,!p,On
Hotkey ,!i,On

Hotkey,*$p,off
Hotkey,!u,bigpl,On
Hotkey,!o,bigpr,On
global mathh:=1
global trace:= WinExist("A")
Hotstring(":*Z0B0X?:oo","oyb",1)
Hotstring(":*Z0B0X?O:ss","iyb",1)
Hotstring(":*?B0:oso",,1)
Hotstring(":*?B0:sso",,1)
Hotstring(":*?B0:oos",,1)
Hotstring(":*?B0:sos",,1)
Hotstring(":?*R:neg","^\neg ",1)
Hotstring(":?:coo",,1)
Hotstring(":?:rmb",,1)
Hotstring(":?:css",,1)
Hotstring(":?:rmm",,1)
Hotstring(":*R?:u ","_u",1)
Hotstring(":*R?:v ","_v",1)
Hotstring(":?:ang",,1)
Hotstring(":?:55",,1)
Hotstring(":*?R:exs","\exists  ",1)
Hotstring(":?:99",,1)
Hotstring(":?:88",,1)

Hotstring(":?:77",,1)
Hotstring(":?:minn",,1) 
Hotstring(":?:minn",,1)
Hotstring(":?:minb",,1)
Hotstring(":?*:rf","’",1)
Hotstring(":?:mind",,1)
Hotstring(":?:fx",,1)
Hotstring(":?:gx",,1)
Hotstring(":?:hx",,1)
Hotstring(":?:cal",,1)
Hotstring(":?:ff",,0)
Hotstring(":*?:noth",,1)
Hotstring(":?:w",,1)
Hotstring(":?:66",,1)
Hotstring(":?:e",,1)
Hotstring(":?:r",,1)
Hotstring(":?:t",,1)
Hotstring(":?:o",,1)
Hotstring(":?:kr",,1)
Hotstring(":?:kw",,1)
Hotstring(":?:msta",,1)
Hotstring(":?:jm",,1)
Hotstring(":?:jn",,1)
Hotstring(":?:lor",,1)
Hotstring(":?:and",,1)

Hotstring(":?:kk",,1)
Hotstring(":?X:ww","lllll",1)
Hotstring(":?:rr","{^}3",1)

Hotstring(":?:tt",,1)
Hotstring(":?:nn",,1)
Hotstring(":?:w ",,1)
Hotstring(":?:r ",,1)
Hotstring(":?*RC0:z ","\Z ",1)
Hotstring(":?*RC0:q ","\Q ",1)
Hotstring(":?:i ",,1)
Hotstring(":?:x ",,1)
Hotstring(":?:y ",,1)
Hotstring(":?:fz",,1)
Hotstring(":?:gz",,1)
Hotstring(":?:muu",,1)
Hotstring(":?:nuu",,1)
Hotstring(":?:muh",,1)

Hotstring(":?:dn",,1)
Hotstring(":*?R:ut","^{T}",1)
Hotstring(":*?R:uit","^{-T}",1)
Hotstring(":?:t ",,1)
Hotstring(":?:up",,1)
Hotstring(":?:j ",,1)
Hotstring(":?:o ",,1)
Hotstring(":?:e ",,1)
Hotstring(":?:p ",,1)

Hotstring(":?:n ",,1)
Hotstring(":?:fc",,1)
Hotstring(":?:limm",,1)
Hotstring(":?:inn",,1)
Hotstring(":?:k ",,1)
Hotstring(":?:y ",,1)
Hotstring(":?:eta",,1)
Hotstring(":?:ksi",,1)
Hotstring(":?:imp",,1)
Hotstring(":?:wer",,1)
Hotstring(":?*R:sdf","\underline",1)
Hotstring(":?*:det","\det(){left 1}",1)
Hotstring(":?:deg",,1)
Hotstring(":?:pii",,1)
Hotstring(":?:proo",,1)

Hotstring(":?:chi",,1)
Hotstring(":?:iot",,1)
Hotstring(":?:iff",,1)
Hotstring(":?:yy",,0)
Hotstring(":?:j",,1)
Hotstring(":?C:Res",,1)
Hotstring(":?:nii",,1)
Hotstring(":?:aryb",,1)
Hotstring(":?:dd","_",1)
Hotstring(":?:inf",,1)
Hotstring(":?:nf",,1)
Hotstring(":?:rt",,1)

Hotstring(":?:lab",,1)
Hotstring(":?:ref",,1)
Hotstring(":*?C:lar","\large ",1)
Hotstring(":*?C:Lar","\Large ",1)
Hotstring(":?:cap",,1)
Hotstring(":?:cnp",,1)
Hotstring(":?:mbb",,1)
Hotstring(":?:sigh",,1)
Hotstring(":?:mm",,1)
Hotstring(":?:sm",,1)
Hotstring(":?C:bg",,1)
Hotstring(":?:m ",,1)
Hotstring(":?:gee",,1)
Hotstring(":?:lee",,1)

Hotstring(":?:rpp",,1)
Hotstring(":?:ipp",,1)

Hotstring(":?:theb",,1)
Hotstring(":?C:eu",,1)
Hotstring(":*?:hn","\setminus ",1)
Hotstring(":?:arg",,1)
Hotstring(":?:binoo",,1)
Hotstring(":?:binob",,1)
Hotstring(":?:ik",,1)
Hotstring(":?:ol",,1)
Hotstring(":?:rho",,1)
Hotstring(":?:prob",,1)
Hotstring(":?:i",,1)



Hotstring(":?*:del",,1)




Hotstring(":?:i ",,1)
Hotstring(":?:j ",,1)
Hotstring(":*:lj",,1)
Hotstring(":*?B0:oou",,0)
Hotstring(":*?B0:uou",,0)
hotstring(":*RB0:ii",,1)
hotstring(":*RB0:iin",,1)
Hotstring(":*?B0:uuo",,0)
Hotkey,IfWinActive,Ahk_group math
Hotstring(":*?:veb",,1)
Hotstring(":?:nee",,1)
;Hotstring(":B0*?:ve",,1)
Hotstring(":*?:ard","\Downarrow ",1)
Hotstring(":*?:ke",,1)
Hotstring(":*?:aru","\Uparrow ",1)
Hotstring(":*?:fv",":",1)
Hotstring(":*?:  ","\ ",1)
Hotstring(":*?R:yel","{\color{yellow}}",1)
Hotstring(":*?X:sto",,0)
Hotstring(":*?X:sfo",,0)
Hotstring(":*?:sin",,1)
Hotstring(":*?:tan",,1)
Hotstring(":?C*:ee",,1)
Hotstring(":*?:str",,1)
Hotstring(":*?:cos",,1)
Hotstring(":*?R:blu","{\color{blu}}",1)
Hotstring(":*?R:pur","{\color{purple}}",1)
Hotstring(":*?R:gre","{\color{green}}",1)
Hotstring(":*?R:red","{\color{red}}",1)
Hotstring(":*?C:res","\restriction ",1)
Hotstring(":*?C:les","\upharpoonright ",1)
Hotstring(":*?:uu",,1)
Hotstring(":*?:too","\to ",1)
Hotstring(":*?:l ","_l",1)

;Hotstring(":*:qd",,1)
Hotstring(":*?R:alm","\ \ \mathrm{a.s.}",1)
Hotstring(":*?:the","\theta ",1)
Hotkey, IfWinActive
return

eat:

    Hotstring(":*:ff",,1)
    Hotstring(":*:kkj",,1)
     Hotstring(":*:lj",,1)
    Hotstring(":*:rr",,1)
    Hotstring(":*Z0B0X?O:uu","iya",1)
     Hotstring(":*Z0B0X?:oo","oya",1)
    Hotstring(":*?B0:oso",,0)
    Hotstring(":*?B0:sso",,0)
    Hotstring(":*?B0:oos",,0)
    Hotstring(":*?B0:sos",,0)
            Hotstring(":*?B0:uuo",,1)
    Hotstring(":*?B0:ouo",,1)
    Hotstring(":*?B0:oou",,1)
    Hotstring(":*?B0:uou",,1)

    return
    
    
shit:

    Hotstring(":*:ff",,0)
    Hotstring(":*:lj",,1)
    Hotstring(":*:kkj",,1)
    Hotstring(":*Z0XB0?O:uu","iya",0)
     Hotstring(":*Z0B0X?:oo","oya",0)
    Hotstring(":*Z0B0X?O:ss","iyb",0)
        Hotstring(":*?B0:uuo",,0)
    Hotstring(":*?B0:ouo",,0)
    Hotstring(":*?B0:oou",,0)
    Hotstring(":*?B0:uou",,0)

    return
    
    
iya:
if ((A_PriorHotkey=":?*RB:uu")or( A_PriorHotkey=":*?B0:oou")or( A_PriorHotkey=":*?B0:uou"))and((PriorKeys[3]="left")or(PriorKeys[3]="right")or(PriorKeys[3]="u")or(PriorKeys[3]="o")or(PriorKeys[3]="Backspace"))
{

SendInput,{left 2}
}
else
{
    
SendInput,{backspace 1}
SendInput,{left 2}
}
return
oya:
if (A_PriorHotkey=":*Z0B0X?:oo"or A_PriorHotkey=":*?B0:uuo"or A_PriorHotkey=":*?B0:ouo")and((PriorKeys[3]="left")or(PriorKeys[3]="right")or(PriorKeys[3]="u")or(PriorKeys[3]="o")or(PriorKeys[3]="Backspace"))
{
    SendInput,{BackSpace 1}
SendInput,{Right 2}
}else{
SendInput,{backspace 2}
SendInput,{Right 2}
}
return
oyb:
if (A_PriorHotkey=":*Z0B0X?:oo"or A_PriorHotkey=":*?B0:sso"or A_PriorHotkey=":*?B0:oso")and((PriorKeys[3]="left")or(PriorKeys[3]="right")or(PriorKeys[3]="s")or(PriorKeys[3]="o")or(PriorKeys[3]="Backspace"))
{
SendInput,{BackSpace 1}
SendInput,{Right 2}
}else{
SendInput,{backspace 2}
SendInput,{Right 2}
}
return
iyb:
if (A_PriorHotkey=":*Z0B0X?O:ss"or A_PriorHotkey=":*?B0:oos"or A_PriorHotkey=":*?B0:sos")and((PriorKeys[3]="left")or(PriorKeys[3]="right")or(PriorKeys[3]="s")or(PriorKeys[3]="o")or(PriorKeys[3]="Backspace"))

{
    
SendInput,{left 2}
}else{
SendInput,{backspace 1}
SendInput,{left 2}
}
return

{

;MsgBox,,,% A_PriorKey

return
#if 

:*R:ezz::\mathrm e^{z}
:*R:exx::\mathrm e^{x}
:*C:Res::\operatorname{{}Res{}}(){left 1}
:*:eta::\eta `
:*:ksi::\xi `
:*:imp::\implies `
:*?:nff::y{left 6}{^}{right 6} `
:*:wer::
sendinput,\overline `
return
:*:deg::\deg `
:*:iff::\iff `

:*:ang::\angle `
:*:dd::
SendInput,_
return
:*:xi ::\xi `
:*:chi::{{}\large\chi{}} `
:*:iot::\iota `
:*:yy::{^}5 

:R:j::{^}j

:*:nii::\ni `
:*:aryb::\array{{}{}}{left 1}
:*:lab::
SendInput,\label{{}{}}{left 1}
return
:*:ref::
SendInput,(\ref{{}{}}){left 2}
:*:jm::
asc("\")
return

:*:lor::\lor `
:*:pmm::\pm `
:*:and::\and `
:*:dn::
asc("_{}")
SendInput,{left}
return

:*:up::
asc("^{}")
sendinput {left 1}
return

:*:theb::\theta(){left 1}
:C*:eu::\mathrm e{^}{{}{}}{left 1}

:*:proo::\prod `
:*:prob::
SendRaw,\prod_{}^{}
SendInput,{left 4}
return
:*:rho::\rho `
:*:dim::\dim `
:*R:88::^8
:*R:99::^9
:*R:66::^6
:*R:77::^7
:*R:55::^5
:*R:binoo::\binom `
:*R:binob::\binom{}{}{Left 3}

:*:kk::{^}k
:*:nn::
sendinput,{^}n 
return
:*:matp::\pmatrix{{}{}}{left 1}
:*:matb::
SendRaw,\begin{bmatrix} \end{bmatrix}
SendInput,{left 14}
return
:*:matv::
SendRaw,\begin{vmatrix} \end{vmatrix}
SendInput,{left 14}
return
:*:ol::
sendinput,\\
Hotstring(":?:j",,0)
input,a,L2 V,,j
if (a="jv")
    sendinput,{bs 4}0,
else if(InStr(ErrorLevel,"Match"))
    sendinput,{bs 3}0,
Hotstring(":?:j",,1)
return
:*:ik::{Enter}\\{Enter}

;:*:doh::,
:R:e::
sendinput,\mathrm e
return
::o::0
::w::2 
::r::3
::t::4
::i::\mathrm i
return
}
labbel:
SendInput,2
return
lllll:
sendinput,{^}2
return
:*:msta::
sendinput,m{^}*{(}{)}{left 1}
:*R:coo::^c
:*R:lhd::\lhd `
:*R:rhd::\rhd `
return

#Hotstring ?C0O0Z0


:*RB0:ii::

SendInput,{BackSpace 2}
SendRaw,^i
return

:*RB0Z:iin::
SendInput,{BackSpace 3}
SendRaw,\in `
return



bigpl:
SendInput,\left `
return
bigpr:
SendInput,\right `
return
lefts:
SendInput,{shift down}{home}{shift up}^c
return
rights:
SendInput,{shift down}{End}{shift up}^c
return

hahaha:

#Include lib
#Include lib_init.ahk ;The beginning of all things

; language
#include ..\language\lang_func.ahk
#include ..\language\Simplified_Chinese.ahk
;  #include ..\language\Traditional_Chinese.ahk
;  #include ..\language\English.ahk
; /language

#include lib_keysFunction.ahk
#include lib_keysSet.ahk
;  #include lib_ahkExec.ahk
;  #include lib_scriptDemo.ahk
;  #include lib_fileMethods.ahk

#include lib_settings.ahk ;get the settings from capslock+settings.ini 
;#Include lib_clQ.ahk ;capslock+Q
;#Include lib_ydTrans.ahk  ;capslock+T translate
#Include lib_clTab.ahk 
#Include lib_functions.ahk ;public functions
#Include lib_bindWins.ahk ;capslock+` 1~8, windows bind
#Include lib_winJump.ahk
#Include lib_winTransparent.ahk
;#Include lib_mouseSpeed.ahk
;#Include lib_mathBoard.ahk
;#include lib_loadAnimation.ahk


;change dir
#include ..\userAHK
#include *i main.ahk

#MaxHotkeysPerInterval 500
#NoEnv
;  #WinActivateForce
Process Priority,,High

start:

;-----------------START-----------------
global ctrlZ, CapsLock2, v2,CapsLock,v1
*$8::
KeyWait,8,T 0.2
if (ErrorLevel=1)
    {
    KeyWait,8
    SendInput,^s    
    }else{
    SendInput,8
    }
    return

/*
*$v::
Hotstring("reset")
KeyWait,v,T 0.2
if (ErrorLevel=1)
{   
KeyWait,v,T 0.4
if (ErrorLevel=1)
{
    KeyWait,v
    return
    }else{
        KeyWait,v
    if  GetKeyState("Alt") 
         SendInput,{AltUp}
    else
        SendInput,{AltDown}{Tab}
        }
}
else
{  
    KeyWait,v
     if  GetKeyState("Alt") 
        SendInput,{AltDown}{Tab}
    else
        SendInput,v
}
return

*/
*$p::
v1:=1
Hotstring("reset")

KeyWait,p,T 1
aaaaa:=ErrorLevel
KeyWait,p
if (aaaaa=1&& A_ThisHotkey="*$p")
    {
    ;v2?v2:=0,v2:=1
    SendInput,V
    }else
    
    if (A_ThisHotkey="*$p")
        {
    sendinput,p
}else{
    
}

v1:=0
Return


#if  v2 or v1


1::
3::
4::
5::
6::
7::
2::

9::
0::
f1::
f2::
f3::
f4::
f5::
f6::
f7::
f8::
f9::
f10::
f11::
f12::
space::
tab::
enter::
esc::
backspace::
ralt::

try

    runFunc(keyset["caps_" . A_ThisHotkey])
     Hotstring("reset")
    gosub,zzz
     return
     
h::
SendInput,^!s
gosub,zzz
return
u::
SendInput,^!e
gosub,zzz
return
*j::
SendInput,{left 1}
   gosub,zzz
return
*o::
SendInput,{right 1} 
   gosub,zzz
return
*i::
SendInput,{Up 1}
   gosub,zzz
return
*k::
SendInput,{Down 1} 
   gosub,zzz
return
*e::
SendInput,{WheelUp 1}
   gosub,zzz
return
*d::
SendInput,{WheelDown 1} 
   gosub,zzz
return
*s::
SendInput,{ShiftDown}{Left}{ShiftUp}
   gosub,zzz
return
*f::
SendInput,{ShiftDown}{Right}{ShiftUp}
   gosub,zzz
return
*8::Esc

#If
Capslock::
;ctrlZ:     Capslock+Z undo / redo flag
;Capslock:  Capslock 键状态标记，按下是1，松开是0
;Capslock2: 是否使用过 Capslock+ 功能标记，使用过会清除这个变量
ctrlZ:=CapsLock2:=CapsLock:=1

SetTimer, setCapsLock2, -200 ; 300ms 犹豫操作时间

;settimer, changeMouseSpeed, 50 ;暂时修改鼠标速度

KeyWait, Capslock
CapsLock:="" ;Capslock最优先置空，来关闭 Capslock+ 功能的触发
if CapsLock2
{
    SetCapsLockState, % GetKeyState("CapsLock","T") ? "Off" : "On"
}
CapsLock2:=""

;
if(winTapedX!=-1)
{
    winsSort(winTapedX)
}

Return

setCapsLock2:
CapsLock2:=""
return
zzz:
if (v1=1)
{
v2:=0
}
return
    


OnClipboardChange:  ; 剪贴板内容改变时将运行

; 如果有复制操作时，capslock键没有按下，那就是系统原生复制
if (allowRunOnClipboardChange && !CapsLock && CLsets.global.allowClipboard != "0")
{
    clipSaver("s")
    whichClipboardNow:=0
}
allowRunOnClipboardChange:=true
return


;----------------------------keys-set-start-----------------------------
#if CLsets.global.allowClipboard != "0"
$^v::
try
    keyFunc_pasteSystem()
return
#if

#If CapsLock ;when capslock key press and hold

LAlt::return

<!WheelUp::
try
    runFunc(keyset.caps_lalt_wheelUp)
Capslock2:=""
return

<!WheelDown::
try
    runFunc(keyset.caps_lalt_wheelDown)
Capslock2:=""
return


;--::-------------------------
;  KEY_TO_NAME := {"a":"a","b":"b","c":"c","d":"d","e":"e","f":"f","g":"g","h":"h","i":"i"
;    ,"j":"j","k":"k","l":"l","m":"m","n":"n","o":"o","p":"p","q":"q","r":"r"
;    ,"s":"s","t":"t","u":"u","v":"v","w":"w","x":"x","y":"y","z":"z"
;    ,"1":"1","2":"2","3":"3","4":"4","5":"5","6":"6","7":"7","8":"8","9":"9","0":"0"
;    ,"f1":"f1","f2":"f2","f3":"f3","f4":"f4","f5":"f5","f6":"f6"
;    ,"f7":"f7","f8":"f8","f9":"f9","f10":"f10","f11":"f11","f12":"f12"
;    ,"f13":"f13","f14":"f14","f15":"f15","f16":"f16","f17":"f17","f18":"f18","f19":"f19"
;    ,"space":"space","tab":"tab","enter":"enter","esc":"esc","backspace":"backspace"
;    ,"`":"backQuote","-":"minus","=":"equal","[":"leftSquareBracket","]":"rightSquareBracket"
;    ,"\":"backSlash",";":"semicolon","'":"quote",",":"comma",".":"dot","/":"slash","ralt":"ralt"
;    ,"wheelUp":"wheelUp","wheelDown":"wheelDown"}

;  for k,v in KEY_TO_NAME{
;      msgbox, % v
;  }



d::
e::








o::
p::

r::







1::
2::
3::
4::
5::
6::
7::
8::
9::
0::
f1::
f2::
f3::
f4::
f5::
f6::
f7::
f8::
f9::
f10::
f11::
f12::
space::
tab::
enter::
esc::
backspace::
ralt::
Hotstring("Reset")
try
    
    runFunc(keyset["caps_" . A_ThisHotkey])
     Hotstring("reset")
Capslock2:=""

Return

`::
try
    runFunc(keyset.caps_backQuote)
Capslock2:=""
return


-::
try
    runFunc(keyset.caps_minus)
Capslock2:=""
return

=::
try
    runFunc(keyset.caps_equal)
Capslock2:=""
Return


[::
SendInput,^f
Return

w::
Sendinput,+^{left}{bs}
return

\::
try
    runFunc(keyset.caps_backslash)
Capslock2:=""
return

`;::
try
    runFunc(keyset.caps_semicolon)
Capslock2:=""
Return

'::
try
    runFunc(keyset.caps_quote)
Capslock2:=""
return


,::
try
    runFunc(keyset.caps_comma)
Capslock2:=""
Return

.::
try
    runFunc(keyset.caps_dot)
Capslock2:=""
return

/::
try
    runFunc(keyset.caps_slash)
Capslock2:=""
Return
t::
Hotstring("Reset")
sendinput,^M
SetCapsLockState, Off
gosub, math
If (IME_GET()=1){
    sendinput,{shift}
    }else{
    }
return
 
x::
Hotstring("Reset")
sendinput,^x
return
v::
Hotstring("Reset")
SendInput,^v
return
a::
Hotstring("Reset")
sendinput,{Home}{Shift down}{End}{Shift up}
sendinput,^c

return
s::
Hotstring("Reset")
sendinput,^{left}
return
f::
Hotstring("Reset")
sendinput,^{Right}
return
b::
Hotstring("Reset")
sendinput,^b
return
c::
Hotstring("Reset")
sendinput,^c
return
g::
Hotstring("Reset")
sendinput,^a
return
q::
Hotstring("Reset")
sendinput,^z
return
z::
Hotstring("Reset")
sendinput,^d
return
y::
Hotstring("Reset")
sendinput,^y
return
n::
Hotstring("Reset")
SendInput,^n
return
h::
Hotstring("Reset")
asc("{")
return
k::
Hotstring("Reset")
asc("}")
return
j::
Hotstring("Reset")
SendInput,(
return
l::
Hotstring("Reset")
SendInput,)
return  
i::
Hotstring("Reset")
asc(" $$ ")
SendInput,{left 2}
return
u::
Hotstring("Reset")
Sendinput,\{{}\{}}{left 2}
return
;---------------------caps+lalt----------------

<!a::^a
return

<!b::
try
    runFunc(keyset.caps_lalt_b)
Capslock2:=""
Return

<!c::
try
    runFunc(keyset.caps_lalt_c)
Capslock2:=""
return

<!d::
try
    runFunc(keyset.caps_lalt_d)
Capslock2:=""
Return


<!l::
try
    runFunc(keyset.caps_lalt_l)
Capslock2:=""
return

+s::
SendInput,+{left}
return
+f::
SendInput,+{right}
return
+e::
SendInput,+{up}
return
+d::
sendinput,+{down}
return

;try
 ;   runFunc(keyset.caps_lalt_e)
;Capslock2:=""
;Return
/*<!e::
;try
 ;   runFunc(keyset.caps_lalt_e)
 
;Capslock2:=""
;Return

<!f::
try
    runFunc(keyset.caps_lalt_f)
Capslock2:=""
Return

<!g::
try
    runFunc(keyset.caps_lalt_g)
Capslock2:=""
Return

<!h::
try
    runFunc(keyset.caps_lalt_h)
Capslock2:=""
return

<!i::
try
    runFunc(keyset.caps_lalt_i)
Capslock2:=""
return

<!m::
try
    runFunc(keyset.caps_lalt_m)
Capslock2:=""
return

<!n::
try
    runFunc(keyset.caps_lalt_n)
Capslock2:=""
Return

<!o::
try
    runFunc(keyset.caps_lalt_o)
Capslock2:=""
return

<!p::
try
    runFunc(keyset.caps_lalt_p)
Capslock2:=""
Return

;<!q::
;try
 ;   runFunc(keyset.caps_lalt_q)
;Capslock2:=""
;return
/*
<!r::
try
    runFunc(keyset.caps_lalt_r)
Capslock2:=""
Return

<!s::
try
    runFunc(keyset.caps_lalt_s)
Capslock2:=""
Return

<!t::
try
    runFunc(keyset.caps_lalt_t)
Capslock2:=""
Return

<!u::
try
    runFunc(keyset.caps_lalt_u)
Capslock2:=""
return

<!v::
try
    runFunc(keyset.caps_lalt_v)
Capslock2:=""
Return

<!w::
try
    runFunc(keyset.caps_lalt_w)
Capslock2:=""
Return

<!x::
try
    runFunc(keyset.caps_lalt_x)
Capslock2:=""
Return

<!y::
try
    runFunc(keyset.caps_lalt_y)
Capslock2:=""
return

<!z::
try
    runFunc(keyset.caps_lalt_z)
Capslock2:=""
Return


<!`::
    runFunc(keyset.caps_lalt_backquote)
Capslock2:=""
return

<!1::
try
    runFunc(keyset.caps_lalt_1)
Capslock2:=""
return

<!2::
try
    runFunc(keyset.caps_lalt_2)
Capslock2:=""
return

<!3::
try
    runFunc(keyset.caps_lalt_3)
Capslock2:=""
return

<!4::
try
    runFunc(keyset.caps_lalt_4)
Capslock2:=""
return

<!5::
try
    runFunc(keyset.caps_lalt_5)
Capslock2:=""
return

<!6::
try
    runFunc(keyset.caps_lalt_6)
Capslock2:=""
return

<!7::
try
    runFunc(keyset.caps_lalt_7)
Capslock2:=""
return

<!8::
try
    runFunc(keyset.caps_lalt_8)
Capslock2:=""
return

<!9::
try
    runFunc(keyset.caps_lalt_9)
Capslock2:=""
Return

<!0::
try
    runFunc(keyset.caps_lalt_0)
Capslock2:=""
Return
<!F3::
try
    runFunc(keyset.caps_lalt_f3)
Capslock2:=""
return

<!F4::
try
    runFunc(keyset.caps_lalt_f4)
Capslock2:=""
return

<!F5::
try
    runFunc(keyset.caps_lalt_f5)
Capslock2:=""
return
/*
<!-::
try
    runFunc(keyset.caps_lalt_minus)
Capslock2:=""
return

<!=::
try
    runFunc(keyset.caps_lalt_equal)
Capslock2:=""
Return

<!BackSpace::
try
    runFunc(keyset.caps_lalt_backspace)
Capslock2:=""
Return

<!Tab::
try
    runFunc(keyset.caps_lalt_tab)
Capslock2:=""
Return

<![::
try
    runFunc(keyset.caps_lalt_leftSquareBracket)
Capslock2:=""
Return

<!]::
try
    runFunc(keyset.caps_lalt_rightSquareBracket)
Capslock2:=""
Return

<!\::
try
    runFunc(keyset.caps_lalt_Backslash)
Capslock2:=""
return

<!`;::
try
    runFunc(keyset.caps_lalt_semicolon)
Capslock2:=""
Return

<!'::
try
    runFunc(keyset.caps_lalt_quote)
Capslock2:=""
return

<!Enter::
try
    runFunc(keyset.caps_lalt_enter)
Capslock2:=""
Return

<!,::
try
    runFunc(keyset.caps_lalt_comma)
Capslock2:=""
Return

<!.::
try
    runFunc(keyset.caps_lalt_dot)
Capslock2:=""
return

<!/::
try
    runFunc(keyset.caps_lalt_slash)
Capslock2:=""
Return

<!Space::
try
    runFunc(keyset.caps_lalt_space)
Capslock2:=""
Return

<!RAlt::
try
    runFunc(keyset.caps_lalt_ralt)
Capslock2:=""
return

<!F1::
try
    runFunc(keyset.caps_lalt_f1)
Capslock2:=""
return

<!F2::
try
    runFunc(keyset.caps_lalt_f2)
Capslock2:=""
return



<!F6::
try
    runFunc(keyset.caps_lalt_f6)
Capslock2:=""
return

<!F7::
try
    runFunc(keyset.caps_lalt_f7)
Capslock2:=""
return

<!F8::
try
    runFunc(keyset.caps_lalt_f8)
Capslock2:=""
return

<!F9::
try
    runFunc(keyset.caps_lalt_f9)
Capslock2:=""
return

<!F10::
try
    runFunc(keyset.caps_lalt_f10)
Capslock2:=""
return

<!F11::
try
    runFunc(keyset.caps_lalt_f11)
Capslock2:=""
return

<!F12::
try
    runFunc(keyset.caps_lalt_f12)
Capslock2:=""
return
*/

;  #s::
;      keyFunc_activateSideWin("l")
;  Capslock2:=""
;  return

;  #f::
;      keyFunc_activateSideWin("r")
;      Capslock2:=""
;  return

;  #e::
;      keyFunc_activateSideWin("u")
;  Capslock2:=""
;  return

;  #d::
;      keyFunc_activateSideWin("d")
;      Capslock2:=""
;  return

;  #w::
;      keyFunc_putWinToBottom()
;      Capslock2:=""
;  return

;  #a::
;      keyFunc_activateSideWin("fl")
;      Capslock2:=""
;  return

;  #g::
;      keyFunc_activateSideWin("fr")
;      Capslock2:=""
;  return

;  #z::
;      keyFunc_clearWinMinimizeStach()
;      CapsLock2:=""
;  return

;  #x::
;      keyFunc_inWinMinimizeStack(true)
;      Capslock2:=""
;  return

;  #c::
;      keyFunc_inWinMinimizeStack()
;      Capslock2:=""
;  return

;  #v::
;      keyFunc_outWinMinimizeStack()
;      Capslock2:=""
;  return



#If




GuiClose:
GuiEscape:
Gui, Cancel