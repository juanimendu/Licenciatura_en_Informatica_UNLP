# DEPENDENCIAS
import numpy as np

# FUNCIÓN OBJETIVO
def function(x, y, f):
    if (f == 1):
        return (x**2 + y**2 + 0.5 * y - 2)
    elif (f == 2):
        return (x**2 * y)

# GRADIENTE DE LA FUNCIÓN OBJETIVO
def gradient(x, y, f):
    if (f == 1):
        df_dx = 2 * x
        df_dy = 2 * y + 0.5
        return (np.array([df_dx, df_dy]))
    elif (f == 2):
        df_dx = 2 * x * y
        df_dy = x**2
        return (np.array([df_dx, df_dy]))

# MÉTODO DE DESCENSO DEL GRADIENTE
def gradient_descent(f, x_init, eta, tolerance=0.0001, max_iterations=1000):

    x = np.array(x_init)
    f_prev = function(x[0], x[1], f)

    for iteration in range(max_iterations):

        grad = gradient(x[0], x[1], f)
        x_new = x - eta * grad
        f_new = function(x_new[0], x_new[1], f)

        print(f"Iteración {iteration + 1}:")
        print(f"x = {x}")
        print(f"grad = {grad}")
        print(f"x_new = {x_new}")
        print(f"f(x) = {f_prev}")
        print(f"f(x_new) = {f_new}")
        print(f"Δf = {abs(f_new - f_prev)}")
        print()

        if (abs(f_new - f_prev) < tolerance):
            print(f"Convergencia alcanzada en la iteración {iteration + 1} para eta = {eta}")
            print()
            break

        x = x_new
        f_prev = f_new

    else:
        print(f"No se alcanzó la convergencia dentro del número máximo de iteraciones ({max_iterations}) para eta = {eta}")

# PARÁMETROS
tolerance = 0.0001
max_iterations = 1000

# EJERCICIO 16 - INCISO (a)

f = 1
x_init = [10, 2]
etas = (0.4, 0.1)
for eta in etas:
    gradient_descent(f, x_init, eta, tolerance, max_iterations)

# EJERCICIO 16 - INCISO (c)

f = 2
x_init = [1, 1]
eta = 0.4
gradient_descent(f, x_init, eta, tolerance, max_iterations)