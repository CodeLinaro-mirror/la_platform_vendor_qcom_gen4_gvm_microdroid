TARGET_BOARD_DERIVATIVE_SUFFIX := _microdroid

PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab.microdroid:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.gen4.qcom

include device/qcom/gen4_gvm/gen4_gvm.mk

LOCAL_PATH := $(call my-dir)

PRODUCT_NAME := gen4_gvm_microdroid
PRODUCT_DEVICE := gen4_gvm_microdroid
PRODUCT_BRAND := qti
PRODUCT_MODEL := gen4_gvm_microdroid for arm64

#TARGET_SUPPORTS_64_BIT_APPS := false

LOCAL_ANDROIDBOOT_INIT_RC ?= /system/etc/init/hw/init.minidroid.rc
ALLOW_MISSING_DEPENDENCIES := true

PRODUCT_COMPRESSED_APEX := false

$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call soong_config_append,cvd,launch_configs,cvd_config_minidroid.json)
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

PRODUCT_SYSTEM_PROPERTIES += \
    service.adb.listen_addrs=tcp:5555 \

# Disable Treble and the VNDK
PRODUCT_FULL_TREBLE_OVERRIDE := false
PRODUCT_USE_VNDK_OVERRIDE := false
PRODUCT_USE_PRODUCT_VNDK_OVERRIDE := false

#Overriding everything from base.
#PRODUCT_PACKAGES := 
#PRODUCT_PACKAGES_DEBUG :=
#PRODUCT_COPY_FILES :=

#stolen from microdroid/Android.bp
PRODUCT_PACKAGES += \
    init_second_stage \
    libbinder \
    libbinder_ndk \
    libstdc++ \
    secilc \
    libadbd_auth \
    libadbd_fs \
    heapprofd_client_api \
    libartpalette-system \
    apexd \
    atrace \
    debuggerd \
    linker \
    servicemanager \
    service \
    tombstoned \
    tombstone_transmit.microdroid \
    cgroups.json \
    task_profiles.json \
    public.libraries.android.txt \
    logcat \
    logd \

PRODUCT_PACKAGES += fstab.gen4.qcom

# Packages included only for eng or userdebug builds
# su needed for logpersist.* commands
PRODUCT_PACKAGES_DEBUG += \
    logpersist.start \
    su \

# Start logcatd by default and keep up to 30 rotated files around in userdebug/eng builds
ifneq (,$(filter userdebug eng, $(TARGET_BUILD_VARIANT)))
PRODUCT_PROPERTY_OVERRIDES += \
  logd.logpersistd=logcatd \
  logd.logpersistd.size=30
endif

# Shell and utilities
PRODUCT_PACKAGES += \
    reboot \
    sh \
    strace \
    toolbox \
    toybox \
    sh_vendor \
    toolbox_vendor \
    toybox_vendor

# Test Binder RPC services
PRODUCT_PACKAGES += \
    minidroid_sd \
    server_minidroid \
    client_minidroid \
    client_minidroid_rust \

# Additional packages
PRODUCT_PACKAGES += \
    com.android.runtime \
    com.android.adbd \
    mdnsd \

PRODUCT_PACKAGES += \
    init.environ.rc

DONT_DEXPREOPT_PREBUILTS := true
WITH_DEXPREOPT := false
UNSAFE_DISABLE_HIDDENAPI_FLAGS := true
PRODUCT_ENFORCE_VINTF_MANIFEST := false

PRODUCT_PACKAGES += \
    vendor_compatibility_matrix.xml \

PRODUCT_PACKAGES += \
                  grpcserver \
                  grpcclient \

ifneq ("$(wildcard device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/vendor_dlkm/system_dlkm.modules.blocklist)", "")
PRODUCT_COPY_FILES += device/qcom/$(TARGET_BOARD_PLATFORM)-kernel/vendor_dlkm/system_dlkm.modules.blocklist:$(TARGET_COPY_OUT_VENDOR_DLKM)/lib/modules/system_dlkm.modules.blocklist
endif

PRODUCT_COPY_FILES += $(LOCAL_PATH)/fstab.microdroid:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.gen4.qcom
PRODUCT_COPY_FILES += \
    device/qcom/gen4_gvm_microdroid/init.rc:system/etc/init/hw/init.minidroid.rc \
    packages/modules/Virtualization/microdroid/ueventd.rc:vendor/etc/ueventd.rc \
