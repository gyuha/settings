local mp = require 'mp'
local enabled = false

-- OSD 오버레이 생성
local ov = mp.create_osd_overlay("ass-events")

function translation_callback(success, result, error)
    if success and result.status == 0 then
        -- [[ 스타일 설정 ]]
        -- \an2 : 하단 중앙 정렬
        -- \fs60 : 글자 크기
        -- \bord2 : 테두리 두께 (검은색)
        -- \1c&HFFFFFF& : 글자색 (흰색)
        local style = "{\\an2}{\\fs60}{\\bord2}"
        
        -- 줄바꿈을 공백으로 변경
        local clean_text = result.stdout:gsub("\n", " ")

        ov.data = style .. clean_text
        ov:update()
    end
end

function on_subtitle_change(name, text)
    if not enabled then return end

    if not text or text == "" then
        ov.data = ""
        ov:update()
        return
    end

    text = text:gsub("\n", " ")

    local cmd = {
        name = "subprocess",
        args = { "trans", "-b", "-t", "ko", text },
        capture_stdout = true
    }
    
    mp.command_native_async(cmd, translation_callback)
end

function toggle_translation()
    enabled = not enabled
    if enabled then
        mp.set_property("sub-visibility", "no")
        mp.osd_message("자동 번역 ON (Shift+t로 끄기)", 2)
        
        local current_text = mp.get_property("sub-text")
        if current_text then on_subtitle_change("sub-text", current_text) end
    else
        mp.set_property("sub-visibility", "yes")
        ov.data = ""
        ov:update()
        mp.osd_message("자동 번역 OFF", 2)
    end
end

mp.observe_property("sub-text", "string", on_subtitle_change)

-- [[ 단축키 변경됨: Shift + t (대문자 T) ]]
mp.add_key_binding("T", "toggle_auto_translation", toggle_translation)
