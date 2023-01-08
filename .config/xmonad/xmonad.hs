import XMonad
import XMonad.Util.Ungrab
import XMonad.Util.EZConfig (additionalKeysP)

myTerminal = "alacritty"
myModMask = mod4Mask

main :: IO ()
main = xmonad $ def
    { modMask = myModMask
    , terminal = myTerminal
    }
