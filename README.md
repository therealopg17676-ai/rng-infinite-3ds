# RNG Infinity - 3DS port (offline)

Roll a number from 0 to 1,000,000 and collect badges for its patterns.

## Build (macOS, devkitPro)
    sudo dkp-pacman -S 3ds-dev        # if not already installed
    make                              # -> rng-infinite.3dsx (Homebrew Launcher)
    make cia                          # -> rng-infinite.cia  (install with FBI)

`make cia` needs `makerom` and `bannertool` on your PATH (not part of devkitPro).

## Controls
A roll | X auto-roll | Y badge collection | L/R or D-pad: page | START save & quit | touch the bottom buttons

Save file: `sdmc:/3ds/rng-infinite/save.bin`

## Not included
Duels, leaderboard, social, shop, casino, skins, daily quests (they need the site's server).
The badge list here is my own, not the website's. Edit `source/badges.h` to match it.
