#
# To get started, copy makeconfig.example.mk as makeconfig.mk and fill in the appropriate paths.
#
# build: Build all the zips and kwads
# install: Copy mod files into a local installation of Invisible Inc
# rar: Update the pre-built rar
#

include makeconfig.mk

.PHONY: build install clean distclean cleanOut
.SECONDEXPANSION:

ensuredir = @mkdir -p $(@D)

files := modinfo.txt scripts.zip gui.kwad anims.kwad
outfiles := $(addprefix out/, $(files))
installfiles := $(addprefix $(INSTALL_PATH)/, $(files))
ifneq ($(INSTALL_PATH2),)
	installfiles += $(addprefix $(INSTALL_PATH2)/, $(files))
endif

build: $(outfiles)
install: build $(installfiles)

$(installfiles): %: out/$$(@F)
	$(ensuredir)
	cp $< $@

clean: cleanOut
cleanOut:
	-rm out/*

distclean:
	-rm -f $(INSTALL_PATH)/*.kwad $(INSTALL_PATH)/*.zip
ifneq ($(INSTALL_PATH2),)
	-rm -f $(INSTALL_PATH2)/*.kwad $(INSTALL_PATH2)/*.zip
endif

rar: build
	mkdir -p out/luna4s
	cp modinfo.txt out/luna4s/
	cp out/scripts.zip out/luna4s/
	cp out/gui.kwad out/luna4s/
	cp out/anims.kwad out/luna4s/
	cd out && rar a ../luna4s\ V.0.3.rar \
		luna4s/modinfo.txt \
		luna4s/scripts.zip \
		luna4s/gui.kwad \
		luna4s/anims.kwad

#
# kwads and contained files
#

anims := $(patsubst %.anim.d,%.anim,$(shell find anims -type d -name "*.anim.d"))
# Omit "menu pages" folder. Make doesn't support spaces in filenames
guis := $(shell find gui -type f -name "*.lua") \
        $(shell find gui -not -path "gui/images/gui/menu pages/*" -type f -name "*.png" )

$(anims): %.anim: $(wildcard %.anim.d/*.xml $.anim.d/*.png)
	cd $*.anim.d && zip ../$(notdir $@) *.xml *.png

out/gui.kwad out/anims.kwad: $(anims) $(guis)
	mkdir -p out
	$(KWAD_BUILDER) -i build.lua -o out

#
# scripts
#

out/scripts.zip: $(shell find scripts -type f -name "*.lua")
	mkdir -p out
	cd scripts && zip -r ../$@ . -i '*.lua'

out/modinfo.txt: modinfo.txt
	mkdir -p out
	cp modinfo.txt out/modinfo.txt
