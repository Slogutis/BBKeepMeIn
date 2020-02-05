INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BB

BB_FILES = Tweak.x
BB_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
