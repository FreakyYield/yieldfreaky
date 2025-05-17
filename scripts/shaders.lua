local lighting=game:GetService("Lighting");
local runservice=game:GetService("RunService");
local tweenservice=game:GetService("TweenService");
local debris=game:GetService("Debris");
Lighting.GlobalShadows = true
local function apply_rtx_shader()
settings().Rendering.QualityLevel=Enum.QualityLevel.Level21;
settings().Rendering.EnableFRM=true;
settings().Rendering.GraphicsMode=Enum.GraphicsMode.OpenGL;
lighting.GlobalShadows=true;
lighting.Brightness=3.5;
lighting.Ambient=Color3.fromRGB(15,15,25);
lighting.OutdoorAmbient=Color3.fromRGB(50,50,70);
lighting.ShadowSoftness=0.6;
lighting.ClockTime=12;
lighting.GeographicLatitude=30;
lighting.EnvironmentDiffuseScale=0.8;
lighting.EnvironmentSpecularScale=1.0;
lighting.ExposureCompensation=0.5;
local bloom=Instance.new("BloomEffect");
bloom.Intensity=2.0;
bloom.Size=48;
bloom.Threshold=0.75;
bloom.Parent=lighting;
local colorcorrection=Instance.new("ColorCorrectionEffect");
colorcorrection.Brightness=0.3;
colorcorrection.Contrast=0.5;
colorcorrection.Saturation=0.8;
colorcorrection.TintColor=Color3.fromRGB(255,225,200);
colorcorrection.Parent=lighting;
local sunrays=Instance.new("SunRaysEffect");
sunrays.Intensity=0.3;
sunrays.Spread=1.0;
sunrays.Parent=lighting;
local atmosphere=Instance.new("Atmosphere");
atmosphere.Density=0.2;
atmosphere.Offset=0.7;
atmosphere.Color=Color3.fromRGB(230,200,170);
atmosphere.Decay=Color3.fromRGB(210,180,150);
atmosphere.Glare=0.8;
atmosphere.Haze=0.6;
atmosphere.Parent=lighting;
local depthoffield=Instance.new("DepthOfFieldEffect");
depthoffield.Enabled=true;
depthoffield.FarIntensity=0.3;
depthoffield.FocusDistance=110;
depthoffield.InFocusRadius=92;
depthoffield.NearIntensity=0.2;
depthoffield.Parent=lighting;
local function add_sparkle_effects()
local sparklepart=Instance.new("Part");
sparklepart.Anchored=true;
sparklepart.CanCollide=false;
sparklepart.Transparency=1;
sparklepart.Size=Vector3.new(0.1,0.1,0.1);
sparklepart.Position=Vector3.new(0,100,0);
sparklepart.Parent=workspace;
local sparkles=Instance.new("Sparkles");
sparkles.SparkleColor=Color3.fromRGB(255,240,200);
sparkles.TimeScale=0.5;
sparkles.Parent=sparklepart;
debris:AddItem(sparklepart,10);
end
spawn(function()
while true do
add_sparkle_effects();
wait(2);
end
end);
if lighting:FindFirstChild("Sky")then
lighting.Sky:Destroy();
end
local sky=Instance.new("Sky");
sky.SkyboxBk="rbxassetid://10128908836";
sky.SkyboxDn="rbxassetid://10128909036";
sky.SkyboxFt="rbxassetid://10128909229";
sky.SkyboxLf="rbxassetid://10128909436";
sky.SkyboxRt="rbxassetid://10128909626";
sky.SkyboxUp="rbxassetid://10128909825";
sky.CelestialBodiesShown=true;
sky.SunAngularSize=25;
sky.MoonAngularSize=20;
sky.StarCount=10000;
sky.Parent=lighting;
local function update_lighting()
local time=tick();
local bloomtween=tweenservice:Create(bloom,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Intensity=2.0+math.sin(time*0.3)*0.3});
local colortween=tweenservice:Create(colorcorrection,TweenInfo.new(0.8,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Brightness=0.3+math.cos(time*0.2)*0.15,Saturation=0.8+math.sin(time*0.15)*0.2});
local atmtween=tweenservice:Create(atmosphere,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),{Density=0.2+math.cos(time*0.1)*0.05});
bloomtween:Play();
colortween:Play();
atmtween:Play();
lighting.ClockTime=18+math.sin(time*0.03)*0.3;
end
runservice.RenderStepped:Connect(update_lighting);
end
local success,err=pcall(apply_rtx_shader);
if not success then
else
end
