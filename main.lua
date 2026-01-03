local ball = {
    x = 400,
    y = 300,
    v_x = 0,
    v_y = 0,
    m = 1,
}

local pivot = {
    x = 400,
    y = 300
}

local k_pivot = 200
local k_mouse = 400
local velocity = 0
local damping = 0.5

function love.draw()
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.print("Velocity: "..velocity)
    love.graphics.circle("fill", ball.x, ball.y, 20)
end

function love.load()
end

function love.update(dt)
    velocity = math.sqrt(ball.v_x * ball.v_x + ball.v_y * ball.v_y)
    local decay = math.exp(-damping * dt)

    -- Calculate ball displacement from pivot
    local d_x = pivot.x - ball.x
    local d_y = pivot.y - ball.y

    -- Calculate acceleration towards pivot
    local a_x = (k_pivot * d_x) / ball.m
    local a_y = (k_pivot * d_y) / ball.m

    -- Mouse calculations
    local ma_x = 0
    local ma_y = 0
    if love.mouse.isDown(1) then
        ball.v_x = 0
        ball.v_y = 0

        -- Calculate mouse displacement from ball
        local mouse_x, mouse_y = love.mouse.getPosition()
        local md_x = mouse_x - ball.x
        local md_y = mouse_y - ball.y
    
        -- Calculate acceleration towards mouse
        ma_x = 3 * (k_mouse * md_x) / ball.m
        ma_y = 3 * (k_mouse * md_y) / ball.m
    end

    -- Calculate total velocity
    ball.v_x = (ball.v_x + ((a_x + ma_x) * dt)) * decay
    ball.v_y = (ball.v_y + ((a_y + ma_y) * dt)) * decay 

    -- Update location of ball
    ball.x = ball.x + (ball.v_x * dt)
    ball.y = ball.y + (ball.v_y * dt)
end