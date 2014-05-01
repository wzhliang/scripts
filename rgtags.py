#/usr/bin/python
import sys
import re
import pdb

class TagGenNoTag(Exception):
	pass
class TagGenWrongPattern(Exception):
	pass

class TagGen:
	def __init__(self, l, exp):
		self.l = l
		self.pat = re.compile(exp)
		self.mobj = None
		self._parse_()

	def _parse_(self):
		self.mobj = re.search(self.pat, self.l)
		if not self.mobj:
			raise TagGenNoTag
		if len(self.mobj.groups()) < 1:
			raise TagGenWrongPattern

	def get_tag(self):
		return self.mobj.group(1)

	def get_ex(self):
		return '/%s/;"' % self.l.strip("\n\r")

	#def __getattr__(self, key):
		#if key == 'tag':
			#return self.mobj.group(1)
		#if key == 'ex':
			#return "/%s/;" % self.l.strip("\n\r")
		#else:
			#return None

def print_enum_tags(hdr):
	f = open(hdr, 'rt')
	for l in f:
		try:
			tag = TagGen(l, "ENUM_START\((\w+)")
			print "%s\t%s\t%s\td" % (tag.get_tag(), hdr, tag.get_ex())
		except TagGenNoTag:
			pass
		try:
			tag = TagGen(l, "ESTR\((\w+)")
			print "%s\t%s\t%s\td" % (tag.get_tag(), hdr, tag.get_ex())
		except TagGenNoTag:
			pass
	f.close()

print_enum_tags(sys.argv[1])

