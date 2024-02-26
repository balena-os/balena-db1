inherit kernel-balena

BALENA_CONFIGS[rtl8192cu] = ""
BALENA_CONFIGS_DEPS[ralink] = ""
BALENA_CONFIGS_DEPS[brcmfmac] = ""
BALENA_CONFIGS[brcmfmac] = ""

# Used to avoid trace_printk debug message
BALENA_CONFIGS_DEPS[uprobes] = ""
BALENA_CONFIGS[uprobes] = ""
