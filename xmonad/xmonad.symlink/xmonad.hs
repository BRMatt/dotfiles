import XMonad
import XMonad.Config.Gnome
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Util.EZConfig(additionalKeys)
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen


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
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

main = xmonad $ gnomeConfig
  { manageHook = myManageHook
  , workspaces = ["1:web", "2:dev", "3:music", "4:comm", "5", "6", "7", "8", "9", "0", "-", "="]
  }
  `additionalKeys`
  [ ((mod1Mask, xK_F2), runOrRaisePrompt defaultXPConfig)
  ]



