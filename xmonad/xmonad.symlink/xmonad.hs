import XMonad
import XMonad.Config.Gnome
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Util.Run(spawnPipe)

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
  [ manageHook gnomeConfig
  , className =? "Unity-2d-panel" --> doIgnore
  , className =? "Google-chrome"  --> doShift "1:web"
  , className =? "spotify"        --> doShift "3:music"
  , resource  =? "skype"          --> doFloat
  , resource  =? "xmobar"         --> doIgnore
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

main = xmonad =<< xmobar myConfig


myConfig = gnomeConfig { manageHook = myManageHook
  , workspaces = myWorkspaces
  }
  `additionalKeys`
  [ ((mod1Mask, xK_F2), runOrRaisePrompt defaultXPConfig)
  , ((0, 0x1008FF11), spawn "amixer sset Master 5%-")
  , ((0, 0x1008FF13), spawn "amixer sset Master 5%+")
  , ((0, 0x1008ff12), spawn "amixer -q set PCM toggle")
  ]

