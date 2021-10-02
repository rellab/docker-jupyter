#!/bin/bash

echo "c.NotebookApp.token = '$JUPYTER_PASSWORD'" >> /home/jovyan/.jupyter/jupyter_notebook_config.py
start-notebook.sh
