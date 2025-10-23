class_name Action
extends Node

enum TARGET_TYPES {SINGLE_ALLY, SINGLE_ENEMY, PARTY_ALLY, PARTY_ENEMY}

@export var shortName : String
@export var displayName : String
@export var description : String

@export var actor : Character
@export var targetType : TARGET_TYPES
@export var target : Array
@export var cost : int
@export var stat : String
@export var value : int
