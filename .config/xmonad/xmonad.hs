import XMonad
import XMonad.Util.EZConfig

-- Changing default terminal emulator
myTerminal = "alacritty"
-- Setting Mod Key from Alt to Super
myModMask = mod4Mask
-- Window borders width
myBorderWidth = 0

main :: IO ()
main = xmonad def {
	terminal = myTerminal,
	modMask = myModMask,
	borderWidth = myBorderWidth
}
