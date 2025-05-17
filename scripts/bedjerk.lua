local speaker=game.Players.LocalPlayer;
local humanoid = speaker.Character:FindFirstChildWhichIsA("Humanoid")
if not humanoid then return end
local ahhyes = false
local track = nil
local function stopTomfoolery()
    ahhyes = false
    if track then
        track:Stop()
        track = nil
    end
end
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")
local function lay()
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid:ChangeState(Enum.HumanoidStateType.Physics)
	local groundOffset = Vector3.new(0, -0.5, 0)
	rootPart.Anchored = true
	rootPart.CFrame = rootPart.CFrame * CFrame.new(groundOffset) * CFrame.Angles(math.rad(90), 0, 0)
end
lay()
player.CharacterAdded:Connect(function(newCharacter)
	character = newCharacter
	humanoid = character:WaitForChild("Humanoid")
	rootPart = character:WaitForChild("HumanoidRootPart")
	lay()
end)
humanoid.Died:Connect(stopTomfoolery)
local function play()
    if not track then
        local anim = Instance.new("Animation")
        anim.AnimationId =  "rbxassetid://106772613"
        track = humanoid:LoadAnimation(anim)
    end
    track:Play()
    track:AdjustSpeed(isR15 and 0.3 or 0.3)
    track.TimePosition = 0.6
end
while task.wait() do
    if not ahhyes then
        ahhyes = true
        play()
    end
    task.wait(0.1)
    while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do
        task.wait(0.1)
    end
    if track then
        track:Stop()
        track = nil
        ahhyes = false
    end
end
