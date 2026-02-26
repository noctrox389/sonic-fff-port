function onCreatePost()
    makeLuaSprite('bosshealth') --
    makeGraphic('bosshealth', 1, 1, 'ffffff') --0000ff
    setProperty('bosshealth.alpha', 0)
    addLuaSprite('bosshealth', false)
    setObjectCamera('bosshealth', 'hud')
    setProperty('bosshealth.x', 8) --health

    bossbarscale = 0.8

    bossbarX = 280
    if downscroll then
        bossbarY = 30
    else
        bossbarY = 600
    end
    makeAnimatedLuaSprite('bossbar1', 'bossbar', bossbarX, bossbarY)
    addAnimationByPrefix('bossbar1', 'bottom', 'target bottom', 24, false)
    setObjectCamera('bossbar1', 'hud')
    addLuaSprite('bossbar1', true)
    setProperty('bossbar1.scale.x', bossbarscale)
    setProperty('bossbar1.scale.y', bossbarscale)
    
    bar2offsetX = 30
    bar2offsetY = 35
    makeAnimatedLuaSprite('bossbar2', 'bossbar', bossbarX + bar2offsetX, bossbarY + bar2offsetY)
    addAnimationByPrefix('bossbar2', 'bar', 'target bar', 24, false)
    setObjectCamera('bossbar2', 'hud')
    addLuaSprite('bossbar2', true)
    setProperty('bossbar2.origin.x', 0)
    setProperty('bossbar2.scale.x', bossbarscale)
    setProperty('bossbar2.scale.y', bossbarscale)
    
    makeAnimatedLuaSprite('bossbar3', 'bossbar', bossbarX, bossbarY)
    addAnimationByPrefix('bossbar3', 'top','target top',  24, false)
    setObjectCamera('bossbar3', 'hud')
    addLuaSprite('bossbar3', true)
    setProperty('bossbar3.scale.x', bossbarscale)
    setProperty('bossbar3.scale.y', bossbarscale)
end

function onUpdatePost()
    setProperty('bossbar2.scale.x', getProperty('bosshealth.x') / 8 * bossbarscale)
    if luaSpriteExists('resultsscreen') and getProperty('resultsscreen.x') == 1 then
        removeLuaSprite('bossbar1', true)
        removeLuaSprite('bossbar2', true)
        removeLuaSprite('bossbar3', true)
    end
end
