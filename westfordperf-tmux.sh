#!/bin/bash
# tmux setup for use with Browbeat (Single Controller/Compute)
SESSION='browbeat'
ssh_config_home='browbeat/ansible'
compute_name='overcloud-compute'

tmux -2 new-session -d -s $SESSION -n 'browbeat'

# Stack user window
tmux new-window -t $SESSION:1 -n 'undercloud-stack'
tmux send-keys "su - stack" C-m
tmux send-keys ". stackrc" C-m


# Single Pane Browbeat
tmux new-window -t $SESSIION:2 -n 'browbeat'
tmux send-keys "su - stack" C-m
tmux send-keys "cd browbeat; . .browbeat-venv/bin/activate" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd browbeat/log" C-m
tmux send-keys "tailf debug.log" C-m
tmux select-pane -t 0


# Controller
tmux new-window -t $SESSIION:3 -n 'controller0'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m


# Compute
tmux new-window -t $SESSIION:4 -n 'computes'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config ${compute_name}-0" C-m
tmux send-keys "sudo su -" C-m


tmux select-window -t $SESSION:1

tmux -2 attach-session -t $SESSION
