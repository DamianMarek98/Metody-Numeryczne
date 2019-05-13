import math
from matplotlib import pyplot
import time
import Methods

PROF_DATA = {}

class Matrix:
    f = 1  # third index numebr
    e = 9  # fourth index numebr
    c = 5  # fifth index numebr
    d = 2  # sixth index numebr

    def __init__(self):
        self.N = 9 * self.c * self.d

    def create_Matrix(self, a1, a2, a3):
        matrix = []
        for i in range(self.N):
            row = []
            for j in range(self.N):
                if i == j:
                    row.append(a1)
                elif i - 2 <= j and j <= i + 2:
                    if i - 1 <= j and j <= i + 1:
                        row.append(a2)
                    else:
                        row.append(a3)
                else:
                    row.append(0)
            matrix.append(row)

        return matrix

    def create_VectorB(self):
        vectorB = []
        for i in range(self.N):
            vectorB.append(math.sin((i + 1) * (self.f + 1)))
        return vectorB


def jacobi_method(matrixA, vectorB):
    iteration_number = 0
    vectorX = Methods.vector_zeros(len(matrixA))
    X = Methods.vector_zeros(len(matrixA))
    eps = pow(10, -9) #result limit
    start_time = time.time()

    while True:
        for i in range(len(matrixA)):
            temp = vectorB[i]
            for j in range(len(matrixA)):
                if i != j:
                    temp -= matrixA[i][j] * vectorX[j]
            temp = temp / matrixA[i][i]
            X[i] = temp
        vectorX = Methods.repilcate_vector(X)
        print(iteration_number)
        residuum = Methods.sub_vectors(Methods.scalar(matrixA, vectorX), vectorB)

        if Methods.vector_norm(residuum) < eps:
            break

        iteration_number += 1

    end_time = time.time() - start_time
    print("Jacobi method time: ", end_time)
    print("Number of iterations: ", iteration_number)
    return end_time #time in seconds


def gauss_seidl_method(matrixA, vectorB):
    iteration_number = 0
    vectorX = Methods.vector_zeros(len(matrixA))
    eps = pow(10, -9) #result limit
    start_time = time.time()

    while True:
        for i in range(len(matrixA)):
            temp = vectorB[i]
            for j in range(len(matrixA)):
                if i != j:
                    temp -= matrixA[i][j] * vectorX[j]
            temp = temp / matrixA[i][i]
            vectorX[i] = temp
        print(iteration_number)
        residuum = Methods.sub_vectors(Methods.scalar(matrixA, vectorX), vectorB)

        if Methods.vector_norm(residuum) < eps:
            break

        iteration_number += 1

    end_time = time.time() - start_time
    print("Gauss-Seidl method time: ", end_time)
    print("Number of iterations: ", iteration_number)
    return end_time #time in seconds


def LU_Decomposition(matrixA, vectorB):
    vectorY = Methods.vector_zeros(len(matrixA))
    vectorX = Methods.vector_ones(len(matrixA))
    matrixL = []
    matrixU = []
    start_time = time.time()

    # create L&U base
    for i in range(len(matrixA)):
        tempL = []
        tempU = []
        for j in range(len(matrixA)):
            if i == j:
                tempL.append(1)
            else:
                tempL.append(0)
            tempU.append(0)
        matrixL.append(tempL)
        matrixU.append(tempU)

    # create L&U
    for i in range(len(matrixA)):
        for j in range(i + 1):
            matrixU[j][i] += matrixA[j][i]
            for x in range(j):
                matrixU[j][i] -= matrixL[j][x] * matrixU[x][i]

        for z in range(i + 1, len(matrixA)):
            for x in range(i):
                matrixL[z][i] -= matrixL[z][x] * matrixU[x][i]
            matrixL[z][i] += matrixA[z][i]
            matrixL[z][i] /= matrixU[i][i]

    # solve Ly=b
    for i in range(len(matrixA)):
        value = vectorB[i]
        for j in range(i):
            value -= matrixL[i][j] * vectorY[j]
        vectorY[i] = value / matrixL[i][i]

    # solve Ux=y
    for i in range(len(matrixA) - 1, -1, -1):
        value = vectorY[i]
        for j in range(i + 1, len(matrixA)):
            value -= matrixU[i][j] * vectorX[j]
        vectorX[i] = value / matrixU[i][i]

    end_time = time.time() - start_time
    end_result = Methods.sub_vectors(Methods.scalar(matrixA, vectorX), vectorB)
    norm = Methods.vector_norm(end_result)
    print("norm = ", norm)
    print("duration LU:", end_time)
    return end_time #time in seconds


def main():
    # zad A
    x = Matrix()  #to create matrix and vector for tasks
    matrix_A = x.create_Matrix(x.e + 5, -1, -1)
    vec_B = x.create_VectorB()

    # zad B
    # jacobi_method(matrix_A, vec_B)
    #gauss_seidl_method(matrix_A, vec_B)

    # zadC
    matrix_Ac = x.create_Matrix(3, -1, -1)
    # print(matrix_Ac)
    # jacobi_method(matrix_Ac, vec_B) #after 1272 iterations error "Result too large"
    # gauss_seidl_method(matrix_Ac, vec_B) #after 603 iterations error "Result too large"

    # zadD
    #LU_Decomposition(matrix_Ac, vec_B)

    # zadE
    N = [100,500,1000,2000,3000]
    # vectors holding results
    jacobi_method_time = []
    gauss_seidl_method_time = []
    LU_Decomposition_time = []

    for i in range(len(N)):
        x.N = N[i]
        matrix_A = x.create_Matrix(x.e + 5, -1, -1)
        vec_B = x.create_VectorB()
        jacobi_method_time.append(jacobi_method(matrix_A, vec_B))
        gauss_seidl_method_time.append(gauss_seidl_method(matrix_A, vec_B))
        LU_Decomposition_time.append(LU_Decomposition(matrix_A, vec_B))

    print("Jacobi time: ", jacobi_method_time)
    print("Gauss-Seidl time: ", gauss_seidl_method_time)
    print("LU time time: ", LU_Decomposition_time)

    p1, = pyplot.plot(N, jacobi_method_time, label="jacobi")
    p2, = pyplot.plot(N, gauss_seidl_method_time, label="gauss-seidl")
    p3, = pyplot.plot(N, LU_Decomposition_time, label="lu-decomposition")
    pyplot.legend(('jacobi', 'gauss-seidl', 'lu-decomposition'),
               shadow=True, loc=(0.01, 0.75), handlelength=1.0, fontsize=10)
    pyplot.grid(True)
    pyplot.xlabel("iterations")
    pyplot.ylabel("time [s]")
    pyplot.title("Methods time comparison")
    pyplot.show()


main()
