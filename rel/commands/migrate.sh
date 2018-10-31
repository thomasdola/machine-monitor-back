#!/bin/sh

release_ctl eval --mfa "MachineMonitor.Tasks.ReleaseTasks.migrate/1" --argv -- "$@"