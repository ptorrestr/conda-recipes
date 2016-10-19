./waf --help > /dev/null
#See https://bugs.freedesktop.org/show_bug.cgi?id=76759
echo "--- .waf3-1.6.4-e3c1e08604b18a10567cfcd2d02eb6e6/waflib/Build.py 
+++ .waf3-1.6.4-e3c1e08604b18a10567cfcd2d02eb6e6/waflib/Build.py        
@@ -162,6 +162,8 @@
			try:
				f=open(db+'.tmp','wb')
				cPickle.dump(data,f)
+			except AttributeError as err:
+				print(format(err))
			finally:
				if f:
					f.close()" > ./waf.patch1
# See http://stackoverflow.com/questions/29654934/installing-py2cairo-issues-on-ubuntu-14-04/32684224#32684224
echo "-- .waf3-1.6.4-e3c1e08604b18a10567cfcd2d02eb6e6/waflib/Tools/python.py
+++ .waf3-1.6.4-e3c1e08604b18a10567cfcd2d02eb6e6/waflib/Tools/python.py
@@ -169,1 +169,1 @@
-		for incstr in conf.cmd_and_log(conf.env.PYTHON+[conf.env.PYTHON_CONFIG,'--includes']).strip().split():
+		for incstr in conf.cmd_and_log([conf.env.PYTHON_CONFIG, '--includes']).strip().split():" > ./waf.patch2

patch -p 0 < ./waf.patch1
patch -p 0 < ./waf.patch2
./waf configure --prefix=${PREFIX}
./waf build
./waf install

