love.graphics.setDefaultFilter("nearest", "nearest")

local totalBalance = 10000
local error = 0

local day1Debiters = {
    {
        name = "Siddharth.S",
        balance = 4000,
        debtAmount = 3000,
        paid = false
    },
    {
        name = "Suresh.R",
        balance = 1000,
        debtAmount = 2000,
        paid = false
    },
    {
        name = "Ramesh.R",
        balance = 2000,
        debtAmount = 2000,
        paid = false
    },
    {
        name = "Vignesh.R",
        balance = 4000,
        debtAmount = 7000,
        paid = false
    },
    {
        name = "Ganesh.R",
        balance = 4000,
        debtAmount = 100000,
        paid = false
    }
}

local currentIndex = 1
local showData = false

function love.keypressed(key)
    if key == "space" then
        if currentIndex <= #day1Debiters then
            showData = true
        else
            showData = false
        end
    end
    if key == "y" then
        if day1Debiters[currentIndex].balance >= day1Debiters[currentIndex].debtAmount and not day1Debiters[currentIndex].paid then
            if totalBalance >= day1Debiters[currentIndex].debtAmount then
                totalBalance = totalBalance - day1Debiters[currentIndex].debtAmount
                day1Debiters[currentIndex].paid = true
                currentIndex = currentIndex + 1
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
    end
    if key == "n" then
        if day1Debiters[currentIndex].balance >= day1Debiters[currentIndex].debtAmount and not day1Debiters[currentIndex].paid then
            if totalBalance >= day1Debiters[currentIndex].debtAmount then
                error = error + 1
                currentIndex = currentIndex + 1
            else
                print("No amount")
                currentIndex = currentIndex + 1
            end
        else
            print("Insufficient Balance")
            currentIndex = currentIndex + 1
        end
    end
end
function love.load()
    credsSetup = love.graphics.newImage("sprites/CredsSetup.png")
end

function love.draw()
    love.graphics.draw(credsSetup, 0, 200, nil, 5)
    love.graphics.print("TotalBalance: " .. totalBalance, 10, 10)
    love.graphics.print("ErrorCount: " .. error, 10, 25)
    if showData and day1Debiters[currentIndex] then
        local debtor = day1Debiters[currentIndex]
        love.graphics.print("Name: " .. debtor.name, 400, 300)
        love.graphics.print("Balance: " .. debtor.balance, 400, 330)
        love.graphics.print("Debt Amount: " .. debtor.debtAmount, 400, 360)
        love.graphics.print("Press [Y] to accept", 400, 400)
        love.graphics.print("Press [N] to reject", 400, 425)
    else
        love.graphics.print("Press [Space] to start showing debtors", 400, 300)
    end
end
