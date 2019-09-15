--------------------------------------------------------------------------------
-- | Example.hs
--
-- Example configuration file for xmonad using the latest recommended
-- features (e.g., 'desktopConfig').
module Main (main) where

--------------------------------------------------------------------------------
import System.Exit
import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Layout.BinarySpacePartition (emptyBSP)
import XMonad.Layout.NoBorders (noBorders, lessBorders, Ambiguity(..))
import XMonad.Layout.ResizableTile (ResizableTall(..))
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Shell
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.EwmhDesktops
import qualified XMonad.StackSet as W

--------------------------------------------------------------------------------
main = do
  xmproc <- spawnPipe "xmobar /home/drd/.xmobarrc" -- Start a task bar such as xmobar. (REMEMBER TO PUT YOUR USERNAME IN)
  -- Start xmonad using the main desktop configuration with a few
  -- simple overrides:
  xmonad $ desktopConfig
    { modMask    = mod4Mask -- Use the "Win" key for the mod key
    , workspaces = ["1", "2", "3", "4", "5" ,"6", "7", "8", "9", "0", "Mail"]
    , manageHook = myManageHook <+> manageHook desktopConfig
    , layoutHook = lessBorders OnlyScreenFloat $ desktopLayoutModifiers $ myLayouts
    , logHook    = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppCurrent = xmobarColor "yellow" "" . wrap "[" "]"
                        , ppHidden = xmobarColor "grey" ""
                        , ppTitle   = xmobarColor "green"  "" . shorten 40
                        , ppUrgent  = xmobarColor "red" "yellow"
                        }
    , startupHook = do
        --spawn "stalonetray" -- Tray to complete xmobar (for some reason it doesn't show icons when restarted)
        spawn "feh --randomize --bg-scale $HOME/.wallpaper/*" -- Set wallpaper
    , terminal   = "urxvt"
    }

    `additionalKeysP` -- Add some extra key bindings:
      [ ("M-S-q",   spawn "$HOME/.scripts/dmenu-shutdown.sh")
      , ("M-S-l",   confirmPrompt myXPConfig "logout?" (io exitSuccess))
      , ("M-p",     spawn "QT_QPA_PLATFORMTHEME=gtk2 dmenu_run -fn 'Monospace-10:antialias=false' -sb '#AB4642'")
      , ("M-<Esc>", sendMessage (Toggle "Full"))
      , ("M-S-<Esc>", sendMessage ToggleStruts)
      , ("M-b", spawn "chromium") -- would like to use firefox 68 but video playback stutters
      , ("M-e", spawn "urxvt -e ranger")
      , ("M-c", spawn "emacs")
      , ("M-C-c", spawn "emacsclient -nc") -- for debugging purposes, i have to fix my init.el for GUI
      , ("M-s", spawn "sleep 0.2 ; scrot -s /tmp/screen.png") -- sleep solves a race condition
      ]

    -- IMPORTANT
    -- The fn keys have different keybindings for each computer, so substitute them to make them work with your own
    `additionalKeys` -- fn keys
      [ ( (0, 0x1008ff11), spawn "amixer -q sset Master 5%- && ~/.scripts/notify-volume.sh") -- increase volume
      , ( (0, 0x1008ff13), spawn "amixer -q sset Master 5%+ && ~/.scripts/notify-volume.sh") -- increase volume
      , ( (0, 0x1008ff12), spawn "amixer -q sset Master toggle && ~/.scripts/notify-volume.sh") -- (un)mute volume
      , ( (0, 0x1008ff03), spawn "xbacklight -dec 5 && ~/.scripts/notify-brightness.sh") -- decrease brightness
      , ( (0, 0x1008ff02), spawn "xbacklight -inc 5 && ~/.scripts/notify-brightness.sh") -- increase brightness
      , ( (0, 0x1008ff14), spawn "~/.scripts/mpc_toggle_cantata.sh") -- play music
      , ( (0, 0x1008ff16), spawn "~/.scripts/mpc_prev_cantata.sh") -- previous track
      , ( (0, 0x1008ff17), spawn "~/.scripts/mpc_next_cantata.sh") -- next track
      , ( (mod4Mask, xK_m ), windows $ W.greedyView "Mail") -- M-m goes to workspace "Mail"
      , ( (shiftMask .|. mod4Mask, xK_m), windows $ W.shift "Mail") -- M-S-m moves window to workspace "Mail"
      ]

--------------------------------------------------------------------------------
-- | Customize layouts.
--
-- This layout configuration uses two primary layouts, 'ResizableTall'
-- and 'BinarySpacePartition'.  You can also use the 'M-<Esc>' key
-- binding defined above to toggle between the current layout and a
-- full screen layout.
myLayouts = toggleLayouts (noBorders Full) others
  where
    others = ResizableTall 1 (1.5/100) (3/5) [] ||| emptyBSP

--------------------------------------------------------------------------------
-- | Customize the way 'XMonad.Prompt' looks and behaves.  It's a
-- great replacement for dzen.
myXPConfig = def
  { position          = Top
  , alwaysHighlight   = True
  , promptBorderWidth = 0
  , font              = "xft:monospace:size=9"
  }

--------------------------------------------------------------------------------
-- | Manipulate windows as they are created.  The list given to
-- @composeOne@ is processed from top to bottom.  The first matching
-- rule wins.
--
-- Use the `xprop' tool to get the info you need for these matches.
-- For className, use the second value that xprop gives you.
myManageHook = composeOne
  [ className =? "Pidgin"      -?> doFloat
  , className =? "XCalc"       -?> doFloat
  , className =? "mpv"         -?> doFloat
  , className =? "keepassxc"   -?> doFloat
  , className =? "Thunderbird" -?> doShift "Mail"
  , isDialog                   -?> doCenterFloat
  , isFullscreen               -?> doFullFloat
    -- Move transient windows to their parent:
  , transience
  ]
