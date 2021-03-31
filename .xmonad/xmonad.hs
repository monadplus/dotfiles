import qualified Codec.Binary.UTF8.String as UTF8
import Control.Monad (liftM2)
import qualified DBus as D
import qualified DBus.Client as D
import qualified Data.ByteString as B
import qualified Data.Map as M
import Graphics.X11.ExtraTypes.XF86
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.FloatKeys (keysMoveWindow, keysResizeWindow)
import XMonad.Actions.SpawnOn
import XMonad.Config.Azerty
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FloatNext (floatNextHook, toggleFloatAllNew, toggleFloatNext)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (doCenterFloat, doFullFloat, isDialog, isFullscreen)
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.CenteredMaster (centerMaster)
import XMonad.Layout.Cross (simpleCross)
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.Gaps
import XMonad.Layout.IndependentScreens
import XMonad.Layout.Maximize (maximize, maximizeRestore)
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing
import XMonad.Layout.Spiral (spiral)
import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig (additionalKeys, additionalMouseBindings)
import XMonad.Util.Run (spawnPipe)

myStartupHook = do
  spawn "$HOME/.xmonad/scripts/autostart.sh"
  setWMName "LG3D"

normBord = "#46394E"

focdBord = "#896F9A"

--mod4Mask= super key
--mod1Mask= alt key
--controlMask= ctrl key
--shiftMask= shift key
myModMask = mod4Mask

encodeCChar = map fromIntegral . B.unpack

myBorderWidth = 2

--              edit       file      globe     file      envelope
myWorkspaces = ["\61508", "\61897", "\61612", "\61788", "\61664"]

myBaseConfig = desktopConfig

myLayout = maximize (ResizableTall 1 (3 / 100) (1 / 2) [] ||| Full)

myGaps =
  spacingRaw
    True -- smartBorder
    (Border 0 0 0 0) -- screenBorder
    False -- screenBorderEnabled
    (Border 4 4 4 4) -- windowBorder (Border top bottom right left)
    True -- windowBorderEnabled

myManageHook =
  composeAll . concat $
    [ [isDialog --> doCenterFloat],
      [className =? c --> doCenterFloat | c <- myCFloats],
      [title =? t --> doFloat | t <- myTFloats],
      [resource =? r --> doFloat | r <- myRFloats],
      [resource =? i --> doIgnore | i <- myIgnores],
      [ checkAll r --> doShiftAndGo workspace
        | (rs, workspace) <- zip myShifts myWorkspaces,
          r <- rs
      ]
    ]
  where
    checkAll str = className =? str <||> title =? str <||> resource =? str
    doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift
    -- Stuff
    myCFloats = ["Arandr", "Enpass", "vlc", "feh", "nomacs", "Image Lounge"]
    myTFloats = ["Downloads", "Save As..."]
    myRFloats = []
    myIgnores = ["desktop_window"]
    --shifts
    my1Shifts = []
    my2Shifts = []
    my3Shifts = ["Firefox", "Chromium-browser"]
    my4Shifts = ["Discord", "Slack", "zoom", "obs"]
    my5Shifts = ["Mail"] -- i.e. thunderbird
    myShifts = [my1Shifts, my2Shifts, my3Shifts, my4Shifts, my5Shifts]

myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    [ -- Floating Windows:
      -- M + Mouse Left: move
      -- M + shift + Mouse Left: resize
      -- M + Mouse Right: resize
      ((modMask, 1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)),
      ((modMask .|. mod1Mask, 1), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)),
      ((modMask, 3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)),
      -- M + Mouse Middle: raise the window to the top of the stack
      ((modMask, 2), (\w -> focus w >> windows W.shiftMaster))
    ]

myKeys conf@(XConfig {XMonad.modMask = modMask}) =
  M.fromList $
    [ ((modMask, xK_g), spawn $ "alacritty -e htop"),
      ((modMask .|. shiftMask, xK_g), spawn $ "alacritty -e gtop"),
      ((modMask, xK_v), spawn $ "pavucontrol"),
      ((modMask, xK_Return), spawn $ "alacritty"),
      ((modMask .|. shiftMask, xK_Return), spawn $ "thunar"),
      --((modMask .|. shiftMask, xK_Return), spawn $ "emacs"),
      ((modMask, xK_p), spawn $ "dmenu_run -i -nb '#191919' -nf '#fea63c' -sb '#fea63c' -sf '#191919' -fn 'Noto Sans:bold:pixelsize=14'"),
      ((controlMask .|. shiftMask, xK_v), spawn $ "clipmenu"),
      ((modMask, xK_r), spawn $ "polybar-msg cmd restart"),
      ((modMask .|. shiftMask, xK_r), spawn $ "xmonad --recompile && xmonad --restart"),
      ((modMask .|. shiftMask, xK_p), spawn $ "pamac-manager"),
      ((modMask, xK_c), spawn $ "conky-toggle"),
      -- dmscripts
      ((modMask, xK_o), spawn $ "bash $HOME/dotfiles/dmscripts/dmconf"),
      ((modMask .|. shiftMask, xK_o), spawn $ "bash $HOME/dotfiles/dmscripts/dmsearch"),
      ((modMask, xK_i), spawn $ "bash $HOME/dotfiles/dmscripts/dman"),
      -- Focus
      ((modMask, xK_j), windows W.focusDown),
      ((modMask, xK_k), windows W.focusUp),
      ((modMask, xK_h), windows W.focusDown),
      ((modMask, xK_l), windows W.focusUp),
      -- Shrink/Expand
      ((modMask .|. shiftMask, xK_h), sendMessage Shrink),
      ((modMask .|. shiftMask, xK_l), sendMessage Expand),
      ((modMask .|. shiftMask, xK_j), sendMessage MirrorShrink),
      ((modMask .|. shiftMask, xK_k), sendMessage MirrorExpand),
      -- Swap Windows
      ((modMask .|. controlMask, xK_h), windows W.swapDown),
      ((modMask .|. controlMask, xK_l), windows W.swapUp),
      ((modMask, xK_m), windows W.swapMaster),
      -- Increment the number of windows in the master area
      ((modMask, xK_comma), sendMessage (IncMasterN 1)),
      ((modMask, xK_period), sendMessage (IncMasterN (-1))),
      -- Whole screen & Toggle Spacing
      ((modMask, xK_b), spawn "polybar-msg cmd toggle" >> sendMessage ToggleStruts),
      ((modMask, xK_s), toggleWindowSpacingEnabled),
      -- Layout rotate & Layout reset.
      ((modMask, xK_space), sendMessage NextLayout),
      ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf),
      -- Windows back to tiling
      ((modMask, xK_t), withFocused $ windows . W.sink),
      -- Kill focused windows
      ((modMask, xK_q), kill),
      -- Floating Window
      ((modMask, xK_f), withFocused (sendMessage . maximizeRestore)),
      -- It seems they have no effect..
      --((modMask, xK_e), toggleFloatNext),
      --((modMask .|. shiftMask, xK_e), toggleFloatAllNew),
      ((modMask, xK_equal), withFocused (keysMoveWindow (-1, -30))),
      ((modMask, xK_apostrophe), withFocused (keysMoveWindow (-1, 30))),
      ((modMask, xK_bracketright), withFocused (keysMoveWindow (30, 0))),
      ((modMask, xK_bracketleft), withFocused (keysMoveWindow (-30, 0))),
      -- ((controlMask .|. shiftMask, xK_m), withFocused $ keysResizeWindow (0, -15) (0, 0)),
      -- ((controlMask .|. shiftMask, xK_comma), withFocused $ keysResizeWindow (0, 15) (0, 0)),
      -- Volume Control
      ((0, xF86XK_AudioMute), spawn $ "amixer -q set Master toggle"),
      ((0, xF86XK_AudioMicMute), spawn $ "amixer -q set Capture toggle"),
      ((0, xF86XK_AudioLowerVolume), spawn $ "amixer -q set Master 5%-"),
      ((0, xF86XK_AudioRaiseVolume), spawn $ "amixer -q set Master 5%+"),
      ((modMask, xK_a), spawn "playerctl play-pause --player=vlc"),
      ((modMask .|. shiftMask, xK_a), spawn "playerctl next --player=vlc"),
      -- Backlight Control
      ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl set +10%"),
      ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl set 10%-"),
      -- Session Lock
      ((modMask .|. shiftMask, xK_s), spawn "kill -9 -1"),
      -- TODO set screensaver daemon
      --((modMask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off"),
      -- Screenshots
      ((controlMask, xK_Print), spawn "sleep 0.2; maim -s --quality 10 ~/screenshots/$(date +'%Y-%b-%d-%s').png"),
      ((0, xK_Print), spawn "maim --quality 10 ~/screenshots/$(date +'%Y-%b-%d-%s').png")
    ]
      -- Workspaces
      ++ [ ((m .|. modMask, k), windows $ f i)
           | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_5],
             (f, m) <-
               [ (W.greedyView, 0),
                 (W.shift, shiftMask),
                 (\i -> W.greedyView i . W.shift i, shiftMask)
               ]
         ]

main :: IO ()
main = do
  dbus <- D.connectSession -- Request access to the DBus name
  D.requestName
    dbus
    (D.busName_ "org.xmonad.Log")
    [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  xmonad . ewmh $
    myBaseConfig
      { startupHook = myStartupHook,
        layoutHook = avoidStruts $ myGaps $ smartBorders $ myLayout,
        manageHook = manageSpawn <+> myManageHook <+> manageHook myBaseConfig,
        modMask = myModMask,
        borderWidth = myBorderWidth,
        handleEventHook = handleEventHook myBaseConfig <+> fullscreenEventHook,
        focusFollowsMouse = False,
        workspaces = myWorkspaces,
        focusedBorderColor = focdBord,
        normalBorderColor = normBord,
        keys = myKeys,
        mouseBindings = myMouseBindings
      }
