import XMonad
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)

import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

myXmobarPP :: PP
myXmobarPP = def

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

myConfig = def
  {
    terminal = myTerminal
    ,modMask = myModMask
    ,layoutHook = myLayout
    ,borderWidth = myBorderWidth
    ,normalBorderColor  = myBorderColor
    ,focusedBorderColor = myFocusedBorderColor
  }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("Print", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "qutebrowser"               )
    ]

