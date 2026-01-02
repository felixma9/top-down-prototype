local ball = {
    x = 400,
    y = 300,
    m = 1,
    v_x = 0,
    v_y = 0,
    a_x = 0,
    a_y = 0
}

local k = 50
local damping = 0.8

function love.draw()
    love.graphics.circle("fill", ball.x, ball.y, 10)
end

function love.load()

end

function love.update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()
    local displacement_x = mouse_x - ball.x
    local displacement_y = mouse_y - ball.y

    -- Calculate acceleration
    ball.a_x = (k * displacement_x) / ball.m
    ball.a_y = (k * displacement_y) / ball.m

    -- Calculate velocity
    ball.v_x = ball.v_x + (ball.a_x * dt)
    ball.v_y = ball.v_y + (ball.a_y * dt)

    -- Apply damping
    ball.v_x = ball.v_x - (ball.v_x * damping * dt)
    ball.v_y = ball.v_y - (ball.v_y * damping * dt)
    
    -- Calculate the ball's new position
    ball.x = ball.x + (ball.v_x * dt)
    ball.y = ball.y + (ball.v_y * dt)
end