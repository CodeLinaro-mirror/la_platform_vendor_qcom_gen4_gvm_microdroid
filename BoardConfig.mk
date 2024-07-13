include device/qcom/gen4_gvm/BoardConfig.mk

TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := generic
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a9

BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := system product system_ext vendor vendor_dlkm system_dlkm

BOARD_KERNEL_CMDLINE :=
BOARD_BOOTCONFIG :=

ifneq ( ,$(filter V VanillaIceCream 15,$(PLATFORM_VERSION)))
TARGET_ANDROID_BELOW_V15 := false
else
TARGET_ANDROID_BELOW_V15 := true
endif

BOARD_BOOTCONFIG := androidboot.hardware=qcom androidboot.selinux=permissive androidboot.memcg=1 androidboot.recover_usb=1
BOARD_KERNEL_CMDLINE := debug user_debug=31 loglevel=9 print-fatal-signals=1  init=/init swiotlb=4096  kpti=0 pcie_ports=compat firmware_class.path=/vendor/firmware_mnt/image

BOARD_KERNEL_CMDLINE += console=hvc0,115200
BOARD_BOOTCONFIG += androidboot.console=hvc0

BOARD_BOOTCONFIG += androidboot.init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC) \
                    kernel.vmw_vsock_virtio_transport_common.virtio_transport_max_vsock_pkt_buf_size=16384 \
                    androidboot.microdroid.debuggable=1 \
                    androidboot.adb.enabled=1

BOARD_KERNEL_CMDLINE +=  printk.devkmsg=on log_buf_len=4M  printk_ratelimit=0 printk_ratelimit_burst=0 \
                         audit=1 \
                         panic=-1 \
                         init_rc=$(LOCAL_ANDROIDBOOT_INIT_RC)
