local ball = {
    x = 400,
    y = 300,
    m = 1,
    v_x = 0,
    v_y = 0,
    a_x = 0,
    a_y = 0,
    r = 20,
    r_dz = 0,
    l = 60
}

local k = 70
local k_max = 500
local damping = 10

function love.draw()
    love.graphics.print("Velocity: "..math.sqrt(ball.v_x * ball.v_x + ball.v_y * ball.v_y))

    love.graphics.circle("fill", ball.x, ball.y, ball.r)
    love.graphics.circle("line", ball.x, ball.y, ball.r_dz)
end

function love.load()

end

function love.update(dt)
    local mouse_x, mouse_y = love.mouse.getPosition()

    local d_x = mouse_x - ball.x
    local d_y = mouse_y - ball.y

    local displacement_x = 0
    local displacement_y = 0
    local distance = math.sqrt(d_x * d_x + d_y * d_y)

    -- Dead zone
    if distance > ball.r_dz then
        local scale = (distance - ball.r_dz) / distance
        displacement_x = d_x * scale
        displacement_y = d_y * scale
    end

    -- Calculate acceleration
    ball.a_x = (k * displacement_x) / ball.m
    ball.a_y = (k * displacement_y) / ball.m
    
    if distance > ball.l then
        local excess = distance - ball.l
        local n_x = d_x / distance
        local n_y = d_y / distance

        ball.a_x = ball.a_x + k_max * excess * n_x / ball.m
        ball.a_y = ball.a_y + k_max * excess * n_y / ball.m
    end

    -- Calculate velocity
    ball.v_x = ball.v_x + (ball.a_x * dt)
    ball.v_y = ball.v_y + (ball.a_y * dt)

    -- Apply damping
    local decay = math.exp(-damping * dt)
    ball.v_x = ball.v_x * decay
    ball.v_y = ball.v_y * decay
    
    -- Calculate the ball's new position
    ball.x = ball.x + (ball.v_x * dt)
    ball.y = ball.y + (ball.v_y * dt)
end