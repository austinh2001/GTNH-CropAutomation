local action = require('action')

-- Usage: relocatePlot.lua <srcIndex> <dstIndex>
-- Moves a crop at the given plot index to another plot index. 

local function parseArgs(args)

    if #args ~= 2 then
        return nil, nil, 'Usage: relocatePlot.lua <srcIndex> <dstIndex>'
    end
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
            action.transplantWorld(src_pos, dst_pos)
        end
    end
    print('Relocation complete!')
end

main(...)
