#!/bin/bash
SESSION='akrzos-browbeat'
# My tmux session for browbeat on 1 Controller and 1 Compute tripleo deployed cloud

tmux -2 new-session -d -s $SESSION -n 'browbeat'

# Setup a window and split panes, source venv, tail log file
tmux new-window -t $SESSION:1 -n 'undercloud-stack'
tmux send-keys "su - stack" C-m

# Single Pane Browbeat
tmux new-window -t $SESSIION:2 -n 'browbeat'
tmux send-keys "su - stack" C-m
tmux send-keys ". browbeat-venv/bin/activate; cd browbeat" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd browbeat/log; tailf debug.log" C-m
tmux select-pane -t 0

# Controller
tmux new-window -t $SESSIION:3 -n 'controller0'
tmux send-keys "su - stack" C-m
tmux send-keys "cd browbeat/ansible" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m

# Compute
tmux new-window -t $SESSIION:4 -n 'computes'
tmux send-keys "su - stack" C-m
tmux send-keys "cd browbeat/ansible" C-m
tmux send-keys "ssh -F ssh-config overcloud-compute-0" C-m
tmux send-keys "sudo su -" C-m

tmux select-window -t $SESSION:1

tmux -2 attach-session -t $SESSION
