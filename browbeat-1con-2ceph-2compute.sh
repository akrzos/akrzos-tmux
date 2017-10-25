#!/bin/bash
# tmux setup for use with Browbeat - 1 Controller, 2 CephStorage, 2 Computes
SESSION='browbeat'
ssh_config_home='browbeat/ansible'
compute_name='overcloud-compute'

tmux -2 new-session -d -s $SESSION -n 'undercloud-root'

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


# Single Pane Controller
tmux new-window -t $SESSIION:3 -n 'controller'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0


# Single Pane Cephstorage
tmux new-window -t $SESSIION:4 -n 'cephstorage'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-0" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-1" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0


# Single Pane Computes
tmux new-window -t $SESSIION:5 -n 'computes'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config ${compute_name}-0" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config ${compute_name}-1" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0


tmux select-window -t $SESSION:1

tmux -2 attach-session -t $SESSION
