local M = {}

local names = {
    "Siddharth.S", "Arjun.V", "Priya.K", "Ravi.M", "Meena.T",
    "Ayesha.B", "Kiran.D", "Neha.G", "Vikram.N", "Divya.Z",
    "Ananya.R", "Ishaan.P", "Sneha.Y", "Rohit.L", "Tanvi.X",
    "Akshay.W", "Riya.E", "Harsha.Q", "Nikhil.J", "Shruti.U",
    "Kavya.I", "Manish.A", "Tanya.O", "Rahul.C", "Preeti.K",
    "Varun.B", "Simran.D", "Aditya.F", "Sakshi.G", "Rajeev.H",
    "Alok.Z", "Lavanya.M", "Deepak.N", "Ira.T", "Jay.B",
    "Sanya.V", "Sahil.K", "Amrita.X", "Aniket.Y", "Zoya.P",
    "Devika.Q", "Rakesh.J", "Chaitra.L", "Omkar.E", "Bhavana.W",
    "Rehan.S", "Pooja.F", "Lakshmi.C", "Yash.G", "Naina.H",
    "Kunal.A", "Maya.M", "Sunil.Z", "Praveen.R", "Mohit.T",
    "Ritika.I", "Gaurav.V", "Nivedita.K", "Tushar.L", "Asmita.X",
    "Tarun.B", "Anjali.Q", "Farhan.J", "Keerthi.D", "Sujay.C",
    "Harini.Y", "Sameer.O", "Diya.N", "Abhishek.F", "Kanika.H",
    "Vivek.G", "Esha.A", "Nitin.P", "Shraddha.M", "Imran.Z",
    "Shreya.T", "Parth.E", "Jhanvi.S", "Karthik.L", "Mehul.X",
    "Bhavya.V", "Aarav.B", "Trisha.I", "Yuvraj.J", "Rachna.C",
    "Rohini.W", "Dev.P", "Aditi.Q", "Santosh.N", "Madhuri.D",
    "Anirudh.F", "Juhi.Y", "Ranjit.M", "Charvi.T", "Ramesh.E",
    "Pallavi.K", "Armaan.H", "Vidya.O", "Abhinav.A", "Neelam.Z"
}

local cardColors = {
    {card = "sprites/GreyCard.png", details = "sprites/CardDetailsGrey.png"},
    {card = "sprites/RedCard.png", details = "sprites/CardDetailsRed.png"},
    {card = "sprites/BlueCard.png", details = "sprites/CardDetailsBlue.png"}
}

local function getRandomDebiter()
    local name = names[math.random(#names)]
    local pin = math.random(1000, 9999)
    local enteredPin = math.random(1000, 9999)
    local balance = math.random(1000, 10000)
    local debtAmount = math.random(1000, 10000)
    local characterId = math.random(1, 5)
    local cardSet = cardColors[math.random(#cardColors)]

    return {
        name = name,
        pin = pin,
        enteredPin = enteredPin,
        balance = balance,
        debtAmount = debtAmount,
        characterPath = "sprites/Character(" .. characterId .. ").png",
        cardPath = cardSet.card,
        detailsPath = cardSet.details
    }
end

function M.generateDay1Debiters(count)
    local debiters = {}
    for i = 1, count do
        table.insert(debiters, getRandomDebiter())
    end
    return debiters
end

return M
