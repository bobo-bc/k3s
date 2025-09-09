# Post install

Use proxmox installer booting from usb and following prompts

Use proxmox helper scripts to complete post install. 

[proxmox helper scripts community](https://community-scripts.github.io/ProxmoxVE/)

## Prepare NFS

if the ZFS pools already exist and you just want Proxmox to recognize them, you don’t need to destroy or recreate anything
 
Here’s what to do:
 
 
 
### 1. Check for Existing Pools
 
 
On your Proxmox host:

```bash 
zpool import
```
 
If you see your old pool(s) listed (e.g., tank), they’re detected but not yet imported.
  
### 2. Import the Pool
 
```bash
zpool import tank
```

If you want it to import automatically at boot (recommended):

``` bash
zpool import -f tank
```

Check:
```bash
zpool status
```

It should now show tank as ONLINE.
 
 
 
### 3. Add Pool to Proxmox Storage
 
 
In Proxmox Web UI → Datacenter → Storage → Add → ZFS.
Fill in:
 
ID: whatever name you want to use in Proxmox (usually same as pool name, e.g., tank).
ZFS Pool: tank (dropdown should show it now).
Content: choose what you’ll store (Disk image, Container, Snippets, ISO, etc.).
Nodes: check your node.
 
 
Click Add.
 
 
 
### 4. If You Just Want Mounts (not VM storage)
 
 
To use it as a directory for VM or LXC:
 
Go to Datacenter → Storage → Add → Directory.
Set the path to your dataset, e.g. /tank/media.
Give it an ID like media.
Select content type: file
 
 
After this, Proxmox will be aware of your existing pool(s) without wiping anything.
 
 
###  Use NFS for shared access
If you want multiple VMs or your k3s cluster nodes to access /tank/media at the same time, you need NFS.
Steps:
Install NFS server on Proxmox host:
 
```bash
apt install nfs-kernel-server -y
```

 
Edit exports:
 
```bash
nano /etc/exports
```
Example:
 
```bash
#
/tank/media/books   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/files   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/movies   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/music   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/torrents   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/tv   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/media/wiki   10.0.0.0/24(rw,sync,no_subtree_check,insecure)
/tank/k8s-nfs *(rw,sync,no_subtree_check,no_root_squash)
```

Apply:
 
```bash
exportfs -ra
systemctl restart nfs-kernel-server
```
In your VMs or k3s nodes, mount it the explicit exports 
 

use a PersistentVolume in Kubernetes pointing to the NFS path.
Pros: multiple VMs / k3s nodes can read/write simultaneously
Cons: adds network overhead; need NFS service running
 
## LXC mounts 
Stop the LXC

```bash
pct stop <CTID>
```

Replace <CTID> with your Plex container’s ID.

### Add a bind mount

Edit the LXC config file on the Proxmox host:

```bash
/etc/pve/lxc/<CTID>.conf
```

Add a line like this:

```bash
mp0: /tank/media/tv,mp=/mnt/tv
```

	•	mp0 → mount point index (use mp1, mp2, etc. if you already have one).
	•	/tank/media/tv → directory on your Proxmox host (your ZFS dataset).
	•	mp=/mnt/tv → where it will appear inside the container. You can change the path to whatever Plex expects, e.g. /media/tv.

⸻

### Restart the LXC

```bash
pct start <CTID>
```

Then inside the container you should see:

```bash
ls /mnt/tv
```

Your host’s media directory contents should show up.

⸻

### Permissions check
	•	Make sure the Plex process user inside the container can read the files.
	•	If permissions are tight on /tank/media/tv, you may need to adjust with chmod/chown or set an ACL from the host.

Example:

```bash
chown -R 1000:1000 /tank/media/tv
```

(assuming Plex inside LXC runs as UID 1000).

