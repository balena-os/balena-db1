FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

UBOOT_KCONFIG_SUPPORT = "1"
inherit resin-u-boot

SRC_URI:remove = " \
                  file://0001-riscv32-Use-double-float-ABI-for-rv32.patch \
                  file://0001-riscv-fix-build-with-binutils-2.38.patch \
                  file://0001-i2c-fix-stack-buffer-overflow-vulnerability-in-i2c-m.patch \
                  file://0001-fs-squashfs-sqfs_read-Prevent-arbitrary-code-executi.patch \
                  file://0001-fs-squashfs-Use-kcalloc-when-relevant.patch \
                 "
SRC_URI += " \
             file://boot.cmd \
           "

BALENA_BOOT_PART:db1 = "7"
BALENA_DEFAULT_ROOT_PART:db1 = "8"
