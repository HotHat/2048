extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


const RADIUS = 5
const POSITION = Vector2(0, 0)


export(int) var width =  500
export(int) var height =  500
export(int) var tile_row = 4
export(int) var tile_column = 4

var item_temp = preload("res://background/BackgroundItem.tscn")
var style = StyleBoxFlat.new()
var size = Vector2(width, width)
var margin = 10
var sub_tile_width = 0
var sub_tile_height = 0
var sub_tile_pos_matrix = []

# Called when the node enters the scene tree for the first time.
func _ready():
	style.set_corner_radius_all(RADIUS)
	style.bg_color = Color("bbada0")
	
	
	
	pass # Replace with function body.

func draw_children():
	sub_tile_height = int((width - (tile_row+1)*margin) / tile_row)
	sub_tile_width = int((height - (tile_column+1)*margin) / tile_column)
	
	print("sub_tile_width: ", sub_tile_width)
	print("sub_tile_height: ", sub_tile_height)
	
	for row in range(tile_row):
		var row_mtr = []
		for colomn in range(tile_column):
			var item = item_temp.instance()
			item.size = Vector2(sub_tile_width, sub_tile_height)
			#item.position = Vector2(colomn*sub_tile_height+(colomn+1)*margin, row*sub_tile_width+(row+1)*margin)
			item.position = Vector2(colomn*sub_tile_width+(colomn+1)*margin, row*sub_tile_height+(row+1)*margin)
			add_child(item)
			row_mtr.append(Vector2(position.x+item.position.x+sub_tile_width/2, position.y+item.position.y+sub_tile_height/2))
		sub_tile_pos_matrix.append(row_mtr)

func get_tile_width():
	return sub_tile_width
	
func get_tile_height():
	return sub_tile_height

func get_tile_size():
	return Vector2(sub_tile_width, sub_tile_height)

func get_pos_matrix():
	return sub_tile_pos_matrix

func set_row_column(row, col, size):
	self.tile_row = row
	self.tile_column = col
	set_size(size)
	print("draw_background position: ", position, tile_row, tile_column, size)
	draw_children()
	update()

func set_size(size):
	width = size.x
	height = size.y
	self.size = size
#	draw_children()

func _draw():
	draw_style_box(style, Rect2(POSITION, size))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
