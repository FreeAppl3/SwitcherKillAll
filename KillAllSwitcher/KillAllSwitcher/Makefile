TARGET := iphone:clang:15.6


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = KillAllSwitcher

KillAllSwitcher_FILES = Tweak.xm
KillAllSwitcher_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
