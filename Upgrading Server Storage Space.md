1) Login to Linode and find your volume
2) Click the 3 dots and choose Resize
3) Enter your new size, click Resize volume
4) Wait until its resized
5) WARNING: make sure everyone on the team isn't using the server otherwise it can cause corruption.
6) Now SSH / Remote onto your server
7) Deactivate perforce with the command:
   `systemctl stop helix-p4dctl.service`
8) Un-mount your volume so we can edit it: Make sure to replace `<VOLUME NAME>` with your volumes name
   `umount /dev/disk/by-id/scsi-0Linode_Volume_<VOLUME NAME>`
   e.g.
   `umount /dev/disk/by-id/scsi-0Linode_Volume_D3kryptionsVolume`
9) Now tell the server to "find" the new space
   `e2fsck -f /dev/disk/by-id/scsi-0Linode_Volume_<VOLUME NAME>`
   e.g.
   `e2fsck -f /dev/disk/by-id/scsi-0Linode_Volume_D3kryptionsVolume`
10) Now resize the volume:
   `resize2fs /dev/disk/by-id/scsi-0Linode_Volume_<VOLUME NAME>`
   e.g.
   `resize2fs /dev/disk/by-id/scsi-0Linode_Volume_D3kryptionsVolume`
11) Now remount your volume:
    `mount "/dev/disk/by-id/scsi-0Linode_Volume_<VOLUME NAME>" "/mnt/<VOLUME NAME>"`
    e.g.
    `mount "/dev/disk/by-id/scsi-0Linode_Volume_D3kryptionsVolume" "/mnt/D3kryptionsVolume"`
12) Now restart perforce:
    `systemctl start helix-p4dctl.service`

# Errors

If at any point you get any errors about volume is busy, make sure you stopped perforce and anything else writing to the volume.
