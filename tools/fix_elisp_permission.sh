#!/bin/bash

find ../.emacs.d/ -name "*.(el|elc)" -exec chmod 700 {} \;
