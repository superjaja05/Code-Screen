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

print("Looking for config folder..")
if file.exists("/cfg/") == false then
    print("None found!")
    os.sleep(0.5)
    file.makeDirectory("/cfg")
    print("Config folder created.")
    os.sleep(0.3)
end

if file.exists("/cfg/pc.txt") == false then
    print("No password found!")
    os.sleep(0.2)
    print("Please enter new password..")
    newcode = term.read()
    codefile = io.open("/cfg/pc.txt","w")
    print(codefile)
    os.sleep(0.1)
    codefile:write(newcode)
    print("Done. Booting to system.")
    codefile:close()
    os.sleep(1)
end


g.setResolution(30,7)
term.clear()

print("Fetching Code..")
os.sleep(0.1)
codefile2 = file.open("/cfg/pc.txt","r")
codelength = file.size("/cfg/pc.txt")
codegood = codefile2:read(codelength)

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
code = term.read()
if code == codegood
    then
        
        term.clearLine()
        g.setForeground(0x00FF00)
        term.setCursor(4,6)
        g.setForeground(0x00FF33)   
        print("Correct!")
        rs.setOutput(sides.right,15)
        os.sleep(3)
        rs.setOutput(sides.right,0)
    else
        if string.find(code, "reset") and string.find(code, codegood) then
            print("Ready to change password!")
            os.sleep(0.3)
            file.remove("/cfg/pc.txt")
            shell.execute("reboot")
        end
        if string.find(code,"reboot") then
            shell.execute("reboot")
        end
        term.clearLine()
        g.setForeground(0x00FF00)
        g.setForeground(0xFF0033)
        term.setCursor(4,6)
        print("Incorrect!")
        os.sleep(2)
    end
until 1 == 2