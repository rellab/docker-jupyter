#!/bin/bash

echo "$JUPYTER_USER:$JUPYTER_PASSWORD" | chpasswd

if [ $JUPYTER_GRANT_SUDO = "yes" ]; then
  echo "$JUPYTER_USER ALL=(ALL) ALL" >> /etc/sudoers.d/$JUPYTER_USER
elif [ $JUPYTER_GRANT_SUDO = "nopass" ]; then
  echo "$JUPYTER_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$JUPYTER_USER
fi

su - $JUPYTER_USER -c "echo \"c.NotebookApp.token = '$JUPYTER_PASSWORD'\" >> /home/jovyan/.jupyter/jupyter_notebook_config.py"
su - $JUPYTER_USER -c "start-notebook.sh"
