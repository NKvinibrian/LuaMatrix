local matrixLib = require("matrix")


local matrix1 = matrixLib:new({
    {1, 3, 1},
    {1, 0, 0},
    {2, 0, 1},
})
local matrix2 = matrixLib:new({
    {0, 0, 5},
    {7, 5, 0},
    {2, 5, 10},
})

print("Matrix 1 size: ".. matrix1:size())
print("Matrix 2 size: ".. matrix2:size())

matrix1:print()
matrix2:print()

local sumMatrix = matrix1:sum(matrix2)
sumMatrix:print()

local sMulMatrix = matrix2:sMul(-1)
sMulMatrix:print()


local subMatrix = matrix1:sub(matrix2)
subMatrix:print()

local tMatrix = matrix1:transpose()
tMatrix:print()

local mMatrix = matrix1:matrixMul(matrix2)
mMatrix:print()