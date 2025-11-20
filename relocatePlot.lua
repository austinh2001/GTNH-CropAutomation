local action = require('action')
local gps = require('gps')
local scanner = require('scanner')
local config = require('config')

-- Usage: relocatePlot.lua <srcIndex> <dstIndex>
-- Moves a crop at the given plot index to another plot index. 

local function parseArgs(args)

    if #args ~= 2 then
        return nil, nil, 'Usage: relocatePlot.lua <srcIndex> <dstIndex>'
    end
    -- convert to numbers
    src = tonumber(args[1])
    dst = tonumber(args[2])

    return src, dst, nil
end

local function main(...)
    local src, dst, err = parseArgs({...})

    if err ~= nil then
        print(err)
        return
    end

    print(string.format('Relocating plot from index %d to index %d...', src, dst))
    for slot=1, config.storageFarmArea, 1 do
        -- check if there is a crop to relocate
        local crop = scanner.scan()
        if crop.name ~= 'air' then
            src_pos = gps.plotIndexToPos(src, slot)
            dst_pos = gps.plotIndexToPos(dst, slot)
            -- print the values of src_pos and dst_pos for debugging
            print(string.format('Relocating slot %d from (%d, %d) to (%d, %d)', slot, src_pos[1], src_pos[2], dst_pos[1], dst_pos[2]))
            action.transplantWorld(src_pos, dst_pos)
        end
    end
    print('Relocation complete!')
end

main(...)
