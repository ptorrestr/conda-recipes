import graph_tool.all as gt
g = gt.Graph(directed=False)
v1 = g.add_vertex()
v2 = g.add_vertex()
e = g.add_edge(v1, v2)
gt.graph_draw(g, vertex_text=g.vertex_index, vertex_font_size=18,
           output_size=(200, 200), output="two-nodes.png")
