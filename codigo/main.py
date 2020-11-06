def buscar_animal(animais, identificacao_animal, inicio = 0, fim = 0):

    if (inicio == 0 and fim == 0):
        meio = len(animais) // 2
    else:
        meio = (inicio + fim) // 2

    if animais[meio] == identificacao_animal:
        return meio

    if inicio >= fim - 1 and fim > 0:
        return -1
    else:
        if identificacao_animal < animais[meio]:
            return buscar_animal(animais, identificacao_animal, inicio, meio)
        elif identificacao_animal > animais[meio]:
            return buscar_animal(animais, identificacao_animal, meio, len(animais))


animais = [1, 2, 3, 5, 9, 15, 25, 30, 32, 45, 50, 90]

print(buscar_animal(animais, 9))
print(buscar_animal(animais, 91))
