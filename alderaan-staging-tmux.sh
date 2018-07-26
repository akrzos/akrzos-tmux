#!/bin/bash
# tmux setup for use with Alderaan
SESSION='alderaan-staging-overcloud'
ssh_config_home='/home/stack/browbeat/ansible'
compute_name='overcloud-compute'

tmux -2 new-session -d -s $SESSION -n 'uc-root'

# Stack user window
tmux new-window -t $SESSION:1 -n 'uc-stackrc'
tmux send-keys "su - stack" C-m
tmux send-keys ". stackrc" C-m

# Stack user sourced overcloudrc window
tmux new-window -t $SESSION:2 -n 'uc-overcloudrc'
tmux send-keys "su - stack" C-m
tmux send-keys ". overcloudrc" C-m

# Single Pane Browbeat Ansible
tmux new-window -t $SESSION:3 -n 'ansible'
tmux send-keys "su - stack" C-m
tmux send-keys "cd /home/stack/browbeat/ansible" C-m

# Single Pane Controller
# Controller/Window:
tmux new-window -t $SESSION:4 -n 'con0'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m

# Single Pane Cephs 0,1,2
tmux new-window -t $SESSION:5 -n 'Cephs'
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
tmux split-window -h
tmux select-pane -t 2
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-2" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0

# Single Pane Computes
tmux new-window -t $SESSION:6 -n 'computes'
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

# Single Pane Computes
tmux new-window -t $SESSION:7 -n 'computes'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config ${compute_name}-2" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config ${compute_name}-3" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0

tmux select-window -t $SESSION:2

tmux -2 attach-session -t $SESSION
