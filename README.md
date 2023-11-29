## Huge Games v3 UI Lib

As we move into the Next Stage for HugeGames, we thought it's only fitting that we create our own brand new UI
This New Style follows the format of our [Website](https://v3.hugegames.io), and it actively being updated to add new features, and create a more immersive experience
This is one of the First UI Libraries we have ever written from scratch, so please excuse any bugs, things that look out of place, and ofc *Ugly code*

### Documentation

**Loading The Library**

    local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HugeGamesio/HugeGamesv3/main/Lib.lua"))

**Creating a New UI**

    local UI = UILib:CreateUI()

**Creating a Tab**

    local Tab = UI:CreateTab("Example")
   
  **Creating a Section**
  

    local Section = Tab:Section("Main Section")

**Creating a Nested Section**

    local NestedSection = Section:Section("Nested Section")

### The Following Functions can be used in both Sections and Nested Sections.

**Creating a Blank Space**
This creates a small invisible gap between elements

    Section:BlankSpace(<Optional, Integer | Default: 10>)

**Creating a Label**
*labels can also be created inside of tabs*

    Section:Label("HugeGames", <Optional, Table {Color=Color3Object, Allignment=TextXAllignmentObject} | Default: {Color=Color3.fromRGB(175,175,175), Allignment=Enum.TextXAlignment.Left}>)

**Creating a Toggle**

    Section:Toggle("Toggle Test", <Boolean, IsToggled | Default: false>, function(isToggled)
    
    end)

**Creating a Button**

    Section:Button("Button Test", function()
    	
    end)

**Creating an Input Box**

    Section:Input("Input Test", function(InputText)
    	
    end)
   
**Creating a Slider**

    Section:Slider("Slider Test", 1, 50, function(SliderVale)
    	
    end)

**Creating a Dropdown**

    Section:DropDown("Dropdown Test", <Table, Items>, function(SelectedValue)
    	
    end)


### Example Code:

    local UILib = loadstring(game:HttpGet("https://raw.githubusercontent.com/HugeGamesio/HugeGamesv3/main/Lib.lua"))
    
    local UI = UILib:CreateUI()
    
    local Tab = UI:CreateTab("HugeGames")
    
    Tab:Label("HugeGames", {Color=Color3.fromRGB(0,155,255), Allignment=Enum.TextXAlignment.Center})
    Tab:Label("#1 Script Provider", {Color=Color3.fromRGB(255,255,255), Allignment=Enum.TextXAlignment.Center})
    
    Section = Tab:Section("Join Our Discord")
    
    Section:Label("discord.gg/hugegames")
    
    Section:BlankSpace()
    
    Section:Toggle("Toggle Test", false, function(isToggled)
    
    end)
    
    Section:Button("Button Test", function()
    	
    end)
    Section:Input("Input Test", function(InputText)
    	
    end)
    Section:Slider("Slider Test", 1, 50, function(SliderVale)
    	
    end)
    Section:DropDown("Dropdown Test", {"Item 1", "Item 2", "Item 3"}, function(SelectedValue)
    	
    end)
    
    local InSec = Section:Section("InTest")
    
    InSec:Toggle("Toggle Test ", true, function(isToggled)
    	
    end)
    
    InSec:Button("Button Test", function()
    
    end)
    InSec:Input("Input Test", function()
    
    end)
    InSec:Slider("Slider Test", 1, 50, function()
    
    end)
    InSec:DropDown("Dropdown Test", {"Item 1", "Item 2", "Item 3"}, function()
    
    end)
    
    -- Example Usage
    
    local TabUtil = UI:CreateTab("Util")
    local PlayerSection = TabUtil:Section("Player")
    PlayerSection:Slider("Set Walkspeed", 16, 200, function(Value)
    	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end)
    
    PlayerSection:Slider("Set JumpHeight", 50, 200, function(Value)
    	game.Players.LocalPlayer.Character.Humanoid.UseJumpPower = true
    	game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end)
    
    PlayerSection:Button("Suicide", function()
    	game.Players.LocalPlayer.Character.Head:Destroy()
    end)
