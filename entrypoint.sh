#!/bin/bash

groupadd -f -g $JUPYTER_GID $JUPYTER_GROUP || exit 1
if [ $JUPYTER_PASSWORD = "no" ]; then
  useradd -d $JUPYTER_HOME -u $JUPYTER_UID -g $JUPYTER_GID -s /bin/bash $JUPYTER_USER || exit 1
else
  useradd -d $JUPYTER_HOME -u $JUPYTER_UID -g $JUPYTER_GID -s /bin/bash -p `echo "$JUPYTER_PASSWORD" | mkpasswd -s -m sha-512` $JUPYTER_USER || exit 1
fi

if [ $JUPYTER_GRANT_SUDO = "yes" ]; then
  echo "$JUPYTER_USER ALL=(ALL) ALL" >> /etc/sudoers.d/$JUPYTER_USER
elif [ $JUPYTER_GRANT_SUDO = "nopass" ]; then
  echo "$JUPYTER_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$JUPYTER_USER
fi

mkdir -p $JUPYTER_HOME
chown $JUPYTER_USER:$JUPYTER_GROUP $JUPYTER_HOME
su - $JUPYTER_USER -c "cp -n -r --preserve=mode /etc/skel/. $JUPYTER_HOME"

su - $JUPYTER_USER -c "echo \"c.NotebookApp.token = '$JUPYTER_PASSWORD'\" >> $JUPYTER_HOME/.jupyter/jupyter_notebook_config.py"
cd $JUPYTER_HOME
su - $JUPYTER_USER -c "tini -g -- start-notebook.sh"
