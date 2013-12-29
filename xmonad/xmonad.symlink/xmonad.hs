import XMonad
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Util.EZConfig(additionalKeysP)
import qualified XMonad.StackSet as W
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.DynamicLog
import XMonad.Layout.NoBorders
import XMonad.Layout.Fullscreen
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import XMonad.Layout.ThreeColumns
import XMonad.Layout

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


myWorkspaces = ["1:web", "2:dev", "3:music", "4", "5", "6", "7", "8", "9", "0", "-", "="]

myLayout = ThreeCol 1 (3/100) (1/2) ||| ThreeColMid 1 (3/100) (1/2) ||| tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


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
  , className =? "Trayer"         --> doIgnore
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

main = xmonad =<< xmobar myConfig { layoutHook = myLayout }

myConfig = defaultConfig 
  { manageHook = myManageHook
  , startupHook = setWMName "LG3D"
  , logHook = setWMName "LG3D"
  , terminal   = myTerminal
  , workspaces = myWorkspaces
  , handleEventHook = XMonad.Hooks.EwmhDesktops.fullscreenEventHook
  , layoutHook      = smartBorders $ layoutHook defaultConfig
  }
  `additionalKeysP`
  [ ("M-<F2>", runOrRaisePrompt defaultXPConfig)
  , ("M-S-q", spawn "gnome-session-quit") 
  ]

