; 左右 Alt キーの空打ちで IME の OFF/ON を切り替える
;
; 左 Alt キーの空打ちで IME を「英数」に切り替え
; 右 Alt キーの空打ちで IME を「かな」に切り替え
; Alt キーを押している間に他のキーを打つと通常の Alt キーとして動作
;
; Author:     karakaram   http://www.karakaram.com/alt-ime-on-off

; Razer Synapseなど、キーカスタマイズ系のツールを併用しているときのエラー対策
#MaxHotkeysPerInterval 350

#Include IME.ahk
#Include Spacefn.ahk
;#Include vim.ahk

; 上部メニューがアクティブになるのを抑制
*~LAlt::Send {Blind}{vk07}
*~RAlt::Send {Blind}{vk07}

; 左Alt空打ちで IME を OFF
LAlt up::
   if (A_PriorHotkey == "*~LAlt") 
   {
       IME_SET(0)
   }
   Return

; 右Alt空打ちで IME を ON
RAlt up::
   if (A_PriorHotkey == "*~RAlt")
   {
       IME_SET(1)
   }
   Return

; Cursor, Mouse, Window move/size {{{
; Cursor {{{
!^h::Send, {Left}
!^j::Send, {Down}
!^k::Send, {Up}
!^l::Send, {Right}
; }}} Cursor

; Mouse {{{
; Mouse Move
^+h::MouseMove, -10, 0, 0, R
^+j::MouseMove, 0, 10, 0, R
^+k::MouseMove, 0, -10, 0, R
^+l::MouseMove, 10, 0, 0, R

; Click
^+n::MouseClick, Left
^+p::MouseClick, Right
; Right click on current window

; Mouse wheel
!^m::MouseClick, WheelDown, , , 2
!^,::MouseClick, WheelUp, , , 2
; }}} Mouse

; Window move {{{

; Move a little
^+y::
  WinGetPos, X, Y, , , A ;A for Active Window
  WinMove, A, ,X-20, Y,
Return

^+u::
  WinGetPos, X, Y, , , A
  WinMove, A, , X, Y+20
Return

^+i::
  WinGetPos, X, Y, , , A
  WinMove, A, , X, Y-20
Return

^+o::
  WinGetPos, X, Y, , , A
  WinMove, A, , X+20, Y
Return

; Move to a different screen
!^+y:: Send, #+{Left}
!^+u:: Send, #+{Down}
!^+i:: Send, #+{Up}
!^+o:: Send, #+{Right}

; }}} Window move

; Window size {{{

; Almost full
^!Enter::
!+Enter::
  ;WinGetPos, X, Y, W, H, Program Manager ; Full Desktop
  ;Msgbox, Pos At %X% %Y% %W% %H%
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  ;Msgbox, %MWALeft% %MWATop% %MWARight% %MWABottom%
  WinMove, A, , MWALeft+LMargin, MWATop+TMargin
    , MWARight-MWALeft-LMargin-RMargin
    , MWABottom-MWATop-TMargin-BMargin
Return

; Minsize
^!+Enter::
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  WinMove, A, , MWALeft+LMargin, MWATop+TMargin
    , (MWARight-MWALeft-LMargin-RMargin)*Minsize
    , (MWABottom-MWATop-TMargin-BMargin)*Minsize
Return

; Half size
!+h::
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  WinMove, A, , MWALeft+LMargin, MWATop+TMargin
    , (MWARight-MWALeft-LMargin-RMargin)*0.5
    , MWABottom-MWATop-TMargin-BMargin
Return

!+j::
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  WinMove, A, , MWALeft+LMargin
    , MWATop+(MWABottom-MWATop)*0.5
    , MWARight-MWALeft-LMargin-RMargin
    , (MWABottom-MWATop-TMargin-BMargin)*0.5
Return

!+k::
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  WinMove, A, , MWALeft+LMargin, MWATop+TMargin
    , MWARight-MWALeft-LMargin-RMargin
    , (MWABottom-MWATop-TMargin-BMargin)*0.5
Return

!+l::
  SysGet, MWA, MonitorWorkArea ; w/o Taskbar
  WinMove, A, , MWALeft+(MWARight-MWALeft)*0.5
    , MWATop+TMargin
    , (MWARight-MWALeft-LMargin-RMargin)*0.5
    , MWABottom-MWATop-TMargin-BMargin
Return

; Resize
!+y::
  WinGetPos, X, Y, W, H, A
  WinMove, A, ,X, Y, W-20, H
Return

!+u::
  WinGetPos, X, Y, W, H, A
  WinMove, A, ,X, Y, W, H+20
Return

!+i::
  WinGetPos, X, Y, W, H, A
  WinMove, A, ,X, Y, W, H-20
Return

!+o::
  WinGetPos, X, Y, W, H, A
  WinMove, A, ,X, Y, W+20, H
Return

; }}} Window size
; }}} Cursor, Mouse, Window move
