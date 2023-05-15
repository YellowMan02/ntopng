--
-- (C) 2019-22 - ntop.org
--
local dirs = ntop.getDirs()
package.path = dirs.installdir .. "/scripts/lua/modules/?.lua;" .. package.path

require "lua_utils"
local radius_handler = require "radius_handler"
local host_pools = require "host_pools"

-- #################################################################

if radius_handler.isAccountingEnabled() then
    -- Instantiate host pools
    local pool = host_pools:create()
    local pools_list = {}

    -- Table with pool names as keys
    for _, pool_info in pairs(pool:get_all_pools()) do
        pools_list[pool_info["name"]] = pool_info
    end

    for _, pool_info in pairs(pools_list) do
        if pool_info.id ~= host_pools.DEFAULT_POOL_ID then
            local members = pool_info.members

            for _, member in pairs(members) do
                local is_mac = isMacAddress(member)
                if is_mac then
                    local update_radius = radius_handler.isAccountingRequested(member)

                    if update_radius then
                        -- In case the update fails, move the member into the default pool
                        if not radius_handler.accountingUpdate() then
                            pool:bind_member(member, host_pools.DEFAULT_POOL_ID)
                        end
                    end
                end
            end
        end
    end
end