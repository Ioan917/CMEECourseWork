# What does each of foo_x do?

# foo_1 finds square root

def foo_1(x):
    return x ** 0.5

# foo_2 returns the larger of the two imput values

def foo_2(x, y):
    if x>y:
        return x
    return y

# foo_3 switches x with y and / or y with z if x > y and / or y > z respectively

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

# foo_4 multiplies 1*2*...*x

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

# foo_5 finds the factorial of x recursively

def foo_5(x):
    if x == 1:
        return 1
    return x * foo_5(x - 1)

# foo_6 calculates the factorial of x using a while statement

def foo_6(x):
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto