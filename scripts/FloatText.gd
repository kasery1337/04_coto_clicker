extends Label

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, 'position:y', position.y - 4, 1.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, 'modulate:a', 0.0, 0.5)
	tween.finished.connect(queue_free)
