
function onCreate()
    runHaxeCode([[
        import Main;    
        Main.fpsVar.visible = false;
    ]])
end

local fpsActive = false
function onUpdate(e)
    if keyJustPressed('togglefps') then
        fpsActive = not fpsActive
        runHaxeCode('Main.fpsVar.visible = '..(fpsActive and 'true' or 'false')..';')
    end
end