love.graphics.setDefaultFilter("nearest", "nearest")
local DebiterGenerator = require("randomGen")

local day1Debiters = {}

local totalBalance = 10000
local error = 0
local canInteract = false

local currentIndex = 1
local showData = false

local isDragging = false
local dragOffsetX, dragOffsetY = 0, 0
local cardX, cardY = 60, 425
local originalCardX, originalCardY = 60, 425

function love.load()
    day1Debiters = DebiterGenerator.generateDay1Debiters(20)

    for i, debiter in ipairs(day1Debiters) do
        print(i .. ". " .. debiter.name .. " - PIN: " .. debiter.pin)
    end
    credsSetup = love.graphics.newImage("sprites/CredsSetup.png")
    SetupBG = love.graphics.newImage("sprites/SetupBG.png")

    for _, debiter in ipairs(day1Debiters) do
        debiter.sprite = love.graphics.newImage(debiter.characterPath)
        debiter.cardSprite = love.graphics.newImage(debiter.cardPath)
        debiter.detailSprite = love.graphics.newImage(debiter.detailsPath)
    end
end

function love.keypressed(key)
    if key == "space" then
        if currentIndex <= #day1Debiters then
            showData = true
        else
            showData = false
        end
    end
    if key == "y" and canInteract then
        if day1Debiters[currentIndex].balance >= day1Debiters[currentIndex].debtAmount then
            if totalBalance >= day1Debiters[currentIndex].debtAmount then
                if day1Debiters[currentIndex].pin == day1Debiters[currentIndex].enteredPin then
                    totalBalance = totalBalance - day1Debiters[currentIndex].debtAmount
                    currentIndex = currentIndex + 1
                else
                    totalBalance = totalBalance - day1Debiters[currentIndex].debtAmount
                    currentIndex = currentIndex + 1
                    error = error + 1
                end
            else
                print("No amount")
                totalBalance = totalBalance - day1Debiters[currentIndex].debtAmount
                error = error + 1
                currentIndex = currentIndex + 1
            end
        else
            print("Insufficient Balance")
            totalBalance = totalBalance - day1Debiters[currentIndex].debtAmount
            error = error + 1
            currentIndex = currentIndex + 1
        end
        canInteract = false
        cardX, cardY = 60, 425
    end
    if key == "n" and canInteract then
        if day1Debiters[currentIndex].balance >= day1Debiters[currentIndex].debtAmount and not day1Debiters[currentIndex].paid then
            if totalBalance >= day1Debiters[currentIndex].debtAmount then
                if day1Debiters[currentIndex].pin ~= day1Debiters[currentIndex].enteredPin then
                    currentIndex = currentIndex + 1
                else
                    error = error + 1
                    currentIndex = currentIndex + 1
                end

            else
                print("No amount")
                currentIndex = currentIndex + 1
            end
        else
            print("Insufficient Balance")
            currentIndex = currentIndex + 1
        end
        canInteract = false
        cardX, cardY = 60, 425
    end
end


function love.update(dt)
    local debtor = day1Debiters[currentIndex]
    if isDragging and cardX > 200 and not canInteract then
        debtor.cardSprite = love.graphics.newImage(debtor.detailsPath)
        originalCardX, originalCardY = 350, 200
    end
    if isDragging and cardX < 200 and canInteract then
        debtor.cardSprite = love.graphics.newImage(debtor.cardPath)
        originalCardX, originalCardY = 60, 425
    end
end

function love.draw()
    love.graphics.draw(credsSetup, 0, 200, nil, 5)
    love.graphics.draw(SetupBG, 0, 200, nil, 5)
    love.graphics.print("TotalBalance: " .. totalBalance, 10, 10)
    love.graphics.print("ErrorCount: " .. error, 10, 25)
    if showData and day1Debiters[currentIndex] then
        local debtor = day1Debiters[currentIndex]
        love.graphics.draw(debtor.cardSprite, cardX, cardY, nil, 2)
        love.graphics.draw(debtor.sprite, 85, 230, nil, 3)
        if canInteract then
            --love.graphics.draw(debtor.detailSprite, 350, 200, nil, 2)
            love.graphics.print(debtor.name, 510, 340)
            love.graphics.print("Required Pin: " .. debtor.pin, 575, 465)
            love.graphics.print("Inserted Pin: " .. debtor.enteredPin, 575, 490) 
            love.graphics.print(debtor.balance, 540, 405)
            love.graphics.print(debtor.debtAmount, 540, 435)
            love.graphics.print("Press [Y] to accept", 400, 465)
            love.graphics.print("Press [N] to reject", 400, 490)
        end
    else
        love.graphics.print("Press [Space] to start showing debtors", 400, 300)
    end
end

function love.mousepressed(x, y, button)
    if button == 1 and showData and day1Debiters[currentIndex] then
        local debtor = day1Debiters[currentIndex]
        local cardWidth = debtor.cardSprite:getWidth() * 1.25
        local cardHeight = debtor.cardSprite:getHeight() * 1.25

        if x >= cardX and x <= cardX + cardWidth and y >= cardY and y <= cardY + cardHeight then
            isDragging = true
            dragOffsetX = x - cardX
            dragOffsetY = y - cardY
        end
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then
        isDragging = false
        cardX = originalCardX
        cardY = originalCardY
        if cardX > 200 then
            canInteract = true
        end
    end
end

function love.mousemoved(x, y, dx, dy)
    if isDragging then
        cardX = x - dragOffsetX
        cardY = y - dragOffsetY
    end
end
