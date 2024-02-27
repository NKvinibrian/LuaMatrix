
-- Matrix Class
local Matrix = {}

-- Create new intance
-- @param matrix table/array with values {{1,2,3}, ...}
-- @return new intance
function Matrix:new(matrix)
    matrix = matrix or {}
    local lMax = #matrix
    local cMax = 0
    if lMax ~= 0 then
        cMax = #matrix[1]
    end

    local newIntance = {
        matrix = matrix,
        columsSize = cMax,
        linesSize = lMax,
        matrixSize = lMax * cMax,
    }

    setmetatable(newIntance, self)
    self.__index = self
    return newIntance
end

-- Returns the size of matrix
-- @return the size of matrix
function Matrix:size()
    return self.matrixSize
end

-- Print all values ​​in the matrix
function Matrix:print()
    print('\n')
    for index, value in ipairs(self.matrix) do
        print(self:dump(value))
    end
    print('\n')
end

-- Dump all values to prints
-- @return string line of matrix
function Matrix:dump(o)
    if type(o) == 'table' then
       local s = ''
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. ' ' ..  self:dump(v)
       end
       return s
    else
       return tostring(o)
    end
 end

-- Cheack if size is equal MatrixA == MatrixB
-- @param matrix matrixB object
function Matrix:sizeCheack(matrix)
    if self.matrixSize == matrix.matrixSize then
        return
    end
    error("Matrix size does not match")
end

-- Sum MatrixA with MatrixB
-- @param matrix matrixB object
-- @return new matrix instance
function Matrix:sum(matrix)
    self:sizeCheack(matrix)
    local newMatrix = {}
    for index1, value1 in ipairs(self.matrix) do
        newMatrix[index1] = {}
        for index2, value2 in ipairs(value1) do
            newMatrix[index1][index2] = value2 + matrix.matrix[index1][index2]
        end
    end
    return Matrix:new(newMatrix)
end

-- Multiply Matrix by a number
-- @param number value for multiplication
-- @return new matrix instance
function Matrix:sMul(number)
    local newMatrix = {}
    for index1, value1 in ipairs(self.matrix) do
        newMatrix[index1] = {}
        for index2, value2 in ipairs(value1) do
            newMatrix[index1][index2] = value2 * number
        end
    end
    return Matrix:new(newMatrix)
end

-- Subtraction MatrixA with MatrixB
-- @param matrix matrixB object
-- @return new matrix instance
function Matrix:sub(matrix)
    self:sizeCheack(matrix)
    -- Matrix subtraction is equal matrixA +(-1 * matrixB)
    local negMatrix = matrix:sMul(-1)
    return self:sum(negMatrix)
end

-- Tranpose matrix
-- @return new matrix instance
function Matrix:transpose()
    local newMatrix = {}
    for c = 1, self.columsSize, 1 do
        newMatrix[c] = {}
        for l = 1, self.linesSize, 1 do
            newMatrix[c][l] = self.matrix[l][c]
        end
    end
    return Matrix:new(newMatrix)
end

-- Checks if size of line is equal size of columns
-- @param matrix matrixB object
function Matrix:linesCheck(matrix)
    if matrix.linesSize ~= self.columsSize or matrix.columsSize ~= self.columsSize then
        error("Size of lines and colums does not match")
    end
end

-- Multiply matriA with matrixB
-- @param matrix matrixB object
-- @return new matrix instance
function Matrix:matrixMul(matrix)
    self:linesCheck(matrix)
    -- Create a new empty matrix to store the result
    local newMatrix = {}
    for i = 1, self.linesSize do
        newMatrix[i] = {}
        for j = 1, matrix.columsSize do
        newMatrix[i][j] = 0
        end
    end

    -- Perform matrix multiplication using nested loops with correct indexing
    for i = 1, self.linesSize do
        for j = 1, matrix.columsSize do
            for k = 1, self.columsSize do
                newMatrix[i][j] = newMatrix[i][j] + self.matrix[i][k] * matrix.matrix[k][j]
            end
        end
    end
    return self:new(newMatrix)
end

return Matrix

