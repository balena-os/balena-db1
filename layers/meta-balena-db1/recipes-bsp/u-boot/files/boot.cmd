setenv resin_kernel_load_addr ${kernel_addr_r}
run resin_set_kernel_root

setenv fdt_file db1_07c.dtb
setenv fdt_addr_r 80100000

load mmc ${resin_dev_index}:${resin_boot_part} ${fdt_addr_r} ${fdt_file}
fdt addr ${fdt_addr_r} 0x100000

i2c dev 3
i2c read 0x50 0x8.1 6 0x80000000
setexpr.b m0 *0x80000000;
setexpr.b m1 *0x80000001;
setexpr.b m2 *0x80000002;
setexpr.b m3 *0x80000003;
setexpr.b m4 *0x80000004;
setexpr.b m5 *0x80000005;
fdt set /soc/usb@78d9000/usb-device-list/ethernet local-mac-address [ $m0 $m1 $m2 $m3 $m4 $m5 ]

i2c read 0x50 0xe.1 6 0x80000000
setexpr.b m0 *0x80000000;
setexpr.b m1 *0x80000001;
setexpr.b m2 *0x80000002;
setexpr.b m3 *0x80000003;
setexpr.b m4 *0x80000004;
setexpr.b m5 *0x80000005;
fdt set /soc/wcnss@a21b000/smd-edge/wcnss/wifi local-mac-address [ $m0 $m1 $m2 $m3 $m4 $m5 ]

i2c read 0x50 0x14.1 6 0x80000000
setexpr.b m0 *0x80000000;
setexpr.b m1 *0x80000001;
setexpr.b m2 *0x80000002;
setexpr.b m3 *0x80000003;
setexpr.b m4 *0x80000004;
setexpr.b m5 *0x80000005;
fdt set /soc/wcnss@a21b000/smd-edge/wcnss/bt local-bd-address [ $m5 $m4 $m3 $m2 $m1 $m0 ]
fdt set /soc/wcnss@a21b000/smd-edge/wcnss/bt local-mac-address [ $m0 $m1 $m2 $m3 $m4 $m5 ]

setenv bootargs "${bootargs} ${resin_kernel_root} console=ttyMSM0 mdss_mdp.panel=1:dsi:0:qcom,mdss_dsi_hx8394d_720p_video:1:none rootwait"

load ${resin_dev_type} ${resin_dev_index}:${resin_root_part} ${resin_kernel_load_addr} /boot/Image
booti ${resin_kernel_load_addr} - ${fdt_addr_r}
