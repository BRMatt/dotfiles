import XMonad
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Hooks.EwmhDesktops

------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "/usr/bin/gnome-terminal"

------------------------------------------------------------------------
-- Status bar configuration
------------------------------------------------------------------------
myBar = "xmobar"

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)


myWorkspaces = ["1:web", "2:dev", "3:music", "4:comm", "5", "6", "7", "8", "9", "0", "-", "="]


------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing a
-- new window.
myManageHook = composeAll
  [ manageHook defaultConfig
  , className =? "Unity-2d-panel" --> doIgnore
  , className =? "Google-chrome"  --> doShift "1:web"
  , className =? "spotify"        --> doShift "3:music"
  , resource  =? "skype"          --> doFloat
  , resource  =? "xmobar"         --> doIgnore
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

main = xmonad =<< xmobar myConfig

myConfig = defaultConfig 
  { manageHook = myManageHook
  , terminal   = myTerminal
  , workspaces = myWorkspaces
  , handleEventHook = XMonad.Hooks.EwmhDesktops.fullscreenEventHook
  , layoutHook      = smartBorders $ layoutHook defaultConfig
  }
  `additionalKeys`
  [ ((mod1Mask, xK_F2), runOrRaisePrompt defaultXPConfig)
  , ((0, 0x1008FF11), spawn "amixer sset Master 5%-")
  , ((0, 0x1008FF13), spawn "amixer sset Master 5%+")
  , ((0, 0x1008ff12), spawn "amixer -q set PCM toggle")
  ]

