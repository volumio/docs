#/bin/sh

RUNPATH=`dirname $0`
RUNPATH=`readlink -f "$RUNPATH"`

DEST=out

php generate.php -c global.json -d $DEST || exit 1

echo "Output files can be viewed at 'file://${RUNPATH}/${DEST}'"

