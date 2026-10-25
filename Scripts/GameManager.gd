extends Node

var money = 0

signal MoneyChanged(newAmount)

func AddMoney(amount: int):
	money += amount
	MoneyChanged.emit(money)

func SpendMoney(amount: int) ->bool: #return a bool in case i wanna add something when youre broke
	if money >= amount:
		money -+ amount
		MoneyChanged.emit(money)
		return true
	else:
		return false
