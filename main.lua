local ball = {
    x = 400,
    y = 300,
    r = 20,
    vx = 0,
    vy = 0
}

local m_start = {
    x = 0,
    y = 0
}

local displacement = 0

function love.draw()
    love.graphics.circle("fill", ball.x, ball.y, ball.r)
    love.graphics.print("Mouse vector magnitude: "..displacement)
    love.graphics.print("Velocity: "..ball.vx, 0, 20)
end

function love.load()
end

local function push_ball(dx, dy)
    ball.vx = dx
    ball.vy = dy
end

function love.update(dt)
    local damping = 1
    local decay = math.exp(-damping * dt)

    ball.vx = ball.vx * decay
    ball.vy = ball.vy * decay

    ball.x = ball.x + (ball.vx * dt)
    ball.y = ball.y + (ball.vy * dt)
end

function love.mousepressed(x, y)
    m_start = {
        x = x,
        y = y
    }
end

function love.mousereleased(x, y) 
    local dx = m_start.x - x
    local dy = m_start.y - y

    push_ball(dx, dy)
end