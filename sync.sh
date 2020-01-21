#!/bin/sh
echo "Multiple regiional mirrors are available to sync from:"
echo "[1] americas.rsync.php.net"
echo "[2] asia.rsync.php.net"
echo "[3] europe.rsync.php.net"
echo "Please select the physically closest mirror to your network:"
read -p "Default [1]:" MIRROR

case $MIRROR in

  1)
    RRN_HOSTNAME="americas.rsync.php.net"
    ;;

  2)
    RRN_HOSTNAME="asia.rsync.php.net"
    ;;

  3)
    RRN_HOSTNAME="europe.rsync.php.net"
    ;;

  *)
    echo "Unknown or no selection provided, defaulting to americas.rsync.php.net"
    RRN_HOSTNAME="americas.rsync.php.net"
    ;;

esac

rsync -avzC --timeout=600 --delete --delete-after \
      --include='manual/en/' \
      --include='manual/en/**' \
      --exclude='manual/**' \
      --exclude='distributions/manual/**' \
      --exclude='distributions/**' \
      $RRN_HOSTNAME::phpweb ./phpweb
