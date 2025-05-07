    local GetKey = "https://t.me/lsModgaming"
    local API = "https://anotepad.com/notes/dehmqgw7"
    local savedKeyFile = "saved_key.txt"
 
 
    function ReadSavedKey()
        local file = io.open(savedKeyFile, "r")
        if file then
            local savedKey = file:read("*a")
            file:close()
            return savedKey
        end
        return nil
    end
    
    
    function SaveKey(key)
        local file = io.open(savedKeyFile, "w")
        if file then
            file:write(key)
            file:close()
            gg.toast("Lưu Key Thành Công!")
        end
    end


    function DeleteKey()
        os.remove(savedKeyFile)
        gg.toast("Đã xoá key!")
    end
    
    
    local GetData = (gg.makeRequest(API).content)
    if not GetData then
        gg.alert("Lỗi khi lấy dữ liệu!")
        return
    end
    
   

    KeyOnline = string.match(GetData, "Key:%s*([%w%d]+)")
    ExpireDate = string.match(GetData, "ExpireDate:%s*(%d%d%d%d%-%d%d%-%d%d)")
    
    

    if KeyOnline == nil then
        gg.alert("Error fetching key! Kiểm tra lại format trong page note.")
        return
    end
    if ExpireDate == nil then
        gg.alert("Error fetching expire date! Kiểm tra lại format trong page note.")
        return
    end
    
    
    local CurrentDate = os.date("%Y-%m-%d")
    if CurrentDate > ExpireDate then
        gg.alert("Script đã hết hạn!\nExpire Date: " .. ExpireDate)
        os.exit()
    end
    
    
    local savedKey = ReadSavedKey()
    if savedKey and savedKey == KeyOnline then
        gg.toast("Tự động đăng nhập thành công!\nExpire Date: " .. ExpireDate)
    else
       
        local Pastek = gg.prompt({"Vui lòng nhập key để vào script"}, nil, {"text"})
        if Pastek == nil or Pastek[1] == "" then
            gg.alert("Key sai hoặc hết hạn!")
            return
        end
    
        if Pastek[1] ~= KeyOnline then
            local choice = gg.choice({"Copy Link", "OK"}, nil, "Sai mật khẩu!\nVui lòng vô nhóm để lấy key:\n"..GetKey)
            if choice == 1 then
                gg.copyText(GetKey)
                gg.alert("Link đã được sao chép vào clipboard!")
            end
            return
        else
            
            local saveChoice = gg.choice({"Lưu key", "Không Lưu"}, nil, "Đăng nhập thành công!\nBạn có muốn lưu key cho lần sau dùng không?")
            if saveChoice == 1 then
                SaveKey(Pastek[1])
            end
        end
    end
    

    if gg.choice({"Xoá key đã lưu", "Tiếp tục đăng nhập"}, nil, "Quản lý key đã lưu") == 1 then
        DeleteKey()
    end
    
local SaveOFF = {}

local function hex2tbl(hex)
  local ret = {}
  hex:gsub('%S%S', function(ch)
    ret[#ret + 1] = ch
    return ''
  end)
  return ret
end

local function getValues(lib, address, length)
  local values = {}
  for i = 1, length do
    values[i] = {
      address = lib + address + i - 1,
      flags = gg.TYPE_BYTE
    }
  end
  return gg.getValues(values)
end

local function setValues(lib, address, values)
  local set = {}
  for i = 1, #values do
    set[i] = {
      address = lib + address + i - 1,
      value = values[i],
      flags = gg.TYPE_BYTE
    }
  end
  gg.setValues(set)
  gg.clearResults()
end

function SetValue(a, b, c)
  local set = {}
  local lib = gg.getRangesList(a)[1].start
  local Hex = hex2tbl(c)
  
  local V = {}
  for i = 1, #Hex do
    V[i] = tonumber(Hex[i], 16)
    if V[i] > 127 then
      V[i] = V[i] - 256
    end
  end
  
  if not SaveOFF[b] then
    local Z = {}
    for i = 1, #Hex do
      Z[i] = {
        address = lib + b + i - 1,
        flags = gg.TYPE_BYTE
      }
    end
    SaveOFF[b] = gg.getValues(Z)
  end
  
  local R = getValues(lib, b, #Hex)
  
  if R[1].value == V[1] and R[3].value == V[3] then
    gg.setValues(SaveOFF[b])
  else
    setValues(lib, b, V)
  end
end
function script()
main = gg.choice({
'Block Anti-Cheat Server 📛 (Bắt buộc)',
'Bypass Internal',
'Bypass Script + Antenna Antiban',
'Function Hack (Chức năng hack)',
'Clear Log',
'Thoát script',
},nil,'Phát triển bởi @hnlsm [Telegram] \n\nVui lòng bật Bypass từ trên xuống để tránh đơ game nhé')
if main == nil then gg.toast('HNhat') else
if main == 1 then anti() end
if main == 2 then internal() end
if main == 3 then bypass() end
if main == 4 then hack() end
if main == 5 then log() end
if main == 6 then thoat() end
if main == 7 then gg.setVisible(true) os.exit(print('HNhat')) end
end end
function anti()
  SetValue("libil2cpp.so", 0x5b18e8c,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x4ff29b8,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x4ff163c,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x5b24100,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x5b26b14,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x5b26c4c,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x6bbb304,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x6a50814,"0000A0E31EFF2FE1")
  SetValue("libil2cpp.so", 0x4d772d4,"0100A0E31EFF2FE1")
	
  SetValue("libanogs.so", 0x336E44, "00 00 00 00")---
  SetValue("libanogs.so", 0x336E6C, "00 00 00 00")---
  SetValue("libanogs.so", 0x336EB8, "00 00 00 00")---
  SetValue("libanogs.so", 0x336EC4, "00 00 00 00")---
  SetValue("libanogs.so", 0x336EDC, "00 00 00 00")---
  SetValue("libanogs.so", 0x336F04, "00 00 00 00")---
  SetValue("libanogs.so", 0x3336F10, "00 00 00 00")---
  
  SetValue("libanogs.so", 0x37EAC38, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EAC20, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EAC0C, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EAC08, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EABF4, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EABDC, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EABCC, "00 00 00 00")---
  SetValue("libanogs.so", 0x37EAB98, "00 00 00 00")---
  
  SetValue("libanogs.so", 0x740B01C, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B030, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B040, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B044, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B048, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B04C, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B050, "00 00 00 00")---
  SetValue("libanogs.so", 0x740B06C, "00 00 00 00")---
  
  SetValue("libanogs.so", 0xF4A0040, "00 00 00 00")---
  SetValue("libanogs.so", 0xF4A0044, "00 00 00 00")---
  SetValue("libanogs.so", 0xF4A0048, "00 00 00 00")---
  
  SetValue("libanogs.so", 0x4448E048, "00 00 00 00")---
  SetValue("libanogs.so", 0x4448E04C, "00 00 00 00")---
  SetValue("libanogs.so", 0x4448E050, "00 00 00 00")---
  SetValue("libanogs.so", 0x4448E068, "00 00 00 00")---
  
  SetValue("libanogs.so", 0x105578, "00 00 A0 E3")
SetValue("libanogs.so", 0x10557C, "0B D0 A0 E1")
SetValue("libanogs.so", 0x105580, "00 88 BD E8")
SetValue("libanogs.so", 0x105584, "00 00 00 00")
SetValue("libanogs.so", 0x105588, "00 00 00 00")
SetValue("libanogs.so", 0x10558C, "00 00 00 00")
SetValue("libanogs.so", 0x105590, "00 00 00 00")
SetValue("libanogs.so", 0x105594, "00 00 00 00")
SetValue("libanogs.so", 0x105598, "00 00 00 00")
SetValue("libanogs.so", 0x10559C, "00 00 00 00")
SetValue("libanogs.so", 0x1055A0, "00 00 00 00")
SetValue("libanogs.so", 0x1055A4, "00 00 00 00")
SetValue("libanogs.so", 0x1055A8, "00 00 00 00")
SetValue("libanogs.so", 0x1055AC, "00 00 00 00")
SetValue("libanogs.so", 0x1055B0, "00 00 00 00")
SetValue("libanogs.so", 0x1055B4, "00 00 00 00")
SetValue("libanogs.so", 0x1055B8, "00 00 00 00")
SetValue("libanogs.so", 0x1055BC, "00 00 00 00")
SetValue("libanogs.so", 0x1055C0, "00 00 00 00")
SetValue("libanogs.so", 0x1055C4, "00 00 00 00")
SetValue("libanogs.so", 0x1055C8, "00 00 00 00")
SetValue("libanogs.so", 0x1055CC, "00 00 00 00")
SetValue("libanogs.so", 0x1055D0, "00 00 00 00")
SetValue("libanogs.so", 0x1055D4, "00 00 00 00")
SetValue("libanogs.so", 0x1055D8, "00 00 00 00")
SetValue("libanogs.so", 0x1055DC, "00 00 00 00")
SetValue("libanogs.so", 0x1055E0, "00 00 00 00")
SetValue("libanogs.so", 0x4F3EC, "00 00 E0 E3 1E FF 2F E1")
SetValue("libanogs.so", 0x4EF30, "00 00 E0 E3 1E FF 2F E1")
SetValue("libanogs.so", 0x4F3E0, "00 00 E0 E3 1E FF 2F E1")
SetValue("libanogs.so", 0x4EFC0, "00 00 E0 E3 1E FF 2F E1")
SetValue("libanogs.so", 0x4F068, "00 00 E0 E3 1E FF 2F E1")
SetValue("libanogs.so", 0x4EFA8, "00 00 E0 E3 1E FF 2F E1")
gg.toast("Đã chặn server Anti-Cheat [ON]")
end
function internal()
gg.clearResults()
    gg.setRanges(gg.REGION_CODE_APP | gg.REGION_ANONYMOUS)
    
    gg.searchNumber("h 00F0A0E1", gg.TYPE_BYTE)
    local result = gg.getResults(100)
    if #result > 0 then
        gg.editAll("h 000020E3", gg.TYPE_BYTE)
        gg.toast("Bypass kích hoạt ✔️")
    else
        gg.alert("Bypass bị lỗi ❌")
    end

    gg.clearResults()
    gg.setRanges(gg.REGION_CODE_APP | gg.REGION_ANONYMOUS)
    
    gg.searchNumber("h 10FF2FE1", gg.TYPE_BYTE)
    local result2 = gg.getResults(100)
    if #result2 > 0 then
        gg.editAll("h 000020E3", gg.TYPE_BYTE)
        gg.toast("Bypass lớp thứ 2 kích hoạt ✔️")
    else
        gg.alert("Bypass lớp thứ 2 bị lỗi ❌")
    end

    gg.clearResults()
end
function bypass()
gg.setRanges(32)
  gg.searchNumber("h BB 72 22 BC 00 00 00 00", 1)
  gg.refineNumber("h 00 00 00 00", 1, false, gg.SIGN_EQUAL, 0, -1)
  gg.getResults(10)
  gg.editAll("h 00 00 20 43", 1)
  gg.clearResults()
  gg.setRanges(32)
  gg.searchNumber("h 8D 39 65 3E 00 00 00 00", 1)
  gg.refineNumber("h 00 00 00 00", 1, false, gg.SIGN_EQUAL, 0, -1)
  gg.getResults(10)
  gg.editAll("h 00 00 20 43", 1)
  gg.clearResults()
  gg.setRanges(gg.REGION_VIDEO | gg.REGION_BAD)
  gg.searchNumber("3.75000095367;3.75000166893;3.58931802e-29:13", 16, false, gg.SIGN_EQUAL, 0, -1, 0)
  gg.getResults(9)
  gg.editAll("99", 16)
  gg.clearResults()
  gg.setRanges(gg.REGION_CODE_APP)
  gg.searchNumber("E3E04000h", 4)
  gg.getResults(60500)
  gg.editAll("E24DD058ED2D8B10h", 32)
  gg.clearResults()
  gg.setRanges(gg.REGION_CODE_APP)
  gg.searchNumber("E3E01000h", 4)
  gg.getResults(60500)
  gg.editAll("E24DD058ED2D8B10h", 32)
  gg.clearResults()
  gg.toast("Bypass + Antenna Antiban [ON]")
  end
function hack()
m = gg.multiChoice({
'Magic bullet 50% (login)',
'Magic bullet 100% (login)',
'Large magic bullet (login)',
'Return',
})
if m == nil then gg.toast('HNhat') else
if m [1] then mg1() end
if m [2] then mg2() end
if m [3] then mg3() end
if m [14] then gg.setVisible(true) end
end end
function mg1()
gg.setValues({ -- table(695e511)
 [1] = { -- table(5c3e676)
  ['address'] = 0x62f260+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '00r',
 },
 [2] = { -- table(9e54477)
  ['address'] = 0x62f261+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '00r',
 },
 [3] = { -- table(c8498e4)
  ['address'] = 0x62f262+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '00r',
 },
 [4] = { -- table(f62c14d)
  ['address'] = 0x62f263+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '3Fr',
 },
})
gg.toast("Magic 50% ✅")
end
function mg2()
gg.setValues({ -- table(695e511)
 [1] = { -- table(5c3e676)
  ['address'] = 0x62f260+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = 'CDr',
 },
 [2] = { -- table(9e54477)
  ['address'] = 0x62f261+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = 'CCr',
 },
 [3] = { -- table(c8498e4)
  ['address'] = 0x62f262+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '4Cr',
 },
 [4] = { -- table(f62c14d)
  ['address'] = 0x62f263+gg.getRangesList("libunity.so")[1].start,
  ['flags'] = 1, -- gg.TYPE_BYTE
  ['value'] = '3Fr',
 },
})
gg.toast("Magic 100% ✅")
end
function mg3()
gg.setRanges(32)
gg.searchNumber("h23AAA6B8460ACD70", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h23AAA6B8B2F71FA4", 1)
gg.clearResults()
gg.searchNumber("h477B5ABDAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F0400803F0000803FFEFF7F3F", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h8D07743FAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F000060410000604100006041", 1)
gg.clearResults()
gg.searchNumber("h4C7B5ABD0A5766BB1E2148BA2AC2CF3B96FB283DE8B117BDE3997F3F0400803F0100803FFCFF7F3F", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h1B0E743FAE5766BB5C1F48BA1BC0CF3B9CFB283DA2B117BDE4997F3F000060410000604100006041", 1)
gg.clearResults()
gg.searchNumber("h1000000062006F006E0065005F004C006500660074005F0057006500610070006F006E00", 1)
gg.getResults(gg.getResultsCount())
gg.editAll("h1000000062006F006E0065005F005300700069006E006500000000000000000000000000", 1)
gg.clearResults()
gg.toast("Magic lỏ ✅")
end
function log()
gg.clearResults()
gg.clearResults()
gg.clearResults()
os.remove("/data/user/0/com.dts.freefireth/cache")
os.remove("/data/user/0/com.dts.freefireth/no_backup")
os.remove("/data/user/0/com.dts.freefireth/code_cache")
os.remove("/data/user/0/com.dts.freefireth/databases")
os.remove("/data/user/0/com.dts.freefireth/oat")
os.remove("/data/user/0/com.dts.freefireth/files/.com.google.firebase.crashlytics.files.v2:com.dts.freefireth")
os.remove("/data/user/0/com.dts.freefireth/files/AFRequestCache")
os.remove("/data/user/0/com.dts.freefireth/files/data")
os.remove("/data/user/0/com.dts.freefireth/files/app")
os.remove("/data/user/0/com.dts.freefireth/files/ano_tmp")
os.remove("/data/user/0/com.dts.freefireth/files/ace_shell_di.dat")
os.remove("/data/user/0/com.dts.freefireth/files/GGMEs.dump")
os.remove("/data/user/0/com.dts.freefireth/files/Deps.dump")
os.remove("/data/user/0/com.dts.freefireth/files/DSAs.dump")
os.remove("/data/user/0/com.dts.freefireth/files/GGMEs.version")
os.remove("/data/user/0/com.dts.freefireth/files/RMP.dump")
os.remove("/data/user/0/com.dts.freefireth/files/InitDump.version")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/cache")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/ImageCache")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/MReplays")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/ShaderStripSettings")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/record")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/Workshop")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/reportnew.db")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/ymrtc_log.txt")
os.remove("/storage/emulated/0/Android/data/com.dts.freefireth/files/ffrtc_log.txt")
os.remove("/data/user/0/com.dts.freefireth/files/datastore")
os.remove("/data/user/0/com.dts.freefireth/app_textures")
os.remove("/data/user/0/com.dts.freefireth/app_webview")
os.remove("/data/user/0/com.dts.freefireth/app_libs")
gg.clearResults()
gg.toast("Đã xoá log game")
end
function thoat()
  print("Goodbye see you later")
  print("                            ")
  print("                           ")
  print("Thank You For Using My Script ")
  print("Credit: HNhat")
  print("Telegram: t.me/lsModgaming (Loadstring Mod)                     ")
  os.exit()
end
while true do if gg.isVisible() then gg.setVisible(false) script() end end
