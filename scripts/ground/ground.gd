class_name Ground extends StaticBody2D

@export var type: Enums.Ground_Type

signal struck()

func strike():
	struck.emit()
