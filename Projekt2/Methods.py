def vector_zeros(x):
    vector = []
    for i in range(x):
        vector.append(0)
    return vector


def vector_ones(x):
    vector = []
    for i in range(x):
        vector.append(1)
    return vector


def sub_vectors(a, b):
    result = a
    for i in range(len(a)):
        result[i] -= b[i]
    return result


def add_vectors(a, b):
    result = a
    for i in range(len(a)):
        result[i] += b[i]
    return result


def scalar(a, b):
    result = vector_zeros(len(a))

    for i in range(len(a)):
        for j in range(len(a[0])):
            result[i] += (float)(a[i][j]) * b[j]

    return result


def vector_norm(vec):
    x = 0
    for i in vec:
        x += i ** 2
    return x ** 0.5


def repilcate_vector(toCopy):
    same = []
    for e in toCopy:
        same.append(e)
    return same
