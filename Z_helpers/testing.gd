@tool
extends EditorScript


func def_test(inf = HitInfo.new()):
	return inf

func _run():
	var inf = def_test()
	print(def_test(), inf)
	if Vector2i.ZERO:
		print("oh no this is considered true")
	else:
		print("ok")
