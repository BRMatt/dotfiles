import XMonad
import XMonad.Config.Gnome
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Util.EZConfig(additionalKeys)

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat
  ])

main = xmonad $ gnomeConfig 
  { manageHook = myManageHook
  , workspaces = ["1:web", "2:dev", "3:music", "4:comm", "5", "6", "7", "8", "9", "0", "-", "="]
  }
  `additionalKeys`
  [ ((mod1Mask, xK_F2), runOrRaisePrompt defaultXPConfig)
  ]



