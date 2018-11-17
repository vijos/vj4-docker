#!/usr/bin/env python3
import os, sys
import subprocess

args = sys.argv[1:]
cmd = args[0]
arg_list = args[1:]
payload = []

if cmd.startswith('vj4.'):
	payload = [ sys.executable, '-m', cmd ]
	if cmd == 'vj4.server':
		for k, v in os.environ.items(): # using environments start with `VJ_` as arguments
			if k.startswith('VJ_'):
				if k == 'VJ_CMDLINE_FLAGS': # for setting bool flags like `--debug` or `--no-pretty`
					payload.extend(v.split())
				else:
					payload.append('--' + k[3:].lower().replace('_','-'))
					payload.append(v)
	payload.extend(arg_list)
else:
	payload = args

subprocess.call(payload)
