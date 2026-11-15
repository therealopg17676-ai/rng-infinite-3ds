# RNG Infinity - 3DS port

DEVKITPRO ?= /opt/devkitpro
DEVKITARM ?= $(DEVKITPRO)/devkitARM
CTRULIB   ?= $(DEVKITPRO)/libctru
PORTLIBS  ?= $(DEVKITPRO)/portlibs/3ds

export PATH := $(DEVKITARM)/bin:$(DEVKITPRO)/tools/bin:$(PATH)

NAME   := rng-infinite
TITLE  := RNG Infinity
DESC   := Roll a number, collect badges
AUTHOR := rng-infinite
SRC    := source/main.c
HDR    := source/badges.h

CC      := arm-none-eabi-gcc
ARCH    := -march=armv6k -mtune=mpcore -mfloat-abi=hard -mtp=soft
CFLAGS  := -g -Wall -O2 -mword-relocations -ffunction-sections $(ARCH) -D__3DS__ -I$(CTRULIB)/include -I$(PORTLIBS)/include
LDFLAGS := -specs=3dsx.specs -g $(ARCH) -Wl,-Map,$(NAME).map
LIBS    := -L$(CTRULIB)/lib -L$(PORTLIBS)/lib -lcitro2d -lcitro3d -lctru -lm

.PHONY: all cia clean

all: $(NAME).3dsx

cia: $(NAME).cia

$(NAME).elf: $(SRC) $(HDR)
	$(CC) $(CFLAGS) $(SRC) $(LDFLAGS) $(LIBS) -o $@

$(NAME).smdh: icon.png
	smdhtool --create "$(TITLE)" "$(DESC)" "$(AUTHOR)" icon.png $@

$(NAME).3dsx: $(NAME).elf $(NAME).smdh
	3dsxtool $(NAME).elf $@ --smdh=$(NAME).smdh

banner.bnr: banner.png audio.wav
	bannertool makebanner -i banner.png -a audio.wav -o $@

icon.icn: icon.png
	bannertool makesmdh -s "$(TITLE)" -l "$(DESC)" -p "$(AUTHOR)" -i icon.png -o $@

$(NAME).cia: $(NAME).elf banner.bnr icon.icn app.rsf
	makerom -f cia -o $@ -elf $(NAME).elf -rsf app.rsf -icon icon.icn -banner banner.bnr -exefslogo -target t

clean:
	rm -f $(NAME).elf $(NAME).3dsx $(NAME).smdh $(NAME).cia $(NAME).map banner.bnr icon.icn
