from bitstring import BitArray #instalada com pip
import itertools

def bin2int(a):
    b = BitArray(bin=a)
    return b.int

def int2bin(a, length):
    # para valores unsigned, usamos uint=a ao inves de int=a
    b = BitArray(int=a, length = length) # lenght eh o tamanho da string binaria
    return b.bin

BITS_INTRUCAO = 4
BITS_ENTRADA = 4
BITS_SAIDA = 8

input_f = open("entradas.txt","w")
output_f = open("saidas_soma.txt","w")
testes_instru = range(-8,8)
testes_a = range(-8, 8)
testes_b = range(-8, 8)

for instru,a,b in itertools.product(testes_instru, testes_a, testes_b):
    sub_1 = (a - 1)
    sum_1 = (a + 1)
    
    bin_a = int2bin(a, BITS_ENTRADA)
    bin_b = int2bin(b, BITS_ENTRADA)

    lista = bin_a.split()
    listb = bin_b.split()
    separator = ''
    if (instru == 1):
        res = a + b #minha saida de referencia

    elif (instru == 2):
        res = a - b

    elif (instru == 3):
        res = sum_1

    elif (instru == 4):
        res = sub_1

    elif (instru == 5):
        for i in range(4):
            if lista[i] == 1:
                lista[i] = "um"
            elif lista[i] == 0:
                lista[i] = "zero"
        if (0 not in lista and 1 not in lista):
            for i in range(4):
                if lista[i] == "um":
                    lista[i] = 0
                elif lista[i] == "zero":
                    lista[i] = 1
        res = bin2int(separator.join(map(bin, lista)))
    
    elif (instru == 6):
        lista_result = [1, 1, 1, 1]
        for i in range (4):
            if (lista[i] == 1 and listb[i] == 1):
                lista_result[i] = 1
            else:
                lista_result[i] = 0
        res = bin2int(separator.join(map(bin, lista_result)))

    elif (instru == 7):
        lista_result = [0, 0, 0, 0]
        for i in range (4):
            if (lista[i] == 0 and listb[i] == 0):
                lista_result[i] = 0
            else:
                lista_result[i] = 1
        res = bin2int(separator.join(map(bin, lista_result)))
        
    elif (instru == -8):
        lista_result = [0, 0, 0, 0]
        for i in range (4):
            if ((lista[i] == 0 and listb[i] == 0) or (lista[i] == 1 and listb[i] == 1)):
                lista_result[i] = 0
            else:
                lista_result[i] = 1
        res = bin2int(separator.join(map(bin, lista_result)))

    elif (instru == -7):
        res = a * b

    elif (instru == -6):
        if (b != 0 and a != 0):
            res = round(a / b)
        else:  
            res = a

    else:
        res = a


    bin_instru = int2bin(instru, BITS_INTRUCAO)
    bin_res = int2bin(res, BITS_SAIDA)

    if (instru in [1, 2, 3, 4, 5, 6, 7, 8, -8, -7, -6]):
        print(bin_res, file = output_f)
    
    elif (instru == 0):
        print("Sem operacao", file = output_f)
    
    else:
        print("halt", file = output_f)
    
    print(f'{bin_instru} {bin_a} {bin_b}', file = input_f)
    

input_f.close()
output_f.close()
