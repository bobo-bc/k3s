# Storage
I have messed around several storage options and this is what I learned. 
> Truenas is an amazing bit of software and if I had more money or a bigger lab I would run it. It is overkill for nfs sharing but I did learn to appreciate ZFS resiliency which is what I use today. 
> Longhorn is amazing at just working for persistent volumes. However, the need for multiple replicas and the storage and ram required to maintain those replicas is crazy. 
> For the resource constrained, Use a VM to be a nfs host or better yet let proxmox handle it since it is a linux box that can manage zfs comfortably. 

## Longhorn script
If you do decide on longhorn I figured out this great script to prepare secondary dedicated HD for longhorn to use.

Longhorn Disk Prep Script


```bash
#!/bin/bash
set -e

# ---- CONFIG ----
# Change this to your raw disk device (e.g., /dev/sdb, /dev/sdc)
DISK="/dev/sdb"
MOUNTPOINT="/mnt/longhorn"

# ---- Script ----
echo "[INFO] Preparing disk $DISK for Longhorn..."

# Check if disk exists
if [ ! -b "$DISK" ]; then
    echo "[ERROR] Disk $DISK does not exist!"
    exit 1
fi

# Unmount if accidentally mounted
sudo umount $DISK || true

# Format as XFS
echo "[INFO] Formatting $DISK as XFS..."
sudo mkfs.xfs -f $DISK

# Create mount point
echo "[INFO] Creating mount point $MOUNTPOINT..."
sudo mkdir -p $MOUNTPOINT

# Mount the disk
echo "[INFO] Mounting $DISK at $MOUNTPOINT..."
sudo mount $DISK $MOUNTPOINT

# Backup fstab and add entry
echo "[INFO] Adding to /etc/fstab for persistent mount..."
sudo cp /etc/fstab /etc/fstab.bak
UUID=$(blkid -s UUID -o value $DISK)
echo "UUID=$UUID $MOUNTPOINT xfs defaults 0 0" | sudo tee -a /etc/fstab

# Verify
echo "[INFO] Disk prep complete. Current mounts:"
df -h | grep $MOUNTPOINT

echo "[INFO] Disk $DISK is ready for Longhorn!"
```



### How to use
On each worker node:
```bash 
sudo nano prep-longhorn.sh`
```
# Paste script, save

```bash
chmod +x prep-longhorn.sh
sudo ./prep-longhorn.sh
```
After running, the disk will be mounted at /mnt/longhorn and Longhorn UI should detect it.
Repeat for all three worker nodes (adjust DISK="/dev/sdb" for each node).