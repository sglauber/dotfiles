import XMonad
import XMonad.Util.Ungrab
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.EZConfig (additionalKeysP)

import XMonad.Layout.Renamed
import XMonad.Layout.Magnifier
import XMonad.Layout.ThreeColumns

import XMonad.Hooks.StatusBar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.ManageHelpers 


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/.xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig
  where
    toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
    toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

-- Pretty printer
myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""


-- Changing default terminal emulator
myTerminal = "alacritty"

-- Rebinding Mod Key from Alt to Super
myModMask :: KeyMask
myModMask = mod4Mask

-- Window borders
myBorderWidth :: Dimension
myBorderWidth = 1

myBorderColor, myFocusedBorderColor :: String
myBorderColor  = "purple"
myFocusedBorderColor = "magenta"

-- Layouts

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = renamed [Replace "ThreeCol"] $ magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled   = Tall nmaster delta ratio
    nmaster = 1      -- Default number of windows in the master pane
    ratio   = 1/2    -- Default proportion of screen occupied by master pane
    delta   = 3/100  -- Percent of screen to increment by when resizing panes

myConfig = def
  {
    terminal = myTerminal
    ,modMask = myModMask
    ,layoutHook = myLayout
    ,manageHook = myManageHook
    ,borderWidth = myBorderWidth
    ,normalBorderColor  = myBorderColor
    ,focusedBorderColor = myFocusedBorderColor
  }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("Print", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "qutebrowser"               )
    ]

-- Hooks
myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog            --> doFloat
    ]
