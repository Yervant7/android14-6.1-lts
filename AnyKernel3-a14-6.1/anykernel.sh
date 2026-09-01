### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers
# TheWildJames

### AnyKernel setup
# global properties
properties() { '
kernel.string=gki 6.1 by yervant7
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
keycheck.timeout=10
'; } # end properties

### AnyKernel install
## boot shell variables
block=boot
is_slot_device=auto
ramdisk_compression=auto
patch_vbmeta_flag=auto
no_magisk_check=1

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

version_to_int() {
    echo "$1" | awk -F. '{ printf("%d%03d%03d\n", $1, $2, $3); }'
}

kernel_version=$(uname -r | awk -F '.' '{print $1"."$2"."$3}' | awk -F '-' '{print $1}')

if [ version_to_int "$kernel_version" -lt version_to_int "6.1.120" ] || [ version_to_int "$kernel_version" -gt version_to_int "6.1.200" ]; then
    abort "Error: kernel version not supported/recommended."
fi

# boot install
split_boot

if [ -f "$SPLITIMG/ramdisk.cpio" ]; then
    unpack_ramdisk
    write_boot
else
    flash_boot
fi
