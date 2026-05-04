ADDITIONAL_CFLAGS = -Wno-error=deprecated-declarations
THEOS_PACKAGE_SCHEME = rootless
TARGET := iphone:clang:latest:15.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FirstTweak

FirstTweak_FILES = Tweak.x
FirstTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk