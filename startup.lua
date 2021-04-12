local component = require("component")
local term = require("term")
local computer = require("computer")
local k = require("keyboard")
local shell = require("shell")
local sides = require("sides")
local file = require("filesystem")
local io = require("io")

local g = component.gpu
local rs = component.redstone
local fs = component.filesystem

print("Looking for config folder..")
if file.exists("/cfg/") == false then
    print("None found!")
    os.sleep(0.5)
    file.makeDirectory("/cfg")
end

if file.exists("/cfg/pc.txt") == false then
    print("No passcode found!")
    os.sleep(0.2)
    print("Please enter passcode..")
    newcode = term.read()
    codefile = io.open("/cfg/pc.txt","w")
    print(codefile)
    os.sleep(0.1)
    codefile:write(newcode)
    print("Done.")
    codefile:close()
    os.sleep(1)
end


g.setResolution(30,7)
term.clear()

print("Fetching Code..")
os.sleep(0.1)
codefile2 = file.open("/cfg/pc.txt","r")
codegood = codefile2:read(1)

i = 1

repeat
g.setForeground(0x00FFFF)
term.clear()

term.setCursor(5,2)
g.fill(4,1,24,1,"-")
os.sleep(0.1)
term.write("Hello! Enter passcode.")
os.sleep(0.1)
g.fill(4,3,24,1,"-")
term.setCursor(2,5)
os.sleep(0.1)
term.write("> ")
code = io.read()
print(code)
print(codegood)
os.sleep(2)
if code == codegood
    then
        g.setForeground(0x00FF33)
        print("Correct!")
        rs.setOutput(sides.right,15)
        os.sleep(3)
        rs.setOutput(sides.right,0)
    else
        g.setForeground(0xFF0033)
        print("Incorrect!")
        os.sleep(2)
    end
until 1 == 2