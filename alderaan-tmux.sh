#!/bin/bash
# tmux setup for use with Alderaan
SESSION='alderaan-overcloud'
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
tmux new-window -t $SESSIION:3 -n 'ansible'
tmux send-keys "su - stack" C-m
tmux send-keys "cd /home/stack/browbeat/ansible" C-m

# Single Pane Controllers
tmux new-window -t $SESSIION:4 -n 'controllers'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-1" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -h
tmux select-pane -t 2
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-2" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0

# Single Pane Cephs 0 and 1
tmux new-window -t $SESSIION:5 -n 'cephs-0-1'
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

# Single Pane Cephs 2 and 3
tmux new-window -t $SESSIION:6 -n 'cephs-2-3'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-2" C-m
tmux send-keys "sudo su -" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-3" C-m
tmux send-keys "sudo su -" C-m
tmux select-pane -t 0

# Single Pane Cephs 4
tmux new-window -t $SESSIION:7 -n 'cephs-4'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-cephstorage-4" C-m
tmux send-keys "sudo su -" C-m

# Single Pane Computes
tmux new-window -t $SESSIION:8 -n 'computes'
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

# Controller/Window:
tmux new-window -t $SESSIION:9 -n 'con0'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-0" C-m
tmux send-keys "sudo su -" C-m
tmux new-window -t $SESSIION:10 -n 'con1'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-1" C-m
tmux send-keys "sudo su -" C-m
tmux new-window -t $SESSIION:11 -n 'con2'
tmux send-keys "su - stack" C-m
tmux send-keys "cd ${ssh_config_home}" C-m
tmux send-keys "ssh -F ssh-config overcloud-controller-2" C-m
tmux send-keys "sudo su -" C-m

tmux select-window -t $SESSION:2

tmux -2 attach-session -t $SESSION
