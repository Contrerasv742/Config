
/* Rofi QuickSettings Theme */
/* Save this as ~/.config/rofi/themes/quicksettings.rasi */

* {
    /* Catppuccin Mocha Colors */
    base:           rgba(30, 30, 46, 0.98);
    mantle:         #181825;
    crust:          #11111b;
    text:           #cdd6f4;
    subtext0:       #a6adc8;
    subtext1:       #bac2de;
    surface0:       #313244;
    surface1:       #45475a;
    surface2:       #585b70;
    overlay0:       #6c7086;
    overlay1:       #7f849c;
    overlay2:       #9399b2;
    blue:           #89b4fa;
    lavender:       #b4befe;
    sapphire:       #74c7ec;
    sky:            #89dceb;
    teal:           #94e2d5;
    green:          #a6e3a1;
    yellow:         #f9e2af;
    peach:          #fab387;
    maroon:         #eba0ac;
    red:            #f38ba8;
    mauve:          #cba6f7;
    pink:           #f5c2e7;
    flamingo:       #f2cdcd;
    rosewater:      #f5e0dc;
    
    background-color: transparent;
    font: "JetBrainsMono Nerd Font Propo 12";
}

window {
    location:           northeast;
    anchor:             northeast;
    x-offset:           -10px;
    y-offset:           40px;
    width:              400px;
    height:             auto;
    background-color:   @base;
    border:             2px solid #431796;
    border-radius:      14px;
    padding:            0px;
}

mainbox {
    background-color:   transparent;
    children:           [ "inputbar", "listview" ];
    spacing:            0px;
    padding:            0px;
}

inputbar {
    background-color:   rgba(45, 45, 65, 0.8);
    text-color:         @text;
    border:             0px 0px 1px 0px;
    border-color:       @surface0;
    border-radius:      14px 14px 0px 0px;
    padding:            12px 16px;
    children:           [ "prompt", "entry" ];
    spacing:            8px;
}

prompt {
    background-color:   transparent;
    text-color:         @blue;
    font:               "JetBrainsMono Nerd Font Propo Bold 14";
}

entry {
    background-color:   transparent;
    text-color:         @text;
    placeholder-color:  @overlay0;
    cursor:             text;
}

listview {
    background-color:   transparent;
    padding:            8px;
    spacing:            2px;
    scrollbar:          false;
    fixed-height:       false;
}

element {
    background-color:   transparent;
    text-color:         @text;
    orientation:        horizontal;
    border-radius:      8px;
    padding:            6px 12px;
    margin:             1px;
    cursor:             pointer;
}

element normal.normal {
    background-color:   transparent;
    text-color:         @text;
}

element normal.urgent {
    background-color:   @red;
    text-color:         @crust;
}

element normal.active {
    background-color:   @blue;
    text-color:         @crust;
}

element selected.normal {
    background-color:   rgba(137, 180, 250, 0.2);
    text-color:         @blue;
    border:             1px solid rgba(137, 180, 250, 0.4);
}

element selected.urgent {
    background-color:   @red;
    text-color:         @crust;
}

element selected.active {
    background-color:   @blue;
    text-color:         @crust;
}

element alternate.normal {
    background-color:   transparent;
    text-color:         @text;
}

element alternate.urgent {
    background-color:   @red;
    text-color:         @crust;
}

element alternate.active {
    background-color:   @blue;
    text-color:         @crust;
}

element-text {
    background-color:   transparent;
    text-color:         inherit;
    highlight:          inherit;
    cursor:             inherit;
}

element-icon {
    background-color:   transparent;
    size:               1.2em;
    cursor:             inherit;
}

/* Custom styling for different sections */
element:nth-child(1) {
    background-color:   rgba(45, 45, 65, 0.6);
    text-color:         @blue;
    font:               "JetBrainsMono Nerd Font Propo Bold 13";
    border-bottom:      1px solid @surface0;
    border-radius:      0px;
    padding:            10px 16px;
}

element:nth-child(3),
element:nth-child(4),
element:nth-child(5) {
    background-color:   rgba(49, 50, 68, 0.3);
    margin:             2px 4px;
    border-radius:      10px;
}

element:nth-child(7),
element:nth-child(8),
element:nth-child(9) {
    background-color:   rgba(49, 50, 68, 0.3);
    margin:             2px 4px;
    border-radius:      10px;
}

element:nth-child(11),
element:nth-child(12),
element:nth-child(13) {
    background-color:   rgba(49, 50, 68, 0.3);
    margin:             2px 4px;
    border-radius:      10px;
}

element:nth-child(15),
element:nth-child(16) {
    background-color:   rgba(49, 50, 68, 0.4);
    margin:             2px 4px;
    border-radius:      10px;
    padding:            8px 12px;
}

/* Hover effects for different sections */
element:nth-child(3):selected,
element:nth-child(4):selected,
element:nth-child(5):selected {
    background-color:   rgba(166, 227, 161, 0.2);
    text-color:         @green;
}

element:nth-child(7):selected,
element:nth-child(8):selected,
element:nth-child(9):selected {
    background-color:   rgba(203, 166, 247, 0.2);
    text-color:         @mauve;
}

element:nth-child(11):selected,
element:nth-child(12):selected,
element:nth-child(13):selected {
    background-color:   rgba(116, 199, 236, 0.2);
    text-color:         @sapphire;
}

element:nth-child(15):selected,
element:nth-child(16):selected {
    background-color:   rgba(249, 226, 175, 0.2);
    text-color:         @yellow;
ea
