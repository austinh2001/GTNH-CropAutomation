local action = require('action')

-- Usage: relocateCrop.lua <srcX> <srcY> <srcZ> <dstX> <dstY> <dstZ>
-- Moves a crop at the given world coordinates to another world coordinate.

local function parseArgs(args)

    if #args ~= 6 then
        return nil, nil, 'Usage: relocateCrop.lua <srcX> <srcY> <srcZ> <dstX> <dstY> <dstZ>'
    end

    local coords = {}
    for i = 1, 6 do
        coords[i] = tonumber(args[i])
        if coords[i] == nil then
            return nil, nil, string.format('Argument %d must be a number.', i)
        end
    end

    return {coords[1], coords[2], coords[3]}, {coords[4], coords[5], coords[6]}, nil
end

local function main(...)
    local src, dst, err = parseArgs({...})
    if err ~= nil then
        print(err)
        return
    end

    print(string.format('Relocating crop from (%d, %d, %d) to (%d, %d, %d)...', src[1], src[2], src[3], dst[1], dst[2], dst[3]))
    action.initWork()
    action.transplantWorld(src, dst)
    action.restockAll()
    print('Relocation complete!')
end

main(...)
