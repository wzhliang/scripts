#!/usr/bin/python

import pxssh
import uuid

host = '192.168.1.200'
user = 'root'
passwd = '######'
debug = 1

def _debug_(msg):
	if debug:
		print "### %s" % msg

class Server():
	def __init__(self, h, u, p):
		self.h = h
		self.u = u
		self.p = p
		self.s = None

	def connect(self):
		_debug_("connecting...")
		self.s = pxssh.pxssh()
		self.s.login(self.h, self.u, self.p)
		self.s.timeout = 20000

	def run_cmd(self, cmd):
		_debug_("run_cmd: %s" % cmd)
		self.s.sendline(cmd)
		self.s.prompt()
		return self.s.before

	#def run_script(self, script):
		#ret = []
		#f = open(script, 'rt')
		#for l in f:
			#ret.append(self.run_cmd(l))
		#f.close()
		#return ret

	def run_script2(self, script):
		fn = "farmman-%s.sh" % uuid.uuid4()
		f = open(script, 'rt')
		for l in f:
			self.run_cmd("echo %s >> %s" % (l.strip(), fn))
		f.close()
		ret = self.run_cmd("sh %s" % fn)
		ret += "\n\n\n\n"
		ret += self.run_cmd("cat %s" %fn)
		return ret

	def exit(self):
		self.s.logout()
		

def t_simple():
	print "@@@ t_simple"
	sh = Server(host, user, passwd)
	sh.connect()
	print sh.run_cmd('uptime')
	print sh.run_cmd('ls -l')
	print sh.run_cmd('df')
	print sh.run_cmd('mount')
	sh.exit()

def t_script2(sn):
	print "@@@ t_script2"
	sh = Server(host, user, passwd)
	sh.connect()
	print sh.run_script2(sn)
	sh.exit()

def main():
	t_simple()
	t_script2('fm_test.sh')

if __name__ == '__main__':
	main()
