local tweenspeed = 1.5
local tweenease = 'quartOut'
function onCreatePost()
    defaultcamzoom = getProperty('defaultCamZoom')
end

function onEvent(name, v1, v2)
    if name == 'ChangeZoom' then
        if v1 == '' then
            cameranewzoom = defaultcamzoom
            doTweenZoom('camerazoomevent', 'camGame', cameranewzoom, tweenspeed, tweenease);
        elseif v1 ~= '' then
            cameranewzoom = defaultcamzoom + v1
            doTweenZoom('camerazoomevent', 'camGame', cameranewzoom, tweenspeed, tweenease);
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'camerazoomevent' then
        setProperty("camGame.zoom",cameranewzoom)
        setProperty('defaultCamZoom', cameranewzoom)
    end
end