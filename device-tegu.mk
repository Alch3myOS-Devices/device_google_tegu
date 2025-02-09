#
# SPDX-FileCopyrightText: 2021 The Android Open-Source Project
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-FileCopyrightText: The Calyx Institute
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
TARGET_LINUX_KERNEL_VERSION := 6.1
TARGET_KERNEL_DEVICE := tegu
TARGET_KERNEL_PATH := device/google/tegu-kernels
TARGET_KERNEL_DIR := $(TARGET_KERNEL_PATH)/6.1
TARGET_BOARD_KERNEL_HEADERS := $(TARGET_KERNEL_DIR)/kernel-headers
TARGET_PREBUILT_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4
LOCAL_KERNEL := $(TARGET_KERNEL_DIR)/Image.lz4

ifneq ($(TARGET_BOOTS_16K),true)
PRODUCT_16K_DEVELOPER_OPTION := true
endif

PRODUCT_BUILD_IGNORE_APEX_CONTRIBUTION_CONTENTS := true

# Shipping API level
SHIPPING_API_LEVEL := 35

# Inherit from zumapro
include device/google/zumapro/common.mk

# Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0-service \
    hwservicemanager

# Always use scudo for memory allocator
PRODUCT_USE_SCUDO := true

# Camera
$(call inherit-product-if-exists, vendor/google/camera/config.mk)

# Face unlock
$(call inherit-product-if-exists, vendor/google/faceunlock/config.mk)

# Set support hide display cutout feature
PRODUCT_PRODUCT_PROPERTIES += \
    ro.support_hide_display_cutout=true

PRODUCT_PACKAGES += \
    NoCutoutOverlay \
    AvoidAppsInCutoutOverlay

# Overlays
PRODUCT_PACKAGES += \
    Alch3mySettingsTegu \
    DMServiceOverlayVendorTegu \
    FrameworkResOverlayProductTegu \
    FrameworkResOverlayVendorTegu \
    PixelDisplayServiceOverlayProductTegu \
    PixelNfcOverlayTegu \
    SafetyRegulatoryInfoOverlayProductTegu \
    SettingsGoogleOverlayVendorTegu \
    SettingsTeguOverlay \
    SystemUIGoogleOverlayProductTegu \
    SystemUIGoogleOverlayVendorTegu

PRODUCT_PACKAGES += \
    ApertureOverlayTegu

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/$(DEVICE_CODENAME)/product.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/$(DEVICE_CODENAME)/vendor.prop

# Recovery
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/init.recovery.device.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.tegu.rc

PRODUCT_PACKAGES += \
    init.recovery.tegu.touch.rc

# Satellite
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.satellite.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/android.hardware.telephony.satellite.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
