extends TileMap
class_name RoomTileGen

var bot_right:Array[Vector2i]
var bot_left:Array[Vector2i]
var top_right:Array[Vector2i]
var top_left:Array[Vector2i]
var top:Array[Vector2i]
var bot:Array[Vector2i]
var left:Array[Vector2i]
var right:Array[Vector2i]

var all_workable:Array

var cell = Vector2i(3,5)

func get_neighbor_data(sel_cell:Vector2i):
	var neighbors = get_surrounding_cells(sel_cell)
	var n_data:Dictionary={}
	for n in neighbors:
		n_data[n] = get_cell_tile_data(0,n)
	return n_data
	
func clear_chunk(quadrant:Array[Vector2i]):
	var random = []
	for c in quadrant:
		var n_data = get_neighbor_data(c)
		var touches_air:bool=false
		for key in n_data:
			if n_data[key].get_custom_data("tile_type")=="air":
				if get_cell_tile_data(0,c).get_custom_data("tile_type")=="contact":
					touches_air=true
		if touches_air:
			random.append(c)
	random.shuffle()
	var sel:Array[Vector2i]=[]
	sel.append(random[0])
	while sel.size() < 2:
		for i in sel:
			if get_cell_tile_data(0, get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).get_custom_data("tile_type") == "air":
				if quadrant.has(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_LEFT_SIDE)):
					sel.append(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_LEFT_SIDE))
					break
			if get_cell_tile_data(0, get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_LEFT_SIDE)).get_custom_data("tile_type") == "air":
				if quadrant.has(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_RIGHT_SIDE)):
					sel.append(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
					break
			if get_cell_tile_data(0, get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).get_custom_data("tile_type") == "air":
				if quadrant.has(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_TOP_SIDE)):
					sel.append(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_TOP_SIDE))
					break
			if get_cell_tile_data(0, get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_TOP_SIDE)).get_custom_data("tile_type") == "air":
				if quadrant.has(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
					sel.append(get_neighbor_cell(i,TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
					break
			if sel.size() < 2:
				random.shuffle()
				sel[0] = random[0]
	
	set_cells_terrain_connect(0, sel, 0, 0)
	
	var coin_flip = randi_range(1,2)
	if coin_flip == 1:
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_TOP_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_TOP_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_LEFT_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_LEFT_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
	elif coin_flip == 2:
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_TOP_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_TOP_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_RIGHT_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_RIGHT_SIDE))
		if get_cell_tile_data(0, get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_TOP_SIDE)).get_custom_data("tile_type") == "air":
			if quadrant.has(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE)):
				sel.append(get_neighbor_cell(sel[-1],TileSet.CELL_NEIGHBOR_LEFT_SIDE))
			if quadrant.has(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_LEFT_SIDE)):
				sel.append(get_neighbor_cell(sel[0],TileSet.CELL_NEIGHBOR_LEFT_SIDE))
				
	set_cells_terrain_connect(0, sel, 0, 0)

func place_floor():
	for x in all_workable:
		for i in x:
			var open:bool=true
			var n_data:Dictionary=get_neighbor_data(i)
			for n in n_data:
				if n_data[n].get_custom_data("tile_type") != "air":
					open = false
			if open:
				set_cell(0,i,0,Vector2i(5,5))
				if x.has(Vector2i(i.x+1, i.y)):
					if get_cell_tile_data(0,Vector2i(i.x+1, i.y)).get_custom_data("tile_type") == "air":
						set_cell(0,Vector2i(i.x+1, i.y),0,Vector2i(5,5))
	for x in all_workable:
		for i in x:
			if get_cell_tile_data(0,i).get_custom_data("tile_type") == "contact":
				var n_data = get_neighbor_data(i)
				for n in n_data:
					if n_data[n].get_custom_data("tile_type") == "floating":
						set_cell(0,n,0,Vector2i(7,4))
			if get_cell_tile_data(0,i).get_custom_data("tile_type") == "floating":
				if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_BOTTOM_SIDE)).get_custom_data("tile_type")=="floating":
					set_cell(0,i,0,Vector2i(7,4))
				if get_cell_tile_data(0, get_neighbor_cell(i, TileSet.CELL_NEIGHBOR_TOP_SIDE)).get_custom_data("tile_type")=="floating":
					set_cell(0,i,0,Vector2i(7,4))
	for x in 10:
		if get_cell_tile_data(0,Vector2i(x,1)).get_custom_data("tile_type") == "air":
			set_cell(0,Vector2i(x,1), 0, Vector2i(5,5))
	for x in 10:
		if get_cell_tile_data(0,Vector2i((x*-1),1)).get_custom_data("tile_type") == "air":
			set_cell(0,Vector2i(x*-1,1), 0, Vector2i(5,5))
	"""		
	if get_cell_tile_data(0,Vector2i(9,0)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(9,0), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(9,-1)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(9,-1), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(-10,0)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(-10,0), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(-10,-1)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(-10,-1), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(0,9)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(0,9), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(-1,9)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(-1,9), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(0,-10)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(0,-10), 0, Vector2i(5,4))
	if get_cell_tile_data(0,Vector2i(-1,-10)).get_custom_data("tile_type") != "contact":
		set_cell(0,Vector2i(-1,-10), 0, Vector2i(5,4))
	"""
