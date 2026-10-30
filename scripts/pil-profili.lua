-- Fişe takılı olup olmadığını izler; pildeyken mpv.conf'taki [pil] profilini
-- uygular, fişe takılınca geri alır. Windows API'si LuaJIT FFI ile doğrudan
-- okunur, ek süreç açılmaz.

local ok, ffi = pcall(require, "ffi")
if not ok then
    mp.msg.warn("LuaJIT FFI yok, pil profili devre dışı")
    return
end

ffi.cdef[[
typedef struct {
    unsigned char ACLineStatus, BatteryFlag, BatteryLifePercent, SystemStatusFlag;
    unsigned long BatteryLifeTime, BatteryFullLifeTime;
} SYSTEM_POWER_STATUS;
int GetSystemPowerStatus(SYSTEM_POWER_STATUS *status);
]]

local status = ffi.new("SYSTEM_POWER_STATUS")
local on_battery = false

local function check(announce)
    if ffi.C.GetSystemPowerStatus(status) == 0 then return end
    local now = status.ACLineStatus == 0
    if now == on_battery then return end
    on_battery = now
    if now then
        mp.command("apply-profile pil")
    else
        mp.command("apply-profile pil restore")
    end
    mp.set_property_native("user-data/pil", now)
    if announce then
        mp.osd_message(now and "Pil modu" or "Fiş modu")
    end
end

check(false)
mp.add_periodic_timer(30, function() check(true) end)
