#!/usr/bin/python

from struct import pack

def main():
	# On a 64 bit machine, the following give different result
	# On a 32 bit machine, they are the same
	buf = pack("!BIB", 2, 0x3456, 3)
	f = open('foo.sec', 'wb')
	f.write(buf)

	buf = pack("BIB", 2, 0x3456, 3)
	f.write(buf)
	f.close()


if __name__ == '__main__':
	main()

