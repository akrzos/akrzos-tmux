#!/bin/bash
# tmux setup for use with OCP Advanced Deploy
SESSION='ocp-tmux'

tmux -2 new-session -d -s $SESSION -n 'root'

# Stack user window
tmux new-window -t $SESSION:1 -n 'root2'

# Single Pane Masters
tmux new-window -t $SESSION:2 -n 'masters'
tmux send-keys "ssh master1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "ssh master2.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -h
tmux select-pane -t 2
tmux send-keys "ssh master3.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux select-pane -t 0

# Single Pane InfraNodes
tmux new-window -t $SESSION:3 -n 'infranodes'
tmux send-keys "ssh infranode1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "ssh infranode2.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux select-pane -t 0

# Single Pane Nodes
tmux new-window -t $SESSION:4 -n 'nodes'
tmux send-keys "ssh node1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "ssh node2.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -h
tmux select-pane -t 2
tmux send-keys "ssh node3.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux select-pane -t 0

# Single Pane lb / support
tmux new-window -t $SESSION:5 -n 'lb-support'
tmux send-keys "ssh loadbalancer1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux split-window -v
tmux select-pane -t 1
tmux send-keys "ssh support1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux select-pane -t 0

# Master/Window
tmux new-window -t $SESSION:6 -n 'master1'
tmux send-keys "ssh master1.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux new-window -t $SESSION:7 -n 'master2'
tmux send-keys "ssh master2.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m
tmux new-window -t $SESSION:8 -n 'master3'
tmux send-keys "ssh master3.${GUID}.internal" C-m
tmux send-keys "sudo -i" C-m

tmux select-window -t $SESSION:2

tmux -2 attach-session -t $SESSION

