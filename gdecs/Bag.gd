class_name Bag

var _arr: Array = []

func _init(size: int):
	_arr.resize(size)

func get_o(index: int):
	return _arr[index]

func set_o(index: int, o):
	if index <= _arr.size() - 1:
		_arr[index] = o
	else:
		_arr.resize(_arr.size() + ((index + 1) - _arr.size()))

func add_o(o):
	_arr.append(o)

func remove(index: int):
	set_o(index, null)
