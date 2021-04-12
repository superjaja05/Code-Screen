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

g.setResolution(27,10)

print("Looking for config folder.")
if file.exists("/cfg/") == false then
    print("404 Not found!")
    os.sleep(0.5)
    file.makeDirectory("/cfg")
    print("Config folder added.")
    os.sleep(0.3)
end

if file.exists("/cfg/pc.txt") == false then
    term.clear()
    print("No password found!")
    os.sleep(0.2)
    print("Select new password:")
    newcode = term.read()
    codefile = io.open("/cfg/pc.txt","w")
    print(codefile)
    os.sleep(0.1)
    codefile:write(newcode)
    computer.beep(600,0.5)
    print("Done.")
    codefile:close()
    os.sleep(1)
end

if file.exists("/cfg/side.txt") == false then
    term.clear()
    print("No side selected!")
    os.sleep(0.2)
    print("Select RS output side:")
    newside = io.read()
    sidefile = io.open("/cfg/side.txt","w")
    print(sidefile)
    os.sleep(0.1)
    sidefile:write(newside)
    computer.beep(600,0.5)
    print("Done.")
    sidefile:close()
    os.sleep(1)
end


g.setResolution(30,7)
term.clear()

print("Reading CFG..")
os.sleep(0.1)
codefile2 = file.open("/cfg/pc.txt","r")
codelength = file.size("/cfg/pc.txt")
codegood = codefile2:read(codelength)

repeat
print("Reading CFG 2..")
os.sleep(0.1)
sidefile2 = file.open("/cfg/side.txt","r")
sidelength = file.size("/cfg/side.txt")
siders = sidefile2:read(sidelength)

if siders == "bottom" or siders == "top" or siders == "back" or siders == "front" or siders == "right" or siders == "left" then
    print("Accepted")
    os.sleep(0.5)
    correctside = true
else
    correctside = false
    term.clear()
    computer.beep(200)
    print("Incorrect Side!")
    file.remove("/cfg/side.txt")
    os.sleep(0.5)
    print("...")
    os.sleep(0.2)
    print("Select RS output side:")
    newside = io.read()
    sidefile = io.open("/cfg/side.txt","w")
    print(sidefile)
    os.sleep(0.1)
    sidefile:write(newside)
    computer.beep(600,0.5)
    print("Done.")
    sidefile:close()
    os.sleep(1)
end
until correctside == true

if string.find(siders, "bottom") then siders2 = 0 end
if string.find(siders, "top") then siders2 = 1 end
if string.find(siders, "back") then siders2 = 2 end
if string.find(siders, "front") then siders2 = 3 end
if string.find(siders, "right") then siders2 = 4 end
if string.find(siders, "left") then siders2 = 5 end

term.write("side n°:")
term.write(siders2)

os.sleep(0.25)


i = 1

repeat
g.setForeground(0x00FFFF)
term.clear()

term.setCursor(5,2)
term.write("Hello! Enter password.")
g.setForeground(0x00FF00)
-- Box 1
g.fill(4,1,24,1,"═")
g.fill(4,3,24,1,"═")

g.fill(3,2,1,1,"╎")
g.fill(28,2,1,1,"╎")

g.fill(3,1,1,1,"╒")
g.fill(28,1,1,1,"╕")
g.fill(3,3,1,1,"╘")
g.fill(28,3,1,1,"╛")

-- Box 2
g.fill(4,5,24,1,"═")

g.fill(3,5,1,1,"╞")
g.fill(28,5,1,1,"╡")



term.setCursor(4,6)
term.write("> ")
g.setForeground(0xFFFFFF)

code = term.read(nil,nil,nil,"*")
if code == codegood
    then
        
        term.clearLine()
        g.setForeground(0x00FF00)
        term.setCursor(4,6)
        g.setForeground(0x00FF33)   
        print("Correct!")
        computer.beep(800,0.3)
        rs.setOutput(siders2,15)
        os.sleep(3)
        rs.setOutput(siders2,0)
    else
        if string.find(code,"reset") and string.find(code, codegood) then
            term.setCursor(6,6)
            term.write("Reset CMD Accepted!")
            computer.beep(500)
            computer.beep(600)
            computer.beep(300)
            os.sleep(0.3)
            file.remove("/cfg/pc.txt")
            file.remove("/cfg/side.txt")
            term.setCursor(5,7)
            os.sleep(0.5)
            shell.execute("reboot")
        end
        if string.find(code,"reboot") then
            term.setCursor(6,6)
            term.write("Command Accepted.")
            term.setCursor(6,7)
            term.write("Rebooting!")
            term.setCursor(5,7)
            os.sleep(0.5)
            shell.execute("reboot")
        end
        term.clearLine()
        g.setForeground(0x00FF00)
        g.setForeground(0xFF0033)
        term.setCursor(4,6)
        print("Incorrect!")
        computer.beep(100)
        computer.beep(100,0.5)
        os.sleep(0.5)
    end
until 1 == 2