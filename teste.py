from bitstring import BitArray #instalada com pip
import itertools

def bin2int(a):
    b = BitArray(bin=a)
    return b.int

def int2bin(a, length):
    # para valores unsigned, usamos uint=a ao inves de int=a
    b = BitArray(int = a, length = length) # lenght eh o tamanho da string binaria
    return b.bin

def split(word):
	return [char for char in word]

BITS_INSTRUCAO = int(4)
BITS_ENTRADA = 8
BITS_SAIDA = 16

testes_instru = range(-8,8)

input_f = open("entradas_new.txt","w")
output_f = open("saidas_soma_new.txt","w")

A = [int(32), int(10), int(9), int(128), int(60), int(16), int(5), int(10)]
B = [int(9), int(5), int(66), int(2)]

valor_a = int2bin(A[4], BITS_ENTRADA)
lista = split(valor_a)
valor_b = int2bin(B[2], BITS_ENTRADA)
listb = split(valor_b)
for instru in itertools.product(testes_instru):
    if (instru == 1):
        res = A[0] + B[0] #minha saida de referencia
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[0], BITS_ENTRADA)} {int2bin(B[0], BITS_ENTRADA)}', file = input_f)

    elif (instru == 2):
        res = A[1] - B[1]
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[1], BITS_ENTRADA)} {int2bin(B[1], BITS_ENTRADA)}', file = input_f)

    elif (instru == 3):
        res = A[2] + 1
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[2], BITS_ENTRADA)} {int2bin(B[2], BITS_ENTRADA)}', file = input_f)

    elif (instru == 4):
        res = A[3] - 1
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[3], BITS_ENTRADA)} {int2bin(B[3], BITS_ENTRADA)}', file = input_f)

    elif (instru == 5):
        for i in range(8):
            if lista[i] == 1:
                lista[i] = "um"
            elif lista[i] == 0:
                lista[i] = "zero"
        if (0 == 0):
            for i in range(8):
                if lista[i] == "um":
                    lista[i] = 0
                elif lista[i] == "zero":
                    lista[i] = 1
        pre_res = ''.join(lista)
        res = bin2int(pre_res)
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[4], BITS_ENTRADA)} {int2bin(B[2], BITS_ENTRADA)}', file = input_f)
    
    elif (instru == 6):
        lista_result = ['0', '0', '0', '0', '0', '0', '0', '0']
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[4], BITS_ENTRADA)} {int2bin(B[2], BITS_ENTRADA)}', file = input_f)
        for i in range (8):
            if (lista[i] == '1' and listb[i] == '1'):
                lista_result[i] = '1'
            else:
                lista_result[i] = '0'
        pre_res = ''.join(lista_result)
        res = bin2int(pre_res)

    elif (instru == 7):
        lista_result = ['0', '0', '0', '0', '0', '0', '0', '0']
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[4], BITS_ENTRADA)} {int2bin(B[2], BITS_ENTRADA)}', file = input_f)
        for i in range (8):
            if (lista[i] == '0' and listb[i] == '0'):
                lista_result[i] = '0'
            else:
                lista_result[i] = '1'
        pre_res = ''.join(lista_result)
        res = bin2int(pre_res)
        
    elif (instru == -8):
        lista_result = ['0', '0', '0', '0', '0', '0', '0', '0']
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[4], BITS_ENTRADA)} {int2bin(B[2], BITS_ENTRADA)}', file = input_f)
        for i in range (8):
            if (lista[i] == listb[i]):
                lista_result[i] = '0'
            else:
                lista_result[i] = '1'
        pre_res = ''.join(lista_result)
        res = bin2int(pre_res)

    elif (instru == -7):
        res = A[6]*B[3]
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {int2bin(A[6], BITS_ENTRADA)} {int2bin(B[3], BITS_ENTRADA)}', file = input_f)

    elif (instru == -6):
        print(f'{int2bin(instru, BITS_INSTRUCAO)} {A[-1]} {B[-1]}', file = input_f)
        if (B[-1] != 0 and A[-1] != 0):
            res = round(A[-1] / B[-1])
            
        else:  
            res = '0000000000000000'

    else:
        res = '0000000000000000'

    if (instru == -7):
        bin_res = int2bin(res, BITS_SAIDA)
    else:
        bin_res = int2bin(int(res), 10)

    if (instru in [1, 2, 3, 4, 5, 6, 7, 8, -8, -7, -6]):
        print(bin_res, file = output_f)
    
    elif (instru == 0):
        print("Sem operacao", file = output_f)
    
    else:
        print("halt", file = output_f)
    
    
    

input_f.close()
output_f.close()
