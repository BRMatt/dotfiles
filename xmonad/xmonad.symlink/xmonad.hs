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
import XMonad.Hooks.SetWMName
import XMonad.Layout.ThreeColumns
import XMonad.Layout
import Graphics.X11.ExtraTypes.XF86


-- Idea stolen from https://github.com/league/dot-files/blob/master/xmonad.hs
-- From what I understand this defines a data type, and when we use it below we
-- give it the type class "Show", which is used for getting string representations
-- of types. In this case the string representation is the command to run.
data AppClass = AudioLower
              | AudioMute
              | AudioRaise
              | TerminalApp
              | Suspend

instance Show AppClass where
  show AudioMute   = "amixer set Master toggle"
  show AudioRaise  = "amixer set Master 10%+"
  show AudioLower  = "amixer set Master 10%-"
  show TerminalApp = "/usr/bin/terminator"
  show Suspend     = "dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Suspend"

-- Alt key
myMod = mod1Mask

-- Enforce the same type signature as spawn
start :: MonadIO m => AppClass -> m ()
start = spawn . show

myKeys =
  [ ((myMod, xK_F2), runOrRaisePrompt defaultXPConfig)
  , ((0, xF86XK_AudioLowerVolume), start AudioLower)
  , ((0, xF86XK_AudioRaiseVolume), start AudioRaise)
  , ((0, xF86XK_AudioMute       ), start AudioMute)
  , ((myMod, xK_Pause),            start Suspend)
  ]

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
  , resource  =? "xmessage"       --> doFloat
  , className =? "Trayer"         --> doIgnore
  , isFullscreen --> (doF W.focusDown <+> doFullFloat)
  ]

main = xmonad =<< xmobar myConfig { layoutHook = myLayout }

myConfig = defaultConfig 
  { manageHook = myManageHook
  , startupHook = setWMName "LG3D"
  , logHook = setWMName "LG3D"
  , terminal   = show TerminalApp
  , workspaces = myWorkspaces
  , handleEventHook = XMonad.Hooks.EwmhDesktops.fullscreenEventHook
  , layoutHook      = smartBorders $ layoutHook defaultConfig
  }
  `additionalKeys` myKeys

