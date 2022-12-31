import XMonad
import XMonad.Util.Ungrab
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.SpawnOnce

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

-- Changing default terminal emulator
myTerminal = "alacritty"

-- Rebinding Mod Key from Alt to Super
myModMask :: KeyMask
myModMask = mod4Mask

-- Window borders
myBorderWidth :: Dimension
myBorderWidth = 1

myBorderColor, myFocusedBorderColor :: String
myBorderColor  = "gray"
myFocusedBorderColor = "purple"

-- Layouts

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 (ThreeColMid nmaster delta ratio)
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes

main :: IO ()
main = xmonad $ def {
  terminal = myTerminal,
  modMask = myModMask,
  layoutHook = myLayout,
  borderWidth = myBorderWidth,
  normalBorderColor  = myBorderColor,
  focusedBorderColor = myFocusedBorderColor
}`additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("Print", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "qutebrowser"               )
    ]

