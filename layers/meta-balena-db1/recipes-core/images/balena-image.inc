DEPENDS += "gptfdisk-native"

PARTITION_TABLE_TYPE="gpt"

BALENA_BOOT_SIZE="128000"
IMAGE_ROOTFS_SIZE = "419488"

IMAGE_OVERHEAD_FACTOR = "1.0"
IMAGE_ROOTFS_EXTRA_SPACE = "53248"
IMAGE_ROOTFS_MAXSIZE="800000"

BALENA_BOOT_PARTITION_FILES:append = " \
    boot.scr:/boot.scr \
    db1_07c.dtb:/db1_07c.dtb \
    bootfiles1/u-boot-test-signed.mbn:/u-boot-test-signed.mbn \
    ${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin:/${KERNEL_IMAGETYPE}"

check_size() {
    file_path=${1}
    [ -f "${file_path}" ] || bbfatal "Specified path does not exist: ${file_path}"
    file_size=$(ls -l ${file_path} | awk '{print $5}')
    part_size=${2}

    if [ "$file_size" -gt "$part_size" ]; then
        bbfatal "File ${file_path} too big for raw partition! $file_size > $part_size"
    fi;
}

DEVICE_SPECIFIC_SPACE:db1 = "49152"
device_specific_configuration:db1() {
    partitions=$(cat ${DEPLOY_DIR_IMAGE}/partition_specification.txt)
    PART_OFFSET=2048
    START=${PART_OFFSET}
    PARTID=1
    for n in ${partitions}; do
      part_name=$(echo $n | cut -d ':' -f 1)
      file_name=$(echo $n | cut -d ':' -f 2)
      part_size=$(echo $n | cut -d ':' -f 3)
      part_guid=$(echo $n | cut -d ':' -f 4)
      file_path=$(find ${DEPLOY_DIR_IMAGE}/bootfiles1 -name $file_name)
      END=$(expr ${START} \+ ${part_size} \- 1)
      parted -s ${BALENA_RAW_IMG} unit s mkpart $part_name ${START} ${END}
      check_size ${file_path} $(expr ${part_size} \* 512)
      sgdisk -t $PARTID:$part_guid ${BALENA_RAW_IMG}
      dd if=$file_path of=${BALENA_RAW_IMG} conv=notrunc seek=${START} bs=512
      START=$(expr ${START} \+ ${PART_OFFSET})
      PARTID=$(expr ${PARTID} + 1)
    done
}
