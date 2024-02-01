extends RoomTileGen

func _ready():
	for x in 8:
		for y in 8:
			bot_right.append(Vector2i(x,y))
	for x in 8:
		for y in 8:
			top_right.append(Vector2i(x,(y*-1)-1))
	for x in 8:
		for y in 8:
			bot_left.append(Vector2i((x*-1)-1,y))
	for x in 8:
		for y in 8:
			top_left.append(Vector2i((x*-1)-1,(y*-1)-1))
	all_workable=[bot_right, bot_left, top_right, top_left]
	for i in all_workable:
		for x in 5:
			clear_chunk(all_workable[all_workable.find(i)])
	place_floor()
