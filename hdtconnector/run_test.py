from hdtconnector.libhdtconnector import HDTConnector
m_map = HDTConnector("etc/test.hdt")
iter = m_map.search("", "", "")
while iter.has_next():
        print( iter.next() )
