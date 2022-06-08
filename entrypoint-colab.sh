#!/bin/bash

echo "c.ServerApp.token = '$JUPYTER_PASSWORD'" >> /home/jovyan/.jupyter/jupyter_notebook_config.py
echo "c.LabApp.collaborative = True" >> /home/jovyan/.jupyter/jupyter_server_config.py
start-notebook.sh

