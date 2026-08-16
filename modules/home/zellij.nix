_:

let
  action = name: args: {
    ${name} = if args == [ ] then { } else { _args = args; };
  };
  bind = keys: actions: {
    bind = {
      _args = keys;
      _children = actions;
    };
  };
  mode = name: bindings: {
    ${name}._children = bindings;
  };
  sharedExcept = modes: bindings: {
    shared_except = {
      _args = modes;
      _children = bindings;
    };
  };
in
{
  programs.zellij = {
    enable = true;
    settings = {
      keybinds._children = [
        (mode "locked" [
          (bind [ "Ctrl g" ] [ (action "SwitchToMode" [ "Normal" ]) ])
        ])
        (mode "resize" [
          (bind [ "Ctrl n" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [
              "h"
              "Left"
            ]
            [ (action "Resize" [ "Increase Left" ]) ]
          )
          (bind
            [
              "j"
              "Down"
            ]
            [ (action "Resize" [ "Increase Down" ]) ]
          )
          (bind
            [
              "k"
              "Up"
            ]
            [ (action "Resize" [ "Increase Up" ]) ]
          )
          (bind
            [
              "l"
              "Right"
            ]
            [ (action "Resize" [ "Increase Right" ]) ]
          )
          (bind [ "H" ] [ (action "Resize" [ "Decrease Left" ]) ])
          (bind [ "J" ] [ (action "Resize" [ "Decrease Down" ]) ])
          (bind [ "K" ] [ (action "Resize" [ "Decrease Up" ]) ])
          (bind [ "L" ] [ (action "Resize" [ "Decrease Right" ]) ])
          (bind
            [
              "="
              "+"
            ]
            [ (action "Resize" [ "Increase" ]) ]
          )
          (bind [ "-" ] [ (action "Resize" [ "Decrease" ]) ])
        ])
        (mode "pane" [
          (bind [ "Ctrl p" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [
              "h"
              "Left"
            ]
            [ (action "MoveFocus" [ "Left" ]) ]
          )
          (bind
            [
              "l"
              "Right"
            ]
            [ (action "MoveFocus" [ "Right" ]) ]
          )
          (bind
            [
              "j"
              "Down"
            ]
            [ (action "MoveFocus" [ "Down" ]) ]
          )
          (bind
            [
              "k"
              "Up"
            ]
            [ (action "MoveFocus" [ "Up" ]) ]
          )
          (bind [ "p" ] [ (action "SwitchFocus" [ ]) ])
          (bind
            [ "n" ]
            [
              (action "NewPane" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "d" ]
            [
              (action "NewPane" [ "Down" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "r" ]
            [
              (action "NewPane" [ "Right" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "x" ]
            [
              (action "CloseFocus" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "f" ]
            [
              (action "ToggleFocusFullscreen" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "z" ]
            [
              (action "TogglePaneFrames" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "w" ]
            [
              (action "ToggleFloatingPanes" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "e" ]
            [
              (action "TogglePaneEmbedOrFloating" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "c" ]
            [
              (action "SwitchToMode" [ "RenamePane" ])
              (action "PaneNameInput" [ 0 ])
            ]
          )
        ])
        (mode "move" [
          (bind [ "Ctrl h" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [
              "n"
              "Tab"
            ]
            [ (action "MovePane" [ ]) ]
          )
          (bind [ "p" ] [ (action "MovePaneBackwards" [ ]) ])
          (bind
            [
              "h"
              "Left"
            ]
            [ (action "MovePane" [ "Left" ]) ]
          )
          (bind
            [
              "j"
              "Down"
            ]
            [ (action "MovePane" [ "Down" ]) ]
          )
          (bind
            [
              "k"
              "Up"
            ]
            [ (action "MovePane" [ "Up" ]) ]
          )
          (bind
            [
              "l"
              "Right"
            ]
            [ (action "MovePane" [ "Right" ]) ]
          )
        ])
        (mode "tab" [
          (bind [ "Ctrl t" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [ "r" ]
            [
              (action "SwitchToMode" [ "RenameTab" ])
              (action "TabNameInput" [ 0 ])
            ]
          )
          (bind
            [
              "h"
              "Left"
              "Up"
              "k"
            ]
            [ (action "GoToPreviousTab" [ ]) ]
          )
          (bind
            [
              "l"
              "Right"
              "Down"
              "j"
            ]
            [ (action "GoToNextTab" [ ]) ]
          )
          (bind
            [ "n" ]
            [
              (action "NewTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "x" ]
            [
              (action "CloseTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "s" ]
            [
              (action "ToggleActiveSyncTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "1" ]
            [
              (action "GoToTab" [ 1 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "2" ]
            [
              (action "GoToTab" [ 2 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "3" ]
            [
              (action "GoToTab" [ 3 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "4" ]
            [
              (action "GoToTab" [ 4 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "5" ]
            [
              (action "GoToTab" [ 5 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "6" ]
            [
              (action "GoToTab" [ 6 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "7" ]
            [
              (action "GoToTab" [ 7 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "8" ]
            [
              (action "GoToTab" [ 8 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "9" ]
            [
              (action "GoToTab" [ 9 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind [ "Tab" ] [ (action "ToggleTab" [ ]) ])
        ])
        (mode "scroll" [
          (bind [ "Ctrl s" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [ "e" ]
            [
              (action "EditScrollback" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "s" ]
            [
              (action "SwitchToMode" [ "EnterSearch" ])
              (action "SearchInput" [ 0 ])
            ]
          )
          (bind
            [ "Ctrl c" ]
            [
              (action "ScrollToBottom" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [
              "j"
              "Down"
            ]
            [ (action "ScrollDown" [ ]) ]
          )
          (bind
            [
              "k"
              "Up"
            ]
            [ (action "ScrollUp" [ ]) ]
          )
          (bind
            [
              "Ctrl f"
              "PageDown"
              "Right"
              "l"
            ]
            [ (action "PageScrollDown" [ ]) ]
          )
          (bind
            [
              "Ctrl b"
              "PageUp"
              "Left"
              "h"
            ]
            [ (action "PageScrollUp" [ ]) ]
          )
          (bind [ "d" ] [ (action "HalfPageScrollDown" [ ]) ])
          (bind [ "u" ] [ (action "HalfPageScrollUp" [ ]) ])
        ])
        (mode "search" [
          (bind [ "Ctrl s" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [ "Ctrl c" ]
            [
              (action "ScrollToBottom" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [
              "j"
              "Down"
            ]
            [ (action "ScrollDown" [ ]) ]
          )
          (bind
            [
              "k"
              "Up"
            ]
            [ (action "ScrollUp" [ ]) ]
          )
          (bind
            [
              "Ctrl f"
              "PageDown"
              "Right"
              "l"
            ]
            [ (action "PageScrollDown" [ ]) ]
          )
          (bind
            [
              "Ctrl b"
              "PageUp"
              "Left"
              "h"
            ]
            [ (action "PageScrollUp" [ ]) ]
          )
          (bind [ "d" ] [ (action "HalfPageScrollDown" [ ]) ])
          (bind [ "u" ] [ (action "HalfPageScrollUp" [ ]) ])
          (bind [ "n" ] [ (action "Search" [ "down" ]) ])
          (bind [ "p" ] [ (action "Search" [ "up" ]) ])
          (bind [ "c" ] [ (action "SearchToggleOption" [ "CaseSensitivity" ]) ])
          (bind [ "w" ] [ (action "SearchToggleOption" [ "Wrap" ]) ])
          (bind [ "o" ] [ (action "SearchToggleOption" [ "WholeWord" ]) ])
        ])
        (mode "entersearch" [
          (bind
            [
              "Ctrl c"
              "Esc"
            ]
            [ (action "SwitchToMode" [ "Scroll" ]) ]
          )
          (bind [ "Enter" ] [ (action "SwitchToMode" [ "Search" ]) ])
        ])
        (mode "renametab" [
          (bind [ "Ctrl c" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [ "Esc" ]
            [
              (action "UndoRenameTab" [ ])
              (action "SwitchToMode" [ "Tab" ])
            ]
          )
        ])
        (mode "renamepane" [
          (bind [ "Ctrl c" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind
            [ "Esc" ]
            [
              (action "UndoRenamePane" [ ])
              (action "SwitchToMode" [ "Pane" ])
            ]
          )
        ])
        (mode "session" [
          (bind [ "Ctrl o" ] [ (action "SwitchToMode" [ "Normal" ]) ])
          (bind [ "Ctrl s" ] [ (action "SwitchToMode" [ "Scroll" ]) ])
          (bind [ "d" ] [ (action "Detach" [ ]) ])
        ])
        (mode "tmux" [
          (bind [ "[" ] [ (action "SwitchToMode" [ "Scroll" ]) ])
          (bind
            [ "Ctrl a" ]
            [
              (action "Write" [ 2 ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "\"" ]
            [
              (action "NewPane" [ "Down" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "%" ]
            [
              (action "NewPane" [ "Right" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "z" ]
            [
              (action "ToggleFocusFullscreen" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "c" ]
            [
              (action "NewTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind [ "," ] [ (action "SwitchToMode" [ "RenameTab" ]) ])
          (bind
            [ "p" ]
            [
              (action "GoToPreviousTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "n" ]
            [
              (action "GoToNextTab" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "Left" ]
            [
              (action "MoveFocus" [ "Left" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "Right" ]
            [
              (action "MoveFocus" [ "Right" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "Down" ]
            [
              (action "MoveFocus" [ "Down" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "Up" ]
            [
              (action "MoveFocus" [ "Up" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "h" ]
            [
              (action "MoveFocus" [ "Left" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "l" ]
            [
              (action "MoveFocus" [ "Right" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "j" ]
            [
              (action "MoveFocus" [ "Down" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind
            [ "k" ]
            [
              (action "MoveFocus" [ "Up" ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
          (bind [ "o" ] [ (action "FocusNextPane" [ ]) ])
          (bind [ "d" ] [ (action "Detach" [ ]) ])
          (bind [ "Space" ] [ (action "NextSwapLayout" [ ]) ])
          (bind
            [ "x" ]
            [
              (action "CloseFocus" [ ])
              (action "SwitchToMode" [ "Normal" ])
            ]
          )
        ])
        (sharedExcept
          [ "locked" ]
          [
            (bind [ "Ctrl g" ] [ (action "SwitchToMode" [ "Locked" ]) ])
            (bind [ "Ctrl q" ] [ (action "Quit" [ ]) ])
            (bind [ "Alt n" ] [ (action "NewPane" [ ]) ])
            (bind
              [
                "Alt h"
                "Alt Left"
              ]
              [ (action "MoveFocusOrTab" [ "Left" ]) ]
            )
            (bind
              [
                "Alt l"
                "Alt Right"
              ]
              [ (action "MoveFocusOrTab" [ "Right" ]) ]
            )
            (bind
              [
                "Alt j"
                "Alt Down"
              ]
              [ (action "MoveFocus" [ "Down" ]) ]
            )
            (bind
              [
                "Alt k"
                "Alt Up"
              ]
              [ (action "MoveFocus" [ "Up" ]) ]
            )
            (bind
              [
                "Alt ="
                "Alt +"
              ]
              [ (action "Resize" [ "Increase" ]) ]
            )
            (bind [ "Alt -" ] [ (action "Resize" [ "Decrease" ]) ])
            (bind [ "Alt [" ] [ (action "PreviousSwapLayout" [ ]) ])
            (bind [ "Alt ]" ] [ (action "NextSwapLayout" [ ]) ])
          ]
        )
        (sharedExcept
          [
            "normal"
            "locked"
          ]
          [
            (bind
              [
                "Enter"
                "Esc"
              ]
              [ (action "SwitchToMode" [ "Normal" ]) ]
            )
          ]
        )
        (sharedExcept
          [
            "pane"
            "locked"
          ]
          [
            (bind [ "Ctrl p" ] [ (action "SwitchToMode" [ "Pane" ]) ])
          ]
        )
        (sharedExcept
          [
            "resize"
            "locked"
          ]
          [
            (bind [ "Ctrl n" ] [ (action "SwitchToMode" [ "Resize" ]) ])
          ]
        )
        (sharedExcept
          [
            "scroll"
            "locked"
          ]
          [
            (bind [ "Ctrl s" ] [ (action "SwitchToMode" [ "Scroll" ]) ])
          ]
        )
        (sharedExcept
          [
            "session"
            "locked"
          ]
          [
            (bind [ "Ctrl o" ] [ (action "SwitchToMode" [ "Session" ]) ])
          ]
        )
        (sharedExcept
          [
            "tab"
            "locked"
          ]
          [
            (bind [ "Ctrl t" ] [ (action "SwitchToMode" [ "Tab" ]) ])
          ]
        )
        (sharedExcept
          [
            "move"
            "locked"
          ]
          [
            (bind [ "Ctrl h" ] [ (action "SwitchToMode" [ "Move" ]) ])
          ]
        )
        (sharedExcept
          [
            "tmux"
            "locked"
          ]
          [
            (bind [ "Ctrl a" ] [ (action "SwitchToMode" [ "Tmux" ]) ])
          ]
        )
      ];

      plugins._children = [
        {
          "tab-bar"._children = [ { path._args = [ "tab-bar" ]; } ];
        }
        {
          "status-bar"._children = [ { path._args = [ "status-bar" ]; } ];
        }
        {
          strider._children = [ { path._args = [ "strider" ]; } ];
        }
        {
          "compact-bar"._children = [ { path._args = [ "compact-bar" ]; } ];
        }
      ];

      themes._children = [
        {
          dracula._children = [
            {
              fg._args = [
                248
                248
                242
              ];
            }
            {
              bg._args = [
                40
                42
                54
              ];
            }
            {
              red._args = [
                255
                85
                85
              ];
            }
            {
              green._args = [
                80
                250
                123
              ];
            }
            {
              yellow._args = [
                241
                250
                140
              ];
            }
            {
              blue._args = [
                98
                114
                164
              ];
            }
            {
              magenta._args = [
                255
                121
                198
              ];
            }
            {
              orange._args = [
                255
                184
                108
              ];
            }
            {
              cyan._args = [
                139
                233
                253
              ];
            }
            {
              black._args = [
                0
                0
                0
              ];
            }
            {
              white._args = [
                255
                255
                255
              ];
            }
          ];
        }
        {
          nord._children = [
            { fg._args = [ "#D8DEE9" ]; }
            { bg._args = [ "#2E3440" ]; }
            { black._args = [ "#3B4252" ]; }
            { red._args = [ "#BF616A" ]; }
            { green._args = [ "#A3BE8C" ]; }
            { yellow._args = [ "#EBCB8B" ]; }
            { blue._args = [ "#81A1C1" ]; }
            { magenta._args = [ "#B48EAD" ]; }
            { cyan._args = [ "#88C0D0" ]; }
            { white._args = [ "#E5E9F0" ]; }
            { orange._args = [ "#D08770" ]; }
          ];
        }
      ];

      theme = "nord";
    };
  };
}
