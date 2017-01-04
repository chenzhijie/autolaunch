THEOS_DEVICE_IP = 192.168.100.27
THEOS_DEVICE_PORT = 22
ARCHS = armv7 arm64
TARGET = iphone:latest:7.0
ADDITIONAL_OBJCFLAGS = -fobjc-arc

include ~/Desktop/iosre/theos/makefiles/common.mk


TWEAK_NAME = AutoLaunch

AutoLaunch_FILES = Tweak.xm 
AutoLaunch_FRAMEWORKS = UIKit CoreGraphics
AutoLaunch_PRIVATE_FRAMEWORKS = Preferences
AutoLaunch_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall -9 SpringBoard"
