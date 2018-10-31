#!/bin/sh

release_ctl eval --mfa "MachineMonitor.Tasks.ReleaseTasks.migrate/0" --argv -- "$@"