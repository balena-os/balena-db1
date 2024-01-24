setenv resin_kernel_load_addr ${kernel_addr_r}
run resin_set_kernel_root
setenv bootargs "${bootargs} ${resin_kernel_root} console=ttyMSM0 mdss_mdp.panel=1:dsi:0:qcom,mdss_dsi_hx8394d_720p_video:1:none rootwait"
setenv fdt_file db1_07c.dtb

setenv fdt_addr_r 80000000

load mmc ${resin_dev_index}:${resin_boot_part} ${fdt_addr_r} ${fdt_file}
load ${resin_dev_type} ${resin_dev_index}:${resin_root_part} ${resin_kernel_load_addr} /boot/Image
booti ${resin_kernel_load_addr} - ${fdt_addr_r}
