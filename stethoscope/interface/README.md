# User interface

Three push buttons (filter select, volume +, volume -) wired to PSoC 5LP pins through hardware debouncers, with edge-triggered interrupts. Filter selection cycles through heart, lung and bowel; volume is the gain of the input PGA. An SSD1306 OLED shows the active mode and gain (visible in `../../docs/img/breadboard-full-system.jpg`).

Included: `button-debouncer-circuit.jpg`. The interface firmware source was not part of the recovered files.
